import 'dart:async';
import 'dart:developer';

import 'package:assymetri_task/data/my_data.dart';
import 'package:flutter/material.dart';
import 'package:get/state_manager.dart';

class MyFunctions extends GetxController {
  RxInt selectedColorIndex = 0.obs;
  Rx<Color> selectedActualColor = Colors.red.obs;
  TextEditingController totalItemsController = TextEditingController();
  TextEditingController itemsPerLineController = TextEditingController();
  RxInt speed = 0.obs;
  RxBool isOn = false.obs;
  RxInt totalItems = 1.obs;
  RxInt itemsPerLine = 1.obs;

  void selectDifferentColorFromDropdown(int index) {
    selectedColorIndex.value = index;
    selectedActualColor.value = MyData.actualColors[index];
  }

  void changeSpeedOfProgress(int value) {
    speed.value = value;
  }

  List<RxDouble> progressValues = [];

  void startProgressAnimation() async {
    while (true) {
      // Reset all progress values to 0 before a new round starts
      for (int i = 0; i < progressValues.length; i++) {
        progressValues[i].value = 0.0;
      }

      for (int i = 0; i < progressValues.length; i++) {
        while (progressValues[i].value < 1.0) {
          await Future.delayed(const Duration(milliseconds: 20));

          double increment = 0.01 + (speed.value * 0.01);
          double newValue = progressValues[i].value + increment;

          progressValues[i].value = newValue >= 1.0 ? 1.0 : newValue;
          //log('Progress $i: ${300 * progressValues[i].value}');
        }

        // Hold at 100% for a short time
        await Future.delayed(const Duration(milliseconds: 500));
      }
    }
  }

  void initializeProgressList() {
    progressValues = List.generate(totalItems.value, (_) => 0.0.obs);
    startProgressAnimation();
  }

 
  void changeValuesInTextFieldDetected() {
    totalItems.value = int.tryParse(totalItemsController.text) ?? 1;
    itemsPerLine.value = int.tryParse(itemsPerLineController.text) ?? 1;
    initializeProgressList();
  }

  @override
  void onInit() {
   
    super.onInit();
    initializeProgressList();
  }
}
