add_mlir_dialect_library(MLIRExample
        ExampleDialect.cpp
        ExampleOps.cpp

        ADDITIONAL_HEADER_DIRS
        ${PROJECT_SOURCE_DIR}/include/Example

        DEPENDS
        MLIRExampleOpsIncGen

        LINK_LIBS PUBLIC
        MLIRIR
        MLIRInferTypeOpInterface
        )