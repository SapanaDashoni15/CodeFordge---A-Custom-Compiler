// #include "symbol_table.hpp"
#include <stdexcept>

void SymbolTable::declare(const std::string& name, int value) {
    table[name] = value;
}

bool SymbolTable::isDeclared(const std::string& name) const {
    return table.find(name) != table.end();
}

int SymbolTable::getValue(const std::string& name) const {
    auto it = table.find(name);
    if (it == table.end()) throw std::runtime_error("Undeclared variable: " + name);
    return it->second;
}
