﻿#
# Copyright (c) Microsoft. All rights reserved.
# Licensed under the MIT license. See LICENSE.md file in the project root for full license information.
#

function FunctionIntro(
    [Parameter(Mandatory = $true)][hashtable] $table
)
{
    $table | Out-String | Write-Verbose
}

function GetKey(
    [string] $validChar
)
{
    do {
        $key = Read-Host
    } until ($key -match $validChar)

    return $key
}

function DisplayStart()
{
    Write-Host "

This script will setup the CNTK prequisites and the CNTK Python environment onto the machine.
More help is given by calling get-help .\installer.ps1

The script will analyse your machine and will determine which components are required. 
The required components will be downloaded in [$localCache]
Repeated operation of this script will reuse already downloaded components.

- If required VS2012 Runtime and VS2013 Runtime will be installed
- If required MSMPI will be installed
- If required the Git-tool will be installed
- CNTK source will be downloaded in [c:\repos\cntk]
- Anaconda3 will be installed into [$AnacondaBasePath]
- A CNTK-PY34 environment will be created in [$AnacondaBasePath\envs]


1 - I agree and want to contiue
Q - Quit the installation process
"

    $choice = GetKey '^[1qQ]+$'

    if ($choice -contains "1") {
        return $true
    }

    return $false
}


Function DisplayEnd() 
{
if (-not $Execute) { return }

Write-Host "

CNTK v2 Python install complete.

To activate the CNTK Python environment and set the PATH to include CNTK, start a command shell and run
   $cntkRootDir\scripts\cntkpy34.bat


Please checkout examples in the CNTK repository clone here:
    c:\repos\cntk\bindings\python\examples

"
}

