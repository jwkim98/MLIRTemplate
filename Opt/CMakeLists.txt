get_property(dialect_libs GLOBAL PROPERTY MLIR_DIALECT_LIBS)
get_property(conversion_libs GLOBAL PROPERTY MLIR_CONVERSION_LIBS)
set(LIBS
        ${dialect_libs}
        ${conversion_libs}
        MLIRArithmeticDialect
        MLIROptLib
        MLIRExample
        )
add_llvm_executable(ExampleOpt ExampleOpt.cpp)

llvm_update_compile_flags(ExampleOpt)
target_link_libraries(ExampleOpt PRIVATE ${LIBS})

mlir_check_all_link_libraries(ExampleOpt)
