import 'package:flutter/material.dart';
import 'package:penguin/Widgets/phone_formater_widget.dart';

class PhoneTextFieldWidget extends StatelessWidget {
  final TextEditingController controller;
  final bool isTouched;

  const PhoneTextFieldWidget({
    super.key,
    required this.controller,
    required this.isTouched,
  });

  @override
Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.07),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Телефон',
            style: TextStyle(
              color: Colors.white,
              fontSize: screenWidth * 0.044,
            ),
          ),
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
            ),
            child: TextField(
              controller: controller,
              keyboardType: TextInputType.phone,
              inputFormatters: [SimplePhoneFormatter()],
              style: TextStyle(
                fontSize: screenWidth * 0.04,
                color: const Color.fromRGBO(34, 34, 34, 1),
              ),
              cursorColor: Colors.grey,
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: '+7 (999) 999-99-99',
                hintStyle: TextStyle(
                  color: Colors.grey.shade500,
                ),
                prefixIcon: Icon(
                  Icons.phone,
                  size: 20,
                  color: Colors.grey.shade500,
                ),
                contentPadding: const EdgeInsets.symmetric(
                  vertical: 12.0,
                  horizontal: 16.0,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}