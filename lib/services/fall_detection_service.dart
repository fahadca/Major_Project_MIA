import 'dart:async';
import 'package:sensors_plus/sensors_plus.dart';
import 'dart:math';

class FallDetectionService {
  late Function(String) _onFallDetected;
  bool _fallDetected = false;

  void startMonitoring(Function(String) onFallDetected) {
    _onFallDetected = onFallDetected;

    accelerometerEvents.listen((AccelerometerEvent event) {
      detectFall(event.x, event.y, event.z);
    });
  }

  void detectFall(double x, double y, double z) {
    const double fallThreshold = 20.0; // Threshold for potential fall
    const double inactivityThreshold = 0.5; // Inactivity threshold
    const int inactivityDuration = 2000; // Inactivity duration (ms)

    // Calculate total acceleration magnitude
    double magnitude = sqrt(x * x + y * y + z * z);

    if (!_fallDetected && magnitude > fallThreshold) {
      _fallDetected = true;
      _onFallDetected("Potential Fall Detected!");

      // Check for inactivity after potential fall
      Future.delayed(Duration(milliseconds: inactivityDuration), () {
        if (magnitude < inactivityThreshold) {
          _onFallDetected("Fall Confirmed!");
        } else {
          _onFallDetected("No Fall");
        }
        _fallDetected = false; // Reset fall detection
      });
    }
  }
}
