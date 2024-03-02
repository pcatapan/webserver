#include "../../include/method.hpp"

_Put::_Put(request &_request)
{
    std::string buffer;
    std::string body;
    std::string filename;
    std::ofstream outFile;
    std::ifstream inFile;
    filename.append(CREATE_SUCCESS_FILE);

    std::map<std::string, std::string> tmp = _request.getContent_Type();
    if (tmp["type"].compare("multipart/form-data") == 0)
    {
        std::vector<std::pair<std::string, std::string> > file = _request.getReqBody();
        std::vector<std::pair<std::string, std::string> >::iterator file_It = file.begin();
        while (file_It != file.end())
        {
            filename.clear();
            filename.append(_request.getUpload_store_PATH());
            struct stat statInfo;
            if (stat(filename.c_str(), &statInfo) != 0){
               filename.clear();
               filename.append(UPLOAD_STORE);
            }
            filename.append("/");
            filename.append((*file_It).first);
            // std::cout <<" abs path to the file created :" << filename << std::endl;
            outFile.open(filename.c_str(), std::ifstream::out);
            if (!outFile.is_open()){ // cant open this file  Internal Server Error
               throw _Exception(INTERNAL_SERVER_ERROR);
            }
            outFile << file_It[0].second;
            outFile.close();
            ++file_It;
        }
        if (file_It == file.end()){
            this->setStatus(CREATED);
            filename.clear();
            filename.append(CREATE_SUCCESS_FILE);
            body.clear();
            std::stringstream ssbuf;
            inFile.open(filename.c_str(), std::ifstream::in);
            ssbuf << inFile.rdbuf();
            body.append(ssbuf.str());
            inFile.close();
        }
    }
    else
        throw _Exception(INTERNAL_SERVER_ERROR);
    this->setResponseBody(body);
    this->execute_method(_request);
}

_Put::~_Put(){}

int _Put::execute_method(request _request)
{
    (void)_request;
    this->addHeader("Content-Type",Assets::__getType("html"));
    this->addHeader("Content-Length", ft_to_string(this->getResponseBody().length()));
    return true;
}