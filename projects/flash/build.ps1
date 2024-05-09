# config env variable
./path_helper.ps1

# Set build directory path
$BuildPath = "../../build/projects/flash"

# make build directory
if (Test-Path -Path $BuildPath) {
    # clean history build
    Remove-Item -Recurse -Force $BuildPath/*
}
else {
    mkdir -p $BuildPath
}

# Get current source directiory
$CurrentPath = Get-Location
# Write-Output $CurrentPath

# cd build directory
Set-Location $BuildPath

# cmake config
cmake -G"Ninja" $CurrentPath -DCMAKE_BUILD_TYPE=Debug 
# -DSTM32_TARGET_TRIPLET=arm-none-eabi -DSTM32_TOOLCHAIN_PATH="D:\toolchains\arm-gnu-toolchain-13.2.Rel1-mingw-w64-i686-arm-none-eabi"

# cmake build
cmake --build .

# return source dir
Set-Location $CurrentPath
