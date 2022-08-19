/*
 * MIT License
 *
 * Copyright (C) 2022 by wangwenx190 (Yuhang Zhao) and static-lib rework by blazorin (Alberto Romero)
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

#include "qtlottiedrawengine_rlottie.h"
#include <QtGui/qpainter.h>
#include <QtCore/qlibrary.h>
#include <QtCore/qdebug.h>
#include <QtCore/qfile.h>
#include <QtCore/qvariant.h>
#include <QtCore/qcoreapplication.h>

// rlottie includes
#include <Include/rlottie/headers/rlottie.h>
#include <Include/rlottie/headers/rlottie_capi.h>

static bool loadedOk = false;

static bool backendRunning = false;

using lottie_init_ptr = void(*)();
using lottie_shutdown_ptr = void(*)();
using lottie_animation_destroy_ptr = void(*)(Lottie_Animation *animation);
using lottie_animation_from_data_ptr = Lottie_Animation *(*)(const char *data, const char *key, const char *resource_path);
using lottie_animation_get_framerate_ptr = double(*)(const Lottie_Animation *animation);
using lottie_animation_get_totalframe_ptr = size_t(*)(const Lottie_Animation *animation);
using lottie_animation_render_ptr = void(*)(Lottie_Animation *animation, size_t frame_num, uint32_t *buffer, size_t width, size_t height, size_t bytes_per_line);
using lottie_animation_get_size_ptr = void(*)(const Lottie_Animation *animation, size_t *width, size_t *height);
using lottie_animation_get_duration_ptr = double(*)(const Lottie_Animation *animation);


class rlottie_data
{
    Q_DISABLE_COPY_MOVE(rlottie_data)

public:
    lottie_init_ptr lottie_init_pfn = nullptr;
    lottie_shutdown_ptr lottie_shutdown_pfn = nullptr;
    lottie_animation_destroy_ptr lottie_animation_destroy_pfn = nullptr;
    lottie_animation_from_data_ptr lottie_animation_from_data_pfn = nullptr;
    lottie_animation_get_framerate_ptr lottie_animation_get_framerate_pfn = nullptr;
    lottie_animation_get_totalframe_ptr lottie_animation_get_totalframe_pfn = nullptr;
    lottie_animation_render_ptr lottie_animation_render_pfn = nullptr;
    lottie_animation_get_size_ptr lottie_animation_get_size_pfn = nullptr;
    lottie_animation_get_duration_ptr lottie_animation_get_duration_pfn = nullptr;

    explicit rlottie_data()
    {
        //const bool result = load();
        //Q_UNUSED(result);
    }

    ~rlottie_data()
    {
        const bool result = unload();
        Q_UNUSED(result);
    }

    [[nodiscard]] bool load()
    {
        if (loadedOk) {
            qDebug() << "[INFO] rlottie library was already loaded. Skipping...";

            return true;
        }

        /**
         * reinterpret_cast is not needed anymore as it does no longer haves a QFunctionPointer (QLibrary).
         * only keeping it for safety
        **/

        lottie_init_pfn = reinterpret_cast<lottie_init_ptr>(&lottie_init); // empty function, do not worry

        if (!lottie_init_pfn) {
            qWarning() << "[WARNING] Failed to resolve lottie_init";
            return false;
        }
        else {
            qDebug() << "[INFO] rlottie library init call OK";
        }


        lottie_shutdown_pfn = reinterpret_cast<lottie_shutdown_ptr>(&lottie_shutdown);
        if (!lottie_shutdown_pfn) {
            qWarning() << "[WARNING] Failed to resolve lottie_shutdown";
        }

        lottie_animation_destroy_pfn = reinterpret_cast<lottie_animation_destroy_ptr>(&lottie_animation_destroy);
        if (!lottie_animation_destroy_pfn) {
            qWarning() << "[WARNING] Failed to resolve lottie_animation_destroy";
        }

        lottie_animation_from_data_pfn = reinterpret_cast<lottie_animation_from_data_ptr>(&lottie_animation_from_data);
        if (!lottie_animation_from_data_pfn) {
            qWarning() << "[WARNING] Failed to resolve lottie_animation_from_data";
        }

        lottie_animation_get_framerate_pfn = reinterpret_cast<lottie_animation_get_framerate_ptr>(&lottie_animation_get_framerate);
        if (!lottie_animation_get_framerate_pfn) {
            qWarning() << "[WARNING] Failed to resolve lottie_animation_get_framerate";
        }

        lottie_animation_get_totalframe_pfn = reinterpret_cast<lottie_animation_get_totalframe_ptr>(&lottie_animation_get_totalframe);
        if (!lottie_animation_get_totalframe_pfn) {
            qWarning() << "[WARNING] Failed to resolve lottie_animation_get_totalframe";
        }

        lottie_animation_render_pfn = reinterpret_cast<lottie_animation_render_ptr>(&lottie_animation_render);
        if (!lottie_animation_render_pfn) {
            qWarning() << "[WARNING] Failed to resolve lottie_animation_render";
        }

        lottie_animation_get_size_pfn = reinterpret_cast<lottie_animation_get_size_ptr>(&lottie_animation_get_size);
        if (!lottie_animation_get_size_pfn) {
            qWarning() << "[WARNING] Failed to resolve lottie_animation_get_size";
        }

        lottie_animation_get_duration_pfn = reinterpret_cast<lottie_animation_get_duration_ptr>(&lottie_animation_get_duration);
        if (!lottie_animation_get_duration_pfn) {
            qWarning() << "[WARNING] Failed to resolve lottie_animation_get_duration";
        }

        loadedOk = true;      
        return true;
    }

    [[nodiscard]] bool unload()
    {
        lottie_init_pfn = nullptr;
        lottie_shutdown_pfn = nullptr;
        lottie_animation_destroy_pfn = nullptr;
        lottie_animation_from_data_pfn = nullptr;
        lottie_animation_get_framerate_pfn = nullptr;
        lottie_animation_get_totalframe_pfn = nullptr;
        lottie_animation_render_pfn = nullptr;
        lottie_animation_get_size_pfn = nullptr;
        lottie_animation_get_duration_pfn = nullptr;

        return true;
    }

    [[nodiscard]] bool isLoaded() const
    {
        return  loadedOk && lottie_init_pfn
                && lottie_shutdown_pfn && lottie_animation_destroy_pfn
                && lottie_animation_from_data_pfn && lottie_animation_get_framerate_pfn
                && lottie_animation_get_totalframe_pfn && lottie_animation_render_pfn
                && lottie_animation_get_size_pfn && lottie_animation_get_duration_pfn;
    }

};

Q_GLOBAL_STATIC(rlottie_data, rlottiefuncs)

QtLottieRLottieEngine::QtLottieRLottieEngine(QObject *parent) : QtLottieDrawEngine(parent)
{
    const bool result = rlottiefuncs()->load();
    Q_UNUSED(result);

    if (rlottiefuncs()->isLoaded()) {

        rlottiefuncs()->lottie_init_pfn();

        if (!backendRunning) {
            qDebug() << "[INFO] rlottie library successfully loaded!";
        }

        backendRunning = true; // Avoid showing above message multiple times
    } else {
        if (!backendRunning) {
            qWarning() << "[WARNING] rlottie library not loaded.";
        }
    }
}

QtLottieRLottieEngine::~QtLottieRLottieEngine()
{
    if (m_animation && rlottiefuncs()->lottie_animation_destroy_pfn) {
        rlottiefuncs()->lottie_animation_destroy_pfn(m_animation);
    }
    if (rlottiefuncs()->lottie_shutdown_pfn) {
        rlottiefuncs()->lottie_shutdown_pfn();
    }
}

bool QtLottieRLottieEngine::setSource(const QUrl &value)
{
    Q_ASSERT(rlottiefuncs()->lottie_animation_from_data_pfn);
    Q_ASSERT(rlottiefuncs()->lottie_animation_get_framerate_pfn);
    Q_ASSERT(rlottiefuncs()->lottie_animation_get_totalframe_pfn);
    Q_ASSERT(rlottiefuncs()->lottie_animation_get_size_pfn);
    Q_ASSERT(rlottiefuncs()->lottie_animation_get_duration_pfn);
    if (!rlottiefuncs()->lottie_animation_from_data_pfn || !rlottiefuncs()->lottie_animation_get_framerate_pfn
            || !rlottiefuncs()->lottie_animation_get_totalframe_pfn || !rlottiefuncs()->lottie_animation_get_size_pfn
            || !rlottiefuncs()->lottie_animation_get_duration_pfn) {
        qWarning() << "[WARNING] " << Q_FUNC_INFO << "some necessary rlottie functions are not available.";
        return false;
    }
    Q_ASSERT(value.isValid());
    if (!value.isValid()) {
        qWarning() << "[WARNING] " << value << "is not a valid URL.";
        return false;
    }
    if (m_source == value) {
        // debug output?
        return false; // or true?
    }
    QString jsonFilePath = {};
    if (value.scheme() == QStringLiteral("qrc")) {
        jsonFilePath = value.toString();
        // QFile can't recognize url.
        jsonFilePath.replace(QStringLiteral("qrc:"), QStringLiteral(":"), Qt::CaseInsensitive);
        jsonFilePath.replace(QStringLiteral(":///"), QStringLiteral(":/"));
    } else {
        jsonFilePath = value.isLocalFile() ? value.toLocalFile() : value.url();
    }
    Q_ASSERT(QFile::exists(jsonFilePath));
    if (!QFile::exists(jsonFilePath)) {
        qWarning() << "[WARNING] " << jsonFilePath << "doesn't exist.";
        return false;
    }
    QFile file(jsonFilePath);
    if (!file.open(QFile::ReadOnly | QFile::Text)) {
        qWarning() << "[WARNING] Failed to open the JSON file:" << jsonFilePath;
        return false;
    }
    const QByteArray jsonBuffer = file.readAll();
    file.close();
    if (jsonBuffer.isEmpty()) {
        qWarning() << "[WARNING] File is empty:" << jsonFilePath;
        return false;
    }
    // TODO: support embeded resources.
    const QString resDirPath = QCoreApplication::applicationDirPath();
    m_animation = rlottiefuncs()->lottie_animation_from_data_pfn(jsonBuffer.constData(), jsonBuffer.constData(), resDirPath.toUtf8().constData());
    if (!m_animation) {
        qWarning() << "[WARNING] Failed to create lottie animation.";
        return false;
    }
    m_source = value;
    rlottiefuncs()->lottie_animation_get_size_pfn(m_animation, reinterpret_cast<size_t *>(&m_width), reinterpret_cast<size_t *>(&m_height));
    m_frameRate = rlottiefuncs()->lottie_animation_get_framerate_pfn(m_animation);
    m_duration = rlottiefuncs()->lottie_animation_get_duration_pfn(m_animation);
    m_totalFrame = rlottiefuncs()->lottie_animation_get_totalframe_pfn(m_animation);
    m_frameBuffer.reset(new char[m_width * m_height * 32 / 8]);
    // Clear previous status.
    m_currentFrame = 0;
    m_loopTimes = 0;
    m_shouldStop = false;
    Q_EMIT sourceChanged(m_source);
    Q_EMIT sizeChanged(size());
    Q_EMIT frameRateChanged(m_frameRate);
    Q_EMIT durationChanged(m_duration);
    Q_EMIT playingChanged(true);
    return true;
}

qreal QtLottieRLottieEngine::frameRate() const
{
    return m_frameRate;
}

qreal QtLottieRLottieEngine::duration() const
{
    return m_duration;
}

QSizeF QtLottieRLottieEngine::size() const
{
    return {static_cast<qreal>(m_width), static_cast<qreal>(m_height)};
}

int QtLottieRLottieEngine::loops() const
{
    return m_loops;
}

void QtLottieRLottieEngine::setLoops(const int value)
{
    if (m_loops != value) {
        m_loops = value;
        Q_EMIT loopsChanged(m_loops);
        // Also clear previous status.
        m_loopTimes = 0;
        m_shouldStop = false;
        Q_EMIT playingChanged(true);
    }
}

bool QtLottieRLottieEngine::available() const
{
    return rlottiefuncs()->isLoaded();
}

bool QtLottieRLottieEngine::playing() const
{
    return (m_animation && !m_shouldStop);
}

void QtLottieRLottieEngine::pause()
{
    if (m_animation && !m_shouldStop) {
        m_shouldStop = true;
        Q_EMIT playingChanged(false);
    }
}

void QtLottieRLottieEngine::resume()
{
    if (m_animation && m_shouldStop) {
        m_shouldStop = false;
        Q_EMIT playingChanged(true);
    }
}

void QtLottieRLottieEngine::paint(QPainter *painter, const QSizeF &s)
{
    Q_ASSERT(painter);
    if (!painter) {
        return;
    }
    Q_ASSERT(s.isValid());
    if (!s.isValid()) {
        qWarning() << "[WARNING] " << s << "is not a valid size.";
        return;
    }
    if (!m_animation) {
        // lottie animation is not created, mostly due to setSource() not called.
        // Or the rlottie library is not loaded. Safe to ignore.
        return;
    }
    if (m_shouldStop) {
        return;
    }
    if (!m_hasFirstUpdate) {
        return;
    }
    QImage image(m_width, m_height, QImage::Format_ARGB32);
    for (int i = 0; i != image.height(); ++i) {
        char *p = m_frameBuffer.data() + i * image.bytesPerLine();
        memcpy(image.scanLine(i), p, image.bytesPerLine());
    }
    // TODO: let the user be able to set the scale mode.
    // "Qt::SmoothTransformation" is a must otherwise the scaled image will become fuzzy.
    painter->drawImage(QPointF{0, 0}, (s == size()) ? image : image.scaled(s.toSize(), Qt::IgnoreAspectRatio, Qt::SmoothTransformation));
}

void QtLottieRLottieEngine::render(const QSizeF &s)
{
    Q_UNUSED(s);
    if (!m_animation) {
        // lottie animation is not created, mostly due to setSource() not called.
        // Or the rlottie library is not loaded. Safe to ignore.
        return;
    }
    Q_ASSERT(rlottiefuncs()->lottie_animation_render_pfn);
    if (!rlottiefuncs()->lottie_animation_render_pfn) {
        qWarning() << "[WARNING] " << Q_FUNC_INFO << "some necessary rlottie functions are not available.";
        return;
    }
    if (m_shouldStop) {
        return;
    }
    rlottiefuncs()->lottie_animation_render_pfn(m_animation, m_currentFrame, reinterpret_cast<uint32_t *>(m_frameBuffer.data()), m_width, m_height, m_width * 32 / 8);
    if (m_currentFrame >= m_totalFrame) {
        m_currentFrame = 0;
        // negative number means infinite loops.
        if (m_loops > 0) {
            ++m_loopTimes;
            if (m_loopTimes >= m_loops) {
                m_loopTimes = 0;
                m_shouldStop = true;
                Q_EMIT playingChanged(false);
                return;
            }
        }
    } else {
        ++m_currentFrame;
    }
    m_hasFirstUpdate = true;
    Q_EMIT needsRepaint();
}

void QtLottieRLottieEngine::release()
{
    delete this;
}

QString QtLottieRLottieEngine::name() const
{
    return QStringLiteral("rlottie");
}

QUrl QtLottieRLottieEngine::source() const
{
    return m_source;
}
