$toolsDir   = $(Split-Path -Parent $MyInvocation.MyCommand.Definition)
$packageName = 'VeeamEndpointBackup'
$installerDir = Join-Path $toolsDir 'installer'
$downloadURL = 'https://download5.veeam.com/VeeamEndpointBackup_1.5.0.306.zip'
$installer = 'VeeamEndpointBackup_1.5.0.306.exe'


Install-ChocolateyZipPackage $packageName -url $downloadURL -UnzipLocation $installerDir

$packageArgs = @{
	packageName   = $installer 
	fileType      = 'exe'
	file          = "$installerDir\$installer"
	silentArgs    = '/silent'
  ValidExitCodes = @(0,1000,1001)
}


Install-ChocolateyInstallPackage @packageArgs 

