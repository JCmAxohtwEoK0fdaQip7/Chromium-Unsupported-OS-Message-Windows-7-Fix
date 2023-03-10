function warning-enable { REG ADD "HKLM\SOFTWARE\Policies\Google\Chrome" /v SuppressUnsupportedOSWarning /t REG_DWORD /d 00000000 /f }
function warning-disable { REG ADD "HKLM\SOFTWARE\Policies\Google\Chrome" /v SuppressUnsupportedOSWarning /t REG_DWORD /d 00000001 /f }
function test-registry {
$key1 = Get-ItemProperty -path "HKLM:\SOFTWARE\Policies\Google\Chrome" -Name "SuppressUnsupportedOSWarning" | select-object -ExpandProperty SuppressUnsupportedOSWarning
if ($key1 -ne 0) {
$global:status = "No"
}
Else { $global:status = "Yes"
}}
function text-message { 
Clear-host
Write-Host "Is Chromium Unsupported OS Warning active?: $global:$status"
Write-Host "Enter 1 to enable     " 
Write-Host "      2 to disable    " }
$ErrorActionPreference= 'silentlycontinue'
$continue = $true
while($continue)
{
test-registry
text-message
$selection = Read-Host
switch ($selection)
{
'1' { warning-enable } 
'2' { warning-disable } 
}}
