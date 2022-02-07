# Adding-Network-Security-Config-to-APK
Since Android Nougat Google introduced changes which prevent proxy tools from sniffing to network traffic of applications. More details:

  https://developer.android.com/training/articles/security-config

This script injects network security config file into APK file that allow sniffing the network traffic of some apps on devices on Android ≥ 7 via proxy tools (Charles Proxy, mitmproxy etc.)
