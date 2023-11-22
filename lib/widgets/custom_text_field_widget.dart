import 'package:flutter/material.dart';

class CustomTextFieldWidget extends StatelessWidget {
//will recieve this from other forms
  final TextEditingController? editingController;
  final IconData? iconData;
  final String? assetRef;
  final String? labelText;
  final bool? isObsecure;
  const CustomTextFieldWidget(
      {super.key,
      this.editingController,
      this.assetRef,
      this.labelText,
      this.iconData,
      this.isObsecure});

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: editingController,
      decoration: InputDecoration(
        labelText: labelText,
        prefixIcon: iconData != null
            ? Icon(iconData)
            : Padding(
                padding: const EdgeInsets.all(8),
                child: Image.asset(assetRef.toString()),
              ),
        labelStyle: const TextStyle(fontSize: 18),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(6),
          borderSide: const BorderSide(color: Colors.grey),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(6),
          borderSide: const BorderSide(color: Colors.grey),
        ),
      ),
      obscureText: isObsecure!,
    );
  }
}
