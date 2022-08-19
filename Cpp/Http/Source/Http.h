#pragma once

#include "../../Include/rest-cpp/include/restc-cpp/restc-cpp.h"
#include "../../Include/rest-cpp/include/restc-cpp/RequestBuilder.h"
#include <future>
#include <string>
#include <map>

using namespace restc_cpp;

enum class HttpMethod {
    Get,
    Post
};

class Http {
    HttpMethod method;
    std::string optionalJsonPayload;
    std::string optionalJwtBearer;
    std::map<std::string, std::string> queryParams;

    //static std::unique_ptr<RestClient> client;

public:

    bool Created = false;
    std::string uri;

    //std::string FinalResponse;

    std::string WebRequest();
    Http(std::string uri, HttpMethod method, std::map<std::string, std::string> queryParams = {}, std::string optionalJsonPayload = "", std::string optionalJwtBearer = "");
};
