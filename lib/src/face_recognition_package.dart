import 'package:flutter/material.dart';
import 'package:local_auth/local_auth.dart';

class FaceRecognition extends StatefulWidget {
  const FaceRecognition({
    super.key,
    this.supportedText = "This device is supported",
    this.notSupportedText = "This device is not supported",
    this.dividerHeight,
    this.availableBiometricsText = "Get available biometrics",
    this.authenticateButtonText = "Authenticate",
    this.localizedReasonText = "Authentication",
  });

  final String supportedText;
  final String notSupportedText;
  final double? dividerHeight;
  final String availableBiometricsText;
  final String authenticateButtonText;
  final String localizedReasonText;

  @override
  FaceRecognitionState createState() => FaceRecognitionState();
}

class FaceRecognitionState extends State<FaceRecognition> {
  final LocalAuthentication _auth = LocalAuthentication();
  bool _isDeviceSupported = false;

  @override
  void initState() {
    super.initState();
    _checkBiometricSupport();
  }

  Future _checkBiometricSupport() async {
    final isSupported = await _auth.isDeviceSupported();
    setState(() {
      _isDeviceSupported = isSupported;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              _isDeviceSupported
                  ? widget.supportedText
                  : widget.notSupportedText,
            ),
            if (_isDeviceSupported) ...[
              Divider(height: widget.dividerHeight ?? 100),
              ElevatedButton(
                onPressed: _getAvailableBiometrics,
                child: Text(widget.availableBiometricsText),
              ),
              Divider(height: widget.dividerHeight ?? 100),
              ElevatedButton(
                onPressed: () => _authenticate(widget.localizedReasonText),
                child: Text(widget.authenticateButtonText),
              ),
            ],
          ],
        ),
      ),
    );
  }

  Future _getAvailableBiometrics() async {
    await _auth.getAvailableBiometrics();
  }

  Future _authenticate(String localizedReasonText) async {
    await _auth.authenticate(
      localizedReason: localizedReasonText,
      options:
          const AuthenticationOptions(stickyAuth: true, biometricOnly: true),
    );
  }
}
