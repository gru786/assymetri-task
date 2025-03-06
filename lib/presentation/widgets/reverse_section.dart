import 'package:assymetri_task/presentation/widgets/toggle_switch.dart';
import 'package:flutter/material.dart';

class ReverseSection extends StatelessWidget {
  const ReverseSection({
    super.key, required this.size,
  });

  final Size size;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
                  width: size.width * 0.3 < 300
          ? 300
          : size.width * 0.3,

      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            "Reverse",
            style: TextStyle(
                color: Colors.black,
                fontSize: 14,
                fontWeight: FontWeight.bold,
                letterSpacing: 1.2),
          ),
          ToggleSwitch(),
        ],
      ),
    );
  }
}
