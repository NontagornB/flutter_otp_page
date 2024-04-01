import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter/services.dart';

import '../viewmodels/numbers_view_model.dart';

class FirstPage extends StatelessWidget {
  final NumberViewModel viewModel = Get.put(NumberViewModel());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(color: Color(0xFF15141D)),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text('Enter a 10-digit number',style: TextStyle(color: Color(0xFF4E4887),fontWeight: FontWeight.bold,fontSize: 20),),
                const SizedBox(height: 40),
                TextField(
                  controller: viewModel.numberController,
                  keyboardType: TextInputType.number,
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                    LengthLimitingTextInputFormatter(10),
                  ],
                  style: const TextStyle(
                    color: Colors.blue,
                  ),
                ),
                const SizedBox(height: 100),
                ElevatedButton(
                  onPressed: () {
                    if (viewModel.isNumberValid()) {
                      viewModel.sendNumber();
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text(
                            'Please enter again',
                            style: TextStyle(color: Colors.redAccent),
                          ),
                        ),
                      );
                    }
                  },
                  child: const Text('Send Number'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
