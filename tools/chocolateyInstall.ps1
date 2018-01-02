$toolsDir   = $(Split-Path -Parent $MyInvocation.MyCommand.Definition)
$packageName = 'VeeamAgentWindows'
$packageVersion = '2.1.0.423'
$installerDir = Join-Path $toolsDir 'installer'
$downloadURL = "https://download5.veeam.com/$($packageName)_$packageVersion.zip"
$installer = "$($packageName)_$packageVersion.exe"

$zipArgs = @{
	packageName   = $packageName
	url           = $downloadURL
	unzipLocation = $installerDir
	checksum      = '603988d6d6983d7875a767ebc226200e'
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

