<!--
This README describes the package. If you publish this package to pub.dev,
this README's contents appear on the landing page for your package.

For information about how to write a good package README, see the guide for
[writing package pages](https://dart.dev/guides/libraries/writing-package-pages).

For general information about developing packages, see the Dart guide for
[creating packages](https://dart.dev/guides/libraries/create-library-packages)
and the Flutter guide for
[developing packages and plugins](https://flutter.dev/developing-packages).
-->

The face recognition authentication package contains a number of useful containers with functionality that can help you with building face/fingerprint authentication screens for your app. The package contains description and result text.


## Features

![](https://raw.githubusercontent.com/Casm9/my-github-storage/main/face-recognation.jpg)

## Usage

```dart
class FingerprintAuth extends StatelessWidget {
  const FingerprintAuth({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FaceRecognition(
          supportedText = "This device is supported",
          notSupportedText = "This device is not supported",
          dividerHeight = 100,
          availableBiometricsText = "Get available biometrics",
          authenticateButtonText = "Authenticate",
          localizedReasonText = "Authentication"
      ),
    );
  }
}
```