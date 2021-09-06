set(LIBRARY ${CMAKE_PROJECT_NAME}_lib)

find_program(GCOV_PATH gcov)
add_library(${LIBRARY} STATIC "")

target_compile_options(${LIBRARY} PRIVATE $<$<CONFIG:Debug>:--coverage>)
target_link_libraries(${LIBRARY} PRIVATE $<$<CONFIG:Debug>:gcov>)

add_subdirectory(controller)
