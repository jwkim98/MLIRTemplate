add_mlir_public_c_api_library(ExampleCAPI
        Dialects.cpp
        LINK_LIBS PUBLIC
        MLIRExample
        )
