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
   HomePage({super.key});
  final formKeyTotalItems = GlobalKey<FormState>();
  final formKeyItemsPerLine = GlobalKey<FormState>();
  final ScrollController scrollController = ScrollController();

  final FocusNode totalItemsFocusNode = FocusNode();
  final FocusNode itemsPerLineFocusNode = FocusNode();

  void scrollToField(GlobalKey key) {
    final context = key.currentContext;
    if (context != null) {
      Scrollable.ensureVisible(context,
          duration: const Duration(milliseconds: 300), curve: Curves.easeInOut);
    }
  }

  @override
  Widget build(BuildContext context) {
  final Size size = MediaQuery.of(context).size;
  final MyFunctions homeController = Get.put(MyFunctions());


    

    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: SingleChildScrollView(
          controller: scrollController,
          physics: const ClampingScrollPhysics(),
          child: ConstrainedBox(
            constraints: BoxConstraints(
              minHeight: size.height,
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(height: 50),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Image.network(
                      "https://tinyurl.com/3hfa26cx",
                      height: size.width * 0.15 < 120 ? 120 : size.width * 0.12,
                      width: size.width * 0.3 < 300 ? 300 : size.width * 0.3,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return const Text("Error loading image");
                      },
                    ),
                  ),
                  const SizedBox(height: 20),
                  ColorDropdown(size: size),
                  const SizedBox(height: 10),
                  SpeedSlider(size: size),
                  const SizedBox(height: 20),
                  CustomTextField(
                    hintText: "Total Items",
                    onTap: () => scrollToField(formKeyTotalItems),
                    size: size,
                    focusNode: totalItemsFocusNode,
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
                  const SizedBox(height: 10),
                  CustomTextField(
                    hintText: "Items in line",
                    size: size,
                    onTap: () => scrollToField(formKeyItemsPerLine),
                    homeController: homeController,
                    controller: homeController.itemsPerLineController,
                    formKey: formKeyItemsPerLine,
                    focusNode: itemsPerLineFocusNode,
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
                  const SizedBox(height: 20),
                  ReverseSection(size: size),
                  const SizedBox(height: 20),
                  SizedBox(
                    height: 300, // Set a fixed height for the GridView
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
                            child: GradientProgressIndicator(index: index),
                          );
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
