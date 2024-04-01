import 'dart:async';

import 'package:get/get.dart';

class OTPViewModel extends GetxController {
  RxString otp = ''.obs;
  RxInt countdown = 120.obs;
  late Stopwatch _stopwatch;
  late StreamController<int> _countdownController;
  Stream<int> get countdownStream => _countdownController.stream;


  @override
  void onInit() {
    super.onInit();
    _stopwatch = Stopwatch();
    _countdownController = StreamController<int>.broadcast();
  }

  @override
  void onClose() {
    _countdownController.close();
    super.onClose();
  }

  void setOTP(String value) {
    otp.value = value;
  }

  void verifyOTP() {
    print(otp.value);
  }

  void resendOTP() {
    _stopwatch.stop();
    _stopwatch.reset();
    _stopwatch.start();
    print('Resend Success');
  }

  void startCountdown() {
    _stopwatch.start();
    const oneSecond = Duration(seconds: 1);
    Timer.periodic(oneSecond, (timer) {
      if (_stopwatch.elapsed.inSeconds >= countdown.value) {
        timer.cancel();
        resendOTP();
      } else {
        _countdownController.add(countdown.value - _stopwatch.elapsed.inSeconds);
      }
    });
  }
}
