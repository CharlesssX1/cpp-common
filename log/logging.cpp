#include "logging.h"

#include <memory>
#include <csignal>
#include <string>

#include "absl/debugging/symbolize.h"
#include "absl/debugging/failure_signal_handler.h"
#include "spdlog/spdlog.h"
#include "spdlog/sinks/rotating_file_sink.h"
#include "spdlog/sinks/stdout_color_sinks.h"

namespace {
const size_t ROTATION_BYTES_SIZE = 10 * 1024 * 1024;
const size_t ROTATION_FILE_NUM = 5;
std::unordered_map<BaseLog::LogLevel, spdlog::level::level_enum> levelMap = {
    {BaseLog::LogLevel::Trace, spdlog::level::trace},
    {BaseLog::LogLevel::Debug, spdlog::level::debug},
    {BaseLog::LogLevel::Info, spdlog::level::info},
    {BaseLog::LogLevel::Warning, spdlog::level::warn},
    {BaseLog::LogLevel::Error, spdlog::level::err},
    {BaseLog::LogLevel::Fatal, spdlog::level::critical}
};

}

namespace BaseLog {
std::string GetLoggingFile(const std::string &dir, const std::string &name) {
    std::string fileName = name + "_" + std::to_string(getpid()) + ".log";
    if (dir.empty()) {
        return fileName;
    }
    if (dir[dir.size() - 1] == '/') {
        return dir + fileName;
    }
    return dir + "/" + fileName;
}

class DefaultLogger final {
public:
    static DefaultLogger &Instance() {
        static DefaultLogger ins;
        return ins;
    }

    std::shared_ptr<spdlog::logger> GetDefaultLogger() {
        return defaultLogger_;
    }

private:
    DefaultLogger() {
        defaultLogger_ = spdlog::stderr_color_mt("stderr");
    }

    ~DefaultLogger() = default;

    DefaultLogger(DefaultLogger const &) = delete;

    DefaultLogger(DefaultLogger &&) = delete;

    std::shared_ptr<spdlog::logger> defaultLogger_;
};

void BaseLog::InitLogging(const std::string &name, LogLevel threshold, const std::string &logDir) {
    Instance().name_ = name;
    Instance().logDir_ = logDir;

    if (spdlog::get(name) != nullptr) {
        spdlog::drop(name);
    }

    std::vector<spdlog::sink_ptr> sinks;
    auto level = static_cast<spdlog::level::level_enum>(threshold);

    if (!logDir.empty() && !name.empty()) {
        auto loggingFile = GetLoggingFile(logDir, name);
        auto fileLogger = std::make_shared<spdlog::sinks::rotating_file_sink_mt>(loggingFile, ROTATION_BYTES_SIZE, ROTATION_FILE_NUM);
        fileLogger->set_level(level);
        sinks.emplace_back(fileLogger);
    }
#ifndef WITHOUT_CONSOLE_LOGGER
    auto consoleLogger = std::make_shared<spdlog::sinks::stdout_color_sink_mt>();
    consoleLogger->set_level(level);
    sinks.emplace_back(consoleLogger);
#endif

    auto logger = std::make_shared<spdlog::logger>(Instance().name_, sinks.begin(), sinks.end());
    logger->set_level(level);
    spdlog::set_default_logger(logger);
    Instance().initialized_ = true;
}

void BaseLog::ShutdownLogging() {
    if (!Instance().initialized_) {
        return;
    }

    if (spdlog::default_logger()) {
        spdlog::default_logger()->flush();
    }
    Instance().initialized_ = false;
}

void BaseLog::InstallFailureSignalHandler(const char *argv0, bool call_previous_handler) {
    if (Instance().failureSignalHandlerInstalled_) {
        return;
    }
    absl::InitializeSymbolizer(argv0);
    absl::FailureSignalHandlerOptions options;
    options.call_previous_handler = call_previous_handler;
    options.writerfn = [](const char *data) {
        if (spdlog::default_logger()) {
            spdlog::default_logger()->flush();
        }
    };
    absl::InstallFailureSignalHandler(options);
    Instance().failureSignalHandlerInstalled_ = true;
}

void BaseLog::UninstallSignalHandler() {
    if (!Instance().failureSignalHandlerInstalled_) {
        return;
    }

    std::vector<int> installed_signals({SIGSEGV, SIGILL, SIGFPE, SIGABRT, SIGTERM});
    struct sigaction sigAction;
    memset(&sigAction, 0, sizeof(sigAction));
    sigemptyset(&sigAction.sa_mask);
    sigAction.sa_handler = SIG_DFL;
    for (int signal_num: installed_signals) {
        sigaction(signal_num, &sigAction, nullptr);
    }
    Instance().failureSignalHandlerInstalled_ = false;
}

void BaseLog::LogInternal(LogLevel level, const std::string &message) {
    if (initialized_) {
        spdlog::get(name_)->log(spdlog::source_loc{__FILE__, __LINE__, __FUNCTION__}, levelMap[level], message);
        return;
    }
    auto logger = DefaultLogger::Instance().GetDefaultLogger();
    logger->log(spdlog::source_loc{__FILE__, __LINE__, __FUNCTION__}, levelMap[level], message);
    logger->flush();
}
}