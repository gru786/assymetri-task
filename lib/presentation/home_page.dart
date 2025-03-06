import 'package:assymetri_task/controllers/my_functions.dart';
import 'package:assymetri_task/presentation/widgets/color_drop_down.dart';
import 'package:assymetri_task/presentation/widgets/custom_text_field.dart';
import 'package:assymetri_task/presentation/widgets/gradient_progress_indicatior.dart';
import 'package:assymetri_task/presentation/widgets/reverse_section.dart';
import 'package:assymetri_task/presentation/widgets/speed_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:get/instance_manager.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final MyFunctions homeController = Get.put(MyFunctions());
    final formKeyTotalItems = GlobalKey<FormState>();
    final formKeyItemsPerLine = GlobalKey<FormState>();
    final Size = MediaQuery.of(context).size;

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: 50,
            ),
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.network(
                "https://tinyurl.com/3hfa26cx",
                height: Size.width * 0.15,
                width: Size.width * 0.3,
                fit: BoxFit.fill,
                errorBuilder: (context, error, stackTrace) {
                  return Text("Error loading image");
                },
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            ColorDropdown(),
            const SizedBox(
              height: 10,
            ),
            const SpeedSlider(),
            const SizedBox(
              height: 20,
            ),
            CustomTextField(
              hintText: "Total Items",
              homeController: homeController,
              controller: homeController.totalItemsController,
              formKey: formKeyTotalItems,
              validator: (value) {
                if (value != null && value.isNotEmpty) {
                  final intValue = int.tryParse(value);
                  if (intValue != null && intValue > 30) {
                    return 'Value cannot be greater than 30';
                  }
                }
                return null;
              },
            ),
            const SizedBox(
              height: 10,
            ),
            CustomTextField(
              hintText: "Items in line",
              homeController: homeController,
              controller: homeController.itemsPerLineController,
              formKey: formKeyItemsPerLine,
              validator: (value) {
                if (value != null && value.isNotEmpty) {
                  final intValue = int.tryParse(value);
                  if (intValue != null && intValue > 15) {
                    return 'Only 15 items allowed per line';
                  }
                }
                return null;
              },
            ),
            const SizedBox(
              height: 20,
            ),
            const ReverseSection(),
            const SizedBox(
              height: 20,
            ),
            Expanded(
              child: Obx(
                () => GridView.builder(
                  itemCount: homeController.totalItems.value,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: homeController.itemsPerLine.value,
                    mainAxisExtent: 20,
                    crossAxisSpacing: 5,
                    mainAxisSpacing: 10,
                  ),
                  itemBuilder: (context, index) {
                    return Center(
                      child: GradientProgressIndicator(
                        index: index,
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
