#pragma once

#include <sstream>
#include <iostream>
#include <memory>
#include <atomic>

#define LOG(level, ...) BaseLog::BaseLog::Instance().Log(level, __VA_ARGS__)

namespace BaseLog {
enum LogLevel {
    Trace = -2,
    Debug = -1,
    Info = 0,
    Warning = 1,
    Error = 2,
    Fatal = 3
};

class BaseLog {
public:
    static BaseLog &Instance() {
        static BaseLog ins;
        return ins;
    }

    static void InitLogging(const std::string &name,
                            LogLevel threshold = LogLevel::Info,
                            const std::string &logDir = "");

    static void ShutdownLogging();

    static void InstallFailureSignalHandler(const char *argv0,
                                            bool call_previous_handler = false);
    
    static void UninstallSignalHandler();

    template<typename... Args>
    void Log(LogLevel level, const std::string &fmtString, Args &&...args) {
        int len = std::snprintf(nullptr, 0, fmtString.c_str(), args ...) + 1;
        if (len <= 0) {
            return;
        }

        auto size = static_cast<size_t>( len );
        std::unique_ptr<char[]> buf(new char[size]);
        std::snprintf(buf.get(), size, fmtString.c_str(), args ...);
        LogInternal(level, std::string(buf.get(), buf.get() + size - 1));
    }

    void Log(LogLevel level, const std::string &message) {
        LogInternal(level, message);
    }

private:
    BaseLog() = default;

    ~BaseLog() = default;

    void LogInternal(LogLevel level, const std::string &message);
    
    std::string name_;
    std::string logDir_;

    std::atomic<bool> initialized;
    bool failureSignalHandlerInstalled_;
};

}
