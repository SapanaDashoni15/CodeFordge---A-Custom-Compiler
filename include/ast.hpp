#pragma once
#include <string>
#include <memory>
#include <llvm/IR/Value.h>

class ASTNode {
public:
    virtual ~ASTNode() = default;
    virtual llvm::Value* codegen() = 0;
};

class NumberNode : public ASTNode {
    int value;
public:
    NumberNode(int val) : value(val) {}
    llvm::Value* codegen() override;
};

class VariableNode : public ASTNode {
    std::string name;
public:
    VariableNode(const std::string& n) : name(n) {}
    llvm::Value* codegen() override;
};

class BinaryOpNode : public ASTNode {
    char op;
    std::unique_ptr<ASTNode> lhs, rhs;
public:
    BinaryOpNode(char o, std::unique_ptr<ASTNode> l, std::unique_ptr<ASTNode> r)
        : op(o), lhs(std::move(l)), rhs(std::move(r)) {}
    llvm::Value* codegen() override;
};
