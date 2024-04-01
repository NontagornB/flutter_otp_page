import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:otp_page/views/numbers_screen.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

import '../models/numbers_models.dart';
import '../viewmodels/otp_view_model.dart';

class OTPScreen extends StatelessWidget {
  final OTPViewModel _viewModel = Get.put(OTPViewModel());
  final NumberModel numberModel;

  OTPScreen({required this.numberModel}) {
    _viewModel.startCountdown();
  }

  @override
  Widget build(BuildContext context) {
    String number = numberModel.number.toString();
    String formattedPhoneNumber =
        "+99${number.substring(0, 2)}${number.substring(3, 8).replaceAll(RegExp(r'\d'), '*')}${number.substring(7, 9)}";

    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF15141D),
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios,
            color: Color(0xFFF9F8FB),
          ),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          decoration: const BoxDecoration(
            color: Color(0xFF15141D),
          ),
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              children: [
                const Padding(
                  padding: EdgeInsets.only(top: 8.0),
                  child: Row(
                    children: [
                      Text(
                        'Verification code',
                        style: TextStyle(
                            color: Color(0xFFF9F8FB),
                            fontSize: 20,
                            fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.only(top: 8.0),
                  child: Row(
                    children: [
                      Text(
                        'We have sent the code verification to',
                        style: TextStyle(
                          color: Color(0xFF57565D),
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: Row(
                    children: [
                      Text(
                        formattedPhoneNumber,
                        style: const TextStyle(
                          color: Color(0xFFF9F8FB),
                          fontSize: 12,
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => FirstPage()),
                          );
                        },
                        child: const Text(
                          'Change phone number?',
                          style: TextStyle(
                            color: Color(0xFF4E4887),
                            fontSize: 12,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 16.0),
                  child: PinCodeTextField(
                    appContext: context,
                    length: 6,
                    onChanged: (value) {
                      _viewModel.setOTP(value);
                    },
                    controller: TextEditingController(),
                    autoDisposeControllers: false,
                    animationType: AnimationType.fade,
                    pinTheme: PinTheme(
                      shape: PinCodeFieldShape.box,
                      activeFillColor: const Color(0xFF1C1C24),
                      inactiveFillColor: const Color(0xFF1C1C24),
                      selectedFillColor: const Color(0xFF1C1C24),
                      activeColor: Colors.transparent,
                      inactiveColor: Colors.transparent,
                      selectedColor: const Color(0xFF4E4887),
                      borderWidth: 2,
                      borderRadius: BorderRadius.circular(10),
                      fieldHeight: MediaQuery.of(context).size.height * 0.075,
                      fieldWidth: MediaQuery.of(context).size.width * 0.125,
                    ),
                    keyboardType: TextInputType.number,
                    cursorColor: const Color(0xFF837FAA),
                    autoFocus: true,
                    enableActiveFill: true,
                    textStyle: const TextStyle(color: Color(0xFF646468)),
                    autoDismissKeyboard: false,
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'Resend code after',
                      style: TextStyle(
                        color: Color(0xFF57565D),
                        fontSize: 12,
                      ),
                    ),
                    StreamBuilder<int>(
                      stream: _viewModel.countdownStream,
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          int countdown = snapshot.data!;
                          return Text(
                            '${countdown ~/ 60}:${(countdown % 60).toString().padLeft(2, '0')}',
                            style: const TextStyle(
                              color: Color(0xFF6964A4),
                              fontSize: 12,
                            ),
                          );
                        } else {
                          return const SizedBox.shrink();
                        }
                      },
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                SizedBox(
                  height:
                      MediaQuery.of(context).viewInsets.bottom > 0 ? 180 : 400,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: 150,
                        height: 50,
                        child: ElevatedButton(
                          onPressed: () {
                            _viewModel.resendOTP();
                          },
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all<Color>(
                                Colors.transparent),
                            shape: MaterialStateProperty.all<OutlinedBorder>(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0),
                                side:
                                    const BorderSide(color: Color(0xFF616067)),
                              ),
                            ),
                          ),
                          child: const Text(
                            'Resend',
                            style: TextStyle(color: Color(0xFF4E4887)),
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 25,
                      ),
                      SizedBox(
                        width: 150,
                        height: 50,
                        child: ElevatedButton(
                          onPressed: () {
                            _viewModel.verifyOTP();
                          },
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all<Color>(
                                const Color(0xFF4E4887)),
                            shape: MaterialStateProperty.all<OutlinedBorder>(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0),
                                side:
                                    const BorderSide(color: Color(0xFF4E4887)),
                              ),
                            ),
                          ),
                          child: const Text(
                            'Confirm',
                            style: TextStyle(color: Color(0xfffffffff)),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
