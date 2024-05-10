cmake_minimum_required(VERSION 3.16)
set(CMAKE_TOOLCHAIN_FILE ${CMAKE_CURRENT_SOURCE_DIR}/../../cmake/stm32_gcc.cmake)

project(stm32-flash VERSION 1.0.0 LANGUAGES C ASM)

# export compile command
set(CMAKE_EXPORT_COMPILE_COMMANDS ON)

list(APPEND CMSIS_COMP_LIST STM32F1)
list(APPEND HAL_COMP_LIST STM32F1)
find_package(CMSIS COMPONENTS "${CMSIS_COMP_LIST}" REQUIRED)
find_package(HAL COMPONENTS "${HAL_COMP_LIST}" REQUIRED)

# Find CMSIS for all F1 devices:
# find_package(CMSIS COMPONENTS STM32F1 REQUIRED)
# Find CMSIS for all devices:
# find_package(CMSIS REQUIRED)
# Find everything:
# find_package(HAL REQUIRED)
set(PROJECT_SOURCES
    main.c
)

add_executable(${PROJECT_NAME} ${PROJECT_SOURCES})
target_include_directories(${PROJECT_NAME} PRIVATE ${CMAKE_CURRENT_SOURCE_DIR})

target_link_libraries(${PROJECT_NAME}
    HAL::STM32::F1::RCC
    HAL::STM32::F1::GPIO
    HAL::STM32::F1::CORTEX
    HAL::STM32::F1::SPI
    HAL::STM32::F1::RTC
    HAL::STM32::F1::UART
    CMSIS::STM32::F103C8
    # STM32::NoSys
    STM32::Nano
)

stm32_print_size_of_target(${PROJECT_NAME})
