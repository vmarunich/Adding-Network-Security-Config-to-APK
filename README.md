# Adding-Network-Security-Config-to-APK
Since Android Nougat Google introduced changes which prevent proxy tools from sniffing to network traffic of applications. More details:

  https://developer.android.com/training/articles/security-config

This script injects network security config file into APK file that allow sniffing the network traffic of some apps on devices on Android ≥ 7 via proxy tools (Charles Proxy, mitmproxy etc.).

**Run the script with parameters:**
  * Filename of the .apk (required)
  * Keystore file path (optional) (by default the path is: _~/.android/my-release-key.jks_) 

```
./addNetworkSecurityConfig.sh Filename.apk
or
./addNetworkSecurityConfig.sh Filename.apk ~/.android/my-release-key.jks
```


**The script will perform the following:**
 1. Disassemble the .apk via `apktool`
 2. Put network_security_config.xml file to the proper directory
 3. Inject the `network_security_config` path into `AndroidManifest.xml`
 4. Reassemble the .apk
 5. Sign the .apk with your personal key
