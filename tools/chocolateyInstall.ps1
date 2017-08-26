$toolsDir   = $(Split-Path -Parent $MyInvocation.MyCommand.Definition)
$packageName = 'VeeamAgentWindows'
$packageVersion = '2.0.0.700'
$installerDir = Join-Path $toolsDir 'installer'
$downloadURL = "https://download5.veeam.com/$($packageName)_$packageVersion.zip"
$installer = "$($packageName)_$packageVersion.exe"

$zipArgs = @{
	packageName   = $packageName
	url           = $downloadURL
	unzipLocation = $installerDir
	checksum      = '5430baed6bf5711e89b0c93456949597'
	checksumType  = 'md5'
}

Install-ChocolateyZipPackage @zipArgs

$packageArgs = @{
	packageName   = $installer 
	fileType      = 'exe'
	file          = "$installerDir\$installer"
	silentArgs    = '/silent /accepteula'
  ValidExitCodes = @(0,1000,1101)
}

Install-ChocolateyInstallPackage @packageArgs 

