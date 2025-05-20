#include "../include/ast.hpp"
#include <llvm/IR/LLVMContext.h>
#include <llvm/IR/IRBuilder.h>
#include <llvm/IR/Module.h>
#include <stdexcept>

extern llvm::LLVMContext context;
extern llvm::IRBuilder<> builder;
extern std::unique_ptr<llvm::Module> module;

// Global variable for code generation (in actual projects you'd use context passing)
std::map<std::string, llvm::Value*> namedValues;

llvm::Value* NumberNode::codegen() {
    return llvm::ConstantInt::get(llvm::Type::getInt32Ty(context), value);
}

llvm::Value* VariableNode::codegen() {
    llvm::Value* val = namedValues[name];
    if (!val) throw std::runtime_error("Unknown variable name: " + name);
    return val;
}

llvm::Value* BinaryOpNode::codegen() {
    llvm::Value* L = lhs->codegen();
    llvm::Value* R = rhs->codegen();
    if (!L || !R) return nullptr;

    switch (op) {
        case '+': return builder.CreateAdd(L, R, "addtmp");
        case '-': return builder.CreateSub(L, R, "subtmp");
        case '*': return builder.CreateMul(L, R, "multmp");
        case '/': return builder.CreateSDiv(L, R, "divtmp");
        default: return nullptr;
    }
}