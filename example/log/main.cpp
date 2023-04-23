#include <iostream>

#include "logging.h"

int main(int argc, char *argv[]) {
    LOG(BaseLog::LogLevel::Info, "default log with integer %d", 1);

    abort();

    return 0;
}