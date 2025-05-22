#include "symbolTable.hpp"
#include <string>       // FIX: Needed for std::string
#include <stdexcept>    // FIX: Needed for std::runtime_error

void SymbolTable::declare(const std::string& name, int value) {
    table[name] = value;
}

bool SymbolTable::isDeclared(const std::string& name) const {
    return table.find(name) != table.end();
}

int SymbolTable::getValue(const std::string& name) const {
    auto it = table.find(name);
    if (it == table.end()) {
        throw std::runtime_error("Undeclared variable: " + name);
    }
    return it->second;
}
