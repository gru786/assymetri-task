import 'package:assymetri_task/controllers/my_functions.dart';
import 'package:assymetri_task/data/my_data.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class GradientProgressIndicator extends StatelessWidget {
  const GradientProgressIndicator({super.key, required this.index});
  final int index;

  @override
  Widget build(BuildContext context) {
    final MyFunctions homeController = Get.put(MyFunctions());

    return Container(
      width: 300,
      height: 20,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.black, width: 1),
      ),
      child: Stack(
        children: [
          Obx(
            () => Container(
              width: homeController.progressValues[index].value == 1.0
                  ? double.infinity // Fill completely when 100%
                  : 300 * homeController.progressValues[index].value,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                gradient: LinearGradient(
                  colors: [
                    MyData.actualColors[homeController.selectedColorIndex.value]
                        .withOpacity(0.35),
                    MyData.actualColors[homeController.selectedColorIndex.value]
                        .withOpacity(0.6),
                    MyData.actualColors[homeController.selectedColorIndex.value]
                        .withOpacity(0.8),
                    MyData
                        .actualColors[homeController.selectedColorIndex.value],
                  ],
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
