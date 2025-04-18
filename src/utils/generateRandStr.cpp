
#include "logger.h"
#include <ctime>
#include <cstdlib>

std::string generateRandStr(int length)
{
    const char charset[] = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789";
    std::string random_str;
    std::srand(std::time(0));

    for (int i = 0; i < length; ++i)
    {
        random_str += charset[std::rand() % (sizeof(charset) - 1)];
    }

    return random_str;
}