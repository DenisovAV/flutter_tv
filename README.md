# flutter_tv

A new Flutter for TV project.

![](https://github.com/DenisovAV/flutter_tv/blob/master/assets/description/preview.png)

## Getting Started

To run on AppleTV:
 - Build a custom Flutter Engine for Apple TV or download already built from [here](https://drive.google.com/drive/folders/1fI8pR2TkFyUBQG8lmlkmlS4O1leMEWK7?usp=sharing) (the last supported version is 3.19.6)
 - Change FLUTTER_LOCAL_ENGINE value by the path to the custom engine in `scripts/run_apple_tv.sh`
 - Run `sh scripts/run_apple_tv.sh [type of build]` 
 - Press 'Run' in opened XCode (Xcode will be opened by script)
 
[The article with details about Apple TV support](https://medium.com/flutter-community/flutter-for-apple-tv-756fcd5e8113)
 
The details regarding the compilation of a custom engine you can find [here](https://github.com/LibertyGlobal/flutter-tvos-demo).
