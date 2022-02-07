#!/bin/bash
if [ $# -eq 0 ]
  then
    echo "No arguments supplied"
    echo "Usage: ./addNetworkSecurityConfig.sh Filename.apk"
    exit -1
fi
if [ ! -z "$2" ]
	then
		debugKeystore=$2
	else
    if [ ! -f ~/.android/my-release-key.jks ]; then
      keytool -genkey -v -keystore ~/.android/my-release-key.jks -keyalg RSA -keysize 1024 -validity 999999
    fi
		debugKeystore=~/.android/my-release-key.jks
fi


fullfile=$1
filename=$(basename "$fullfile")
extension="${filename##*.}"
filename="${filename%.*}"
rewrite=".apk"
newFileName=$filename$rewrite
tmpDir=/tmp/$filename

apktool d -f $fullfile -o $tmpDir

if [ ! -d "$tmpDir/res/xml" ]; then
	mkdir $tmpDir/res/xml
fi

cp ./network_security_config.xml $tmpDir/res/xml/.
if ! grep -q "networkSecurityConfig" $tmpDir/AndroidManifest.xml; then
  sed -E "s/(<application.*)(>)/\1 android\:networkSecurityConfig=\"@xml\/network_security_config\" \2 /" $tmpDir/AndroidManifest.xml > $tmpDir/AndroidManifest.xml.new
  mv $tmpDir/AndroidManifest.xml.new $tmpDir/AndroidManifest.xml
fi


apktool empty-framework-dir --force $tmpDir
echo "Building new APK"
apktool b $tmpDir -o ./$newFileName
# deprecated
#jarsigner -verbose -keystore $debugKeystore -storepass android -keypass android ./$newFileName androiddebugkey
apksigner sign -ks $debugKeystore ./$newFileName
