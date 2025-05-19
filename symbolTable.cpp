#pragma once
#include <string>
#include <unordered_map>

class SymbolTable {
public:
    void declare(const std::string& name, int value);
    bool isDeclared(const std::string& name) const;
    int getValue(const std::string& name) const;

private:
    std::unordered_map<std::string, int> table;
};
