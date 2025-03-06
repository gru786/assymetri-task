import 'package:assymetri_task/controllers/my_functions.dart';
import 'package:assymetri_task/data/my_data.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ColorDropdown extends StatelessWidget {
  const ColorDropdown({super.key, required this.size, });
  final Size size;

  @override
  Widget build(BuildContext context) {
    final MyFunctions homeController = Get.put(MyFunctions());

    return Center(
      child: Obx(
        () => Card(
          elevation: 3,
          child: Container(
            width: size.width * 0.3 < 300 ? 300 :size.width * 0.3,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: DropdownButtonHideUnderline(
              child: DropdownButton<int>(
                  value: homeController.selectedColorIndex.value,
                  onChanged: (int? newValue) {
                    homeController
                        .selectDifferentColorFromDropdown(newValue ?? 0);
                  },
                  icon: const Icon(Icons.keyboard_arrow_down),
                  items: List.generate(MyData.colors.length, (index) {
                    return DropdownMenuItem<int>(
                      value: index,
                      child: Text(MyData.colors[index]),
                    );
                  })),
            ),
          ),
        ),
      ),
    );
  }
}
