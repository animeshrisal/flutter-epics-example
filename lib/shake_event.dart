import 'dart:async';

import 'package:sensors/sensors.dart';

class ShakeEvent {
  static const double SHAKE_THRESHOLD = 80.0;
  double lastX = 0.0, lastY = 0.0, lastZ = 0.0;
  var lastTime = 0;

  StreamController _shakeEventController = StreamController();
  StreamSubscription _accelerometerSub;

  Stream get shakeEventStream => _shakeEventController.stream;

  ShakeEvent() {
    _init();
  }

  void dispose() {
    _shakeEventController.close();
    _accelerometerSub.cancel();
  }

  void _init() {
    // shake event listener
    _accelerometerSub = accelerometerEvents.listen((AccelerometerEvent event) {
      var currentTime = DateTime.now().millisecondsSinceEpoch;
      if ((currentTime - lastTime) > 100) {
        var diffTime = currentTime - lastTime;
        lastTime = currentTime;

        var speed =
            ((event.x + event.y + event.z) - (lastX + lastY + lastZ)).abs() /
                diffTime *
                1000;
        if (speed > SHAKE_THRESHOLD) {
          _shakeEventController.sink.add(null);
          lastX = lastY = lastZ = 0;
        } else {
          lastX = event.x;
          lastY = event.y;
          lastZ = event.z;
        }
      }
    });
  }
}