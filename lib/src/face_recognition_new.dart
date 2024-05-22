import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:local_auth/local_auth.dart';

class FaceRecognition extends StatefulWidget {
  const FaceRecognition(
      {super.key,
      this.supportedText = "This device is supported",
      this.notSupportedText = "This device is not supported",
      this.dividerHeight,
      this.availableBiometricsText = "Get available biometrics",
      this.authenticateButtonText = "Authenticate",
      this.localizedReasonText = "Authentication"});

  final String supportedText;
  final String notSupportedText;
  final double? dividerHeight;
  final String availableBiometricsText;
  final String authenticateButtonText;
  final String localizedReasonText;

  @override
  State<FaceRecognition> createState() => _FaceRecognitionState();
}

class _FaceRecognitionState extends State<FaceRecognition> {
  late final LocalAuthentication auth;
  bool _supportState = false;

  @override
  void initState() {
    super.initState();
    auth = LocalAuthentication();
    auth.isDeviceSupported().then((bool isSupported) => setState(() {
          _supportState = isSupported;
        }));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (_supportState)
            Text(widget.supportedText)
          else
            Text(widget.notSupportedText),
          Divider(height: widget.dividerHeight ?? 100),
          ElevatedButton(
              onPressed: _getAvailableBiometrics,
              child: Text(widget.availableBiometricsText)),
          Divider(height: widget.dividerHeight ?? 100),
          ElevatedButton(
              onPressed: _authenticate,
              child: Text(widget.authenticateButtonText))
        ],
      ),
    );
  }

  Future<void> _authenticate() async {
    try {
      bool authenticated = await auth.authenticate(
          localizedReason: widget.localizedReasonText,
          options: const AuthenticationOptions(
              stickyAuth: true, biometricOnly: true));
      print("Authenticated: $authenticated");
    } on PlatformException catch (e) {
      print(e);
    }
  }

  Future<void> _getAvailableBiometrics() async {
    List<BiometricType> availableBiometrics =
        await auth.getAvailableBiometrics();

    print("List of availableBiometrics: $availableBiometrics");

    if (!mounted) {
      return;
    }
  }
}
