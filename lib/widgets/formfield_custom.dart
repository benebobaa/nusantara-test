import 'package:flutter/material.dart';

class TextFormCustom extends StatelessWidget {
  const TextFormCustom({
    super.key,
    required this.controller,
    required this.hintText,
    required this.validator,
    this.valueListenablePass,
    this.keyboardType = TextInputType.text,
    this.onTap,
  });
  final TextEditingController controller;
  final String hintText;
  final String? Function(String? value) validator;
  final ValueNotifier<bool>? valueListenablePass;
  final TextInputType keyboardType;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    Widget? suffixIcon() {
      if (valueListenablePass == null) {
        return null;
      }
      return IconButton(
        onPressed: () {
          valueListenablePass!.value = !valueListenablePass!.value;
        },
        icon: Icon(
          valueListenablePass!.value ? Icons.visibility_off : Icons.visibility,
        ),
      );
    }

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Colors.white),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.only(left: 20),
        child: TextFormField(
          readOnly: onTap != null,
          keyboardType: keyboardType,
          controller: controller,
          obscureText: valueListenablePass?.value ?? false,
          decoration: InputDecoration(
            border: InputBorder.none,
            hintText: hintText,
            suffixIcon: suffixIcon(),
          ),
          validator: validator,
          onTap: onTap,
        ),
      ),
    );
  }
}
