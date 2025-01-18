import 'package:flutter/material.dart';

class CostumPasswordInput extends StatelessWidget {
  const CostumPasswordInput(
      {super.key,
      required this.confirmPasswordController,
      required bool isObscured,
      required this.label,
      required this.hint,
      this.onPressed,
      this.onChanged,
      this.maxLength,
      this.keyboardType})
      : _isObscured = isObscured;

  final TextEditingController confirmPasswordController;
  final bool _isObscured;
  final String label;
  final String hint;
  final TextInputType? keyboardType;
  final int? maxLength;
  final void Function()? onPressed;
  final void Function(String)? onChanged;

  @override
  Widget build(BuildContext context) {
    return TextField(
      onChanged: onChanged,
      controller: confirmPasswordController,
      keyboardType: keyboardType,
      maxLength: maxLength,
      decoration: InputDecoration(
        labelText: label,
        labelStyle: const TextStyle(fontSize: 16, color: Colors.black),
        hintText: hint,
        hintStyle: TextStyle(fontSize: 14, color: Colors.grey[500]),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
          borderSide: const BorderSide(color: Colors.grey),
        ),
        suffixIcon: IconButton(
          icon: _isObscured
              ? Image.asset(
                  "assets/images/appAssets/visibility.png",
                  color: Theme.of(context).colorScheme.primary,
                )
              : Image.asset(
                  "assets/images/appAssets/visibility-off.png",
                ),
          onPressed: onPressed,
        ),
      ),
      obscureText: _isObscured,
    );
  }
}
