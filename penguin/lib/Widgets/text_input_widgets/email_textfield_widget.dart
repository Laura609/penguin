import 'package:flutter/material.dart';

class EmailTextFieldWidget extends StatefulWidget {
  final String labelText;
  final TextEditingController controller;
  final bool isTouched;

  const EmailTextFieldWidget({
    super.key,
    required this.labelText,
    required this.controller,
    required this.isTouched,
  });

  @override
  State<EmailTextFieldWidget> createState() => _EmailTextFieldWidgetState();
}

class _EmailTextFieldWidgetState extends State<EmailTextFieldWidget> {
  bool _isValidEmail(String email) {
    return RegExp(r"^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,4}$")
        .hasMatch(email.trim());
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double horizontalPadding = screenWidth * 0.07;

    // Логика проверки email
    String errorMessage = '';
    if (widget.isTouched) {
      if (widget.controller.text.isEmpty) {
        errorMessage = 'Email не может быть пустым';
      } else if (!_isValidEmail(widget.controller.text)) {
        errorMessage = 'Некорректный email';
      }
    }

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Текст над полем ввода
          Text(
            widget.labelText,
            style: TextStyle(
              color: Colors.white,
              fontSize: screenWidth * 0.044,
            ),
          ),

          // Контейнер с полем ввода
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
            ),
            child: TextField(
              controller: widget.controller,
              keyboardType: TextInputType.emailAddress,
              style: TextStyle(
                fontSize: screenWidth * 0.04,
                color: const Color.fromRGBO(34, 34, 34, 1),
              ),
              cursorColor: Colors.grey,
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: 'example@mail.com',
                hintStyle: TextStyle(
                  color: Colors.grey.shade500,
                ),
                prefixIcon: Icon(
                  Icons.email,
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

          // Сообщение об ошибке
          if (widget.isTouched && errorMessage.isNotEmpty)
            Padding(
              padding: const EdgeInsets.only(top: 8),
              child: Text(
                errorMessage,
                style: const TextStyle(color: Colors.red, fontSize: 12),
              ),
            ),
        ],
      ),
    );
  }
}