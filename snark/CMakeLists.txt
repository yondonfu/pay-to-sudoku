include_directories(.)

add_library(mysnark SHARED sha256.c lib.cpp)

target_link_libraries(mysnark snark)

set_property(TARGET mysnark PROPERTY POSITION_INDEPENDENT_CODE ON)

target_include_directories(
    mysnark
    PUBLIC
    ${DEPENDS_DIR}/libsnark
    ${DEPENDS_DIR}/libsnark/depends/libff
    ${DEPENDS_DIR}/libsnark/depends/libfqfft
)