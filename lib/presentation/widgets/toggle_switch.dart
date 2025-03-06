import 'package:assymetri_task/controllers/my_functions.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:get/instance_manager.dart';

class ToggleSwitch extends StatelessWidget {
  const ToggleSwitch({super.key});

  @override
  Widget build(BuildContext context) {
    final MyFunctions homeController = Get.put(MyFunctions());

    return Obx(
      () => Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Switch(
            value: homeController.isReverse.value,
            onChanged: (value) {
              homeController.isReverse.value = value;
            },
            focusColor: homeController.selectedActualColor.value,
            activeColor: homeController.selectedActualColor.value,
          ),
          // Text(
          //   homeController.isOn.value ? 'ON' : 'OFF',
          //   style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          // ),
        ],
      ),
    );
  }
}
