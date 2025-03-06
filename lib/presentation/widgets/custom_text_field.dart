import 'dart:developer';

import 'package:assymetri_task/controllers/my_functions.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField(
      {super.key,
      required this.hintText,
      required this.homeController,
      required this.controller,
      required this.formKey,
      required this.validator,
      required this.size,
      required this.focusNode,
      required this.onTap});
  final String hintText;
  final TextEditingController controller;
  final GlobalKey<FormState> formKey;
  final FormFieldValidator validator;
  final FocusNode focusNode;
  final Size size;
  final VoidCallback onTap;

  final MyFunctions homeController;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: SizedBox(
        width: size.width * 0.3 < 300 ? 300 : size.width * 0.3,
        child: Obx(
          () => TextFormField(
            onTap: onTap,
            focusNode: focusNode,
            controller: controller,
            inputFormatters: [FilteringTextInputFormatter.digitsOnly],
            style: TextStyle(
                color: homeController.selectedActualColor.value,
                fontSize: 14,
                fontWeight: FontWeight.bold,
                letterSpacing: 1.2),
            decoration: InputDecoration(
              labelText: hintText,
              labelStyle: TextStyle(
                  color: homeController.selectedActualColor.value,
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1.2),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(
                  color: homeController.selectedActualColor.value,
                  width: 1,
                ),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(
                  color: homeController.selectedActualColor.value,
                  width: 1,
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(
                  color: homeController.selectedActualColor.value,
                  width: 1,
                ),
              ),
            ),
            validator: validator,
            onChanged: (value) {
              bool validation = formKey.currentState!.validate();
              log("validation: $validation");
              if (validation) {
                homeController.changeValuesInTextFieldDetected();
              } else {
                Get.showSnackbar( const GetSnackBar(
                  title: "Error",
                  message: "Please enter a number in mentioned range.",
                  duration:  Duration(seconds: 2),
                ));
              }
            },
          ),
        ),
      ),
    );
  }
}
