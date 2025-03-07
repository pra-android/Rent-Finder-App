import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SignupTextformField extends StatelessWidget {
  final TextInputType? textInputType;
  final String? hintText;
  final Widget? prefixIcon;
  final bool? obscureText;
  final TextEditingController textEditingController;
  final String? Function(String?)? validator;

  const SignupTextformField({
    super.key,
    this.obscureText,
    this.textInputType,
    required this.hintText,
    this.validator,
    required this.textEditingController,
    required this.prefixIcon,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      style: TextStyle(color: Colors.black),
      controller: textEditingController,
      validator: validator,
      keyboardType: textInputType ?? TextInputType.text,

      obscureText: obscureText ?? false,
      decoration: InputDecoration(
        prefixIcon: prefixIcon,
        filled: true,
        fillColor: Colors.grey.shade300,

        hintText: hintText,
        hintStyle: TextStyle(color: Colors.black, fontSize: 14.sp),
        border: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.grey.shade100),
          borderRadius: BorderRadius.circular(8.r),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.grey.shade100),
          borderRadius: BorderRadius.circular(8.r),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.grey.shade100),
          borderRadius: BorderRadius.circular(8.r),
        ),
      ),
    );
  }
}
