$toolsDir   = $(Split-Path -Parent $MyInvocation.MyCommand.Definition)
$packageName = 'VeeamAgentWindows'
$packageVersion = '2.0.0.700'
$installerDir = Join-Path $toolsDir 'installer'
$downloadURL = "https://download5.veeam.com/$($packageName)_$packageVersion.zip"
$installer = "$($packageName)_$packageVersion.exe"


Install-ChocolateyZipPackage $packageName -url $downloadURL -UnzipLocation $installerDir

$packageArgs = @{
	packageName   = $installer 
	fileType      = 'exe'
	file          = "$installerDir\$installer"
	silentArgs    = '/silent /accepteula'
  ValidExitCodes = @(0,1000,1101)
}


Install-ChocolateyInstallPackage @packageArgs 

