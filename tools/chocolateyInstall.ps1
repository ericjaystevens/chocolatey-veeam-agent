Function Get-ExplorerProcessCount
{
  $process = Get-Process explorer -ErrorAction SilentlyContinue
  $processCount = ($process | Measure-Object).Count
  return $processCount
}

$initialProcessCount = Get-ExplorerProcessCount
Write-Warning "This installer is known to close the explorer process. This means `nyou may lose current work. `nIf it doesn't automatically restart explorer, type 'explorer' on the `ncommand shell to restart it."

$versionMinusDots = "16.04".Replace(".","")

$toolsDir   = $(Split-Path -Parent $MyInvocation.MyCommand.Definition)

If (Get-ProcessorBits -eq 64){
    $installer = "7z$($versionMinusDots)-x64.msi"
}

Else{
    $installer = "7z$($versionMinusDots).msi"
}

$packageArgs = @{
	packageName   = '7zip.install'
	fileType      = 'msi'
	file          = "$toolsDir\installer\$installer"
	silentArgs    = '/qn'
}

Install-ChocolateyInstallPackage @packageArgs

$finalProcessCount = Get-ExplorerProcessCount
if($initialProcessCount -lt $finalProcessCount)
{
  Start-Process explorer.exe
}
