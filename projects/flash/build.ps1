# config env variable
$env:STM32_TOOLCHAIN_PATH="D:\toolchains\arm-gnu-toolchain-13.2.Rel1-mingw-w64-i686-arm-none-eabi"
$env:STM32_TARGET_TRIPLET="arm-none-eabi"
$env:STM32_CUBE_F1_PATH="..\..\stm32cube\STM32CubeF1-1.8.5"

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

# defibe function
function buildClangdConfig {
    [CmdletBinding()]
    param (
        [string]$ConfigFilePath, 
        [string]$ConfigContent
    )

    $FileExist = Test-Path -Path $ConfigFilePath
    if(-not ($FileExist))
    {
        New-Item $ConfigFilePath
    }
    Set-Content $ConfigFilePath -value $ConfigContent
}

# set .clangd for clangd server
$CurrentClangdConfigFile = ".clangd"
$STM32CubeClangdConfigFile = "../../stm32cube/STM32CubeF1-1.8.5/.clangd"
$ClangdConfigContent = "CompileFlags:
  CompilationDatabase: >-
    $BuildPath";

buildClangdConfig -ConfigFilePath $CurrentClangdConfigFile -ConfigContent $ClangdConfigContent
buildClangdConfig -ConfigFilePath $STM32CubeClangdConfigFile -ConfigContent $ClangdConfigContent

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
