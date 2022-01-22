import 'package:flutter/material.dart';

class InputField extends StatelessWidget {
  const InputField({
    Key? key,
    required this.textInputType,
    required this.controller,
    required this.hintText,
    required this.icon,
    this.obscure = false,
  }) : super(key: key);

  final TextEditingController controller;
  final String hintText;
  final IconData icon;
  final bool obscure;
  final TextInputType textInputType;
  @override
  Widget build(BuildContext context) {
    final inputBorder = OutlineInputBorder(
      borderSide: Divider.createBorderSide(context),
    );
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: TextField(
        obscureText: obscure,
        controller: controller,
        decoration: InputDecoration(
          border: inputBorder,
          focusedBorder: inputBorder,
          enabledBorder: inputBorder,
          prefixIcon: Icon(
            icon,
            color: Colors.grey,
          ),
          filled: true,
          hintText: hintText,
        ),
        keyboardType: textInputType,
      ),
    );
  }
}

class CustomButton extends StatelessWidget {
  CustomButton({required this.text});
  final String text;
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      width: double.infinity,
      padding: EdgeInsets.all(15),
      decoration: ShapeDecoration(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(4),
          ),
        ),
        color: Colors.blue,
      ),
      child: Text(
        text,
        textAlign: TextAlign.center,
        style: TextStyle(
          color: Colors.white,
        ),
      ),
    );
  }
}
