import 'package:flutter/material.dart';

class CodeTextFieldWidget extends StatelessWidget {
  final TextEditingController controller;
  final bool isTouched;

  const CodeTextFieldWidget({
    super.key,
    required this.controller,
    required this.isTouched,
  });

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return SizedBox(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Код',
            style: TextStyle(
              color: Colors.white,
              fontSize: screenWidth * 0.044,
            ),
          ),
          SizedBox(
            height: 50,
            width: 100,
            child: TextField(
              controller: controller,
              keyboardType: TextInputType.number,
              maxLength: 6,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 20,
                color: const Color.fromRGBO(34, 34, 34, 1),
              ),
              cursorColor: Colors.grey,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: const BorderSide(color: Colors.white),
                ),
                filled: true,
                fillColor: Colors.white,
                hintText: '******',
                hintStyle: TextStyle(
                  color: Colors.grey.shade500,
                ),
                counterText: '',
                contentPadding: const EdgeInsets.symmetric(
                  vertical: 10.0,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}