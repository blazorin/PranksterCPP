/*
 * MIT License
 *
 * Copyright (C) 2021 by wangwenx190 (Yuhang Zhao)
 *
 * Permission is hereby granted, free of charge, to any person obtaining a copy
 * of this software and associated documentation files (the "Software"), to deal
 * in the Software without restriction, including without limitation the rights
 * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 * copies of the Software, and to permit persons to whom the Software is
 * furnished to do so, subject to the following conditions:
 *
 * The above copyright notice and this permission notice shall be included in
 * all copies or substantial portions of the Software.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
 * SOFTWARE.
 */

#include "qtlottieitem.h"
#include "qtlottiedrawengine.h"
#include "qtlottiedrawenginefactory.h"
#include <QtCore/qdebug.h>

QtLottieItem::QtLottieItem(QQuickItem *parent) : QQuickPaintedItem(parent)
{
    // Only rlottie supported

    m_drawEngine = QtLottieDrawEngineFactory::create("rlottie");
    if (!available()) {
          qWarning() << "[ERROR] Failed to initialize the rlottie backend.";

          dispose();
          return;
        }

    // Use "Qt::PreciseTimer" to get the best appearance, however, it
    // will have a performance impact.
    m_timer.setTimerType(Qt::CoarseTimer);
    connect(&m_timer, &QTimer::timeout, this, [this](){
        if (m_drawEngine->playing()) {
#if (QT_VERSION >= QT_VERSION_CHECK(5, 10, 0))
            const QSizeF s = size();
#else
            const QSizeF s = {width(), height()};
#endif
            m_drawEngine->render(s);
        }
    });
    connect(m_drawEngine, &QtLottieDrawEngine::needsRepaint, this, [this](){
        update();
    });
    connect(m_drawEngine, &QtLottieDrawEngine::frameRateChanged, this, [this](qreal arg){
        if (m_timer.isActive()) {
            m_timer.stop();
        }
        m_timer.setInterval(qRound(1000.0 / arg));
        if (m_drawEngine->playing()) {
            m_timer.start();
        }
        Q_EMIT frameRateChanged(arg);
    });
    connect(m_drawEngine, &QtLottieDrawEngine::playingChanged, this, [this](bool arg){
        if (arg) {
            if (!m_timer.isActive()) {
                if (m_timer.interval() <= 0) {
                    m_timer.setInterval(qRound(1000.0 / m_drawEngine->frameRate()));
                }
                m_timer.start();
            }
        } else {
            if (m_timer.isActive()) {
                m_timer.stop();
            }
        }
    });
    connect(m_drawEngine, &QtLottieDrawEngine::durationChanged, this, &QtLottieItem::durationChanged);
    connect(m_drawEngine, &QtLottieDrawEngine::sizeChanged, this, &QtLottieItem::sourceSizeChanged);
    connect(m_drawEngine, &QtLottieDrawEngine::loopsChanged, this, &QtLottieItem::loopsChanged);
}

QtLottieItem::~QtLottieItem()
{
    dispose();
}

void QtLottieItem::paint(QPainter *painter)
{
    Q_ASSERT(painter);
    if (!painter) {
        return;
    }
    if (available()) {
#if (QT_VERSION >= QT_VERSION_CHECK(5, 10, 0))
        const QSizeF s = size();
#else
        const QSizeF s = {width(), height()};
#endif
        m_drawEngine->paint(painter, s);
    }
}

void QtLottieItem::dispose()
{
    if (m_timer.isActive()) {
        m_timer.stop();
    }
    if (m_drawEngine) {
        m_drawEngine->release();
        m_drawEngine = nullptr;
    }
}

void QtLottieItem::pause()
{
    if (available()) {
        m_drawEngine->pause();

        //m_drawEngine->
    }
}

void QtLottieItem::resume()
{
    if (available()) {
        m_drawEngine->resume();
    }
}

QString QtLottieItem::backend() const
{
    return available() ? m_drawEngine->name() : QStringLiteral("Unknown");
}

QUrl QtLottieItem::source() const
{
    return m_source;
}

void QtLottieItem::setSource(const QUrl &value)
{
    if (!value.isValid()) {
        qWarning() << "[WARNING] " << value << "is not a valid URL.";
        return;
    }
    if (m_source != value) {
        m_source = value;
        if (available()) {
            if (!m_drawEngine->setSource(value)) {
                qWarning() << "[WARNING] " << "Failed to start playing.";
            }
        }
        Q_EMIT sourceChanged(m_source);
    }
}

qreal QtLottieItem::frameRate() const
{
    // TODO: is the fallback value appropriate?
    return available() ? m_drawEngine->frameRate() : 30.0;
}

qreal QtLottieItem::duration() const
{
    // TODO: is the fallback value appropriate?
    return available() ? m_drawEngine->duration() : 0.0;
}

QSizeF QtLottieItem::sourceSize() const
{
    // TODO: is the fallback value appropriate?
    return available() ? m_drawEngine->size() : QSizeF{50.0, 50.0};
}

int QtLottieItem::loops() const
{
    return available() ? m_drawEngine->loops() : 0;
}

void QtLottieItem::setLoops(const int value)
{
    if (available()) {
        m_drawEngine->setLoops(value);
    }
}

bool QtLottieItem::available() const
{
    return (m_drawEngine && m_drawEngine->available());
}
