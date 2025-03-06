import 'package:assymetri_task/controllers/my_functions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SpeedSlider extends StatelessWidget {
  const SpeedSlider({super.key});

  @override
  Widget build(BuildContext context) {
    final MyFunctions homeController = Get.put(MyFunctions());
    final List<String> speedSteps = ['slow', 'smooth', 'fast'];

    return Obx(
      () => SizedBox(
        width: MediaQuery.of(context).size.width * 0.3,
        child: Column(
          children: [
            SliderTheme(
              data: SliderTheme.of(context).copyWith(
                showValueIndicator: ShowValueIndicator.always,
                valueIndicatorColor: homeController.selectedActualColor.value,
                valueIndicatorTextStyle: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              child: Slider(
                value: homeController.speed.value.toDouble(),
                min: 0,
                max: 2,
                divisions: 2,
                overlayColor: WidgetStatePropertyAll(
                  homeController.selectedActualColor.value.withOpacity(0.2),
                ),
                activeColor: homeController.selectedActualColor.value,
                thumbColor: homeController.selectedActualColor.value,
                label: speedSteps[homeController.speed.value],
                onChanged: (value) {
                  homeController.changeSpeedOfProgress(value.toInt() % 3);
                  
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
