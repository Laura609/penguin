import 'package:flutter/material.dart';

class PasswordTextFieldWidget extends StatefulWidget {
  final String labelText; // Заголовок над полем
  final TextEditingController controller;
  final String? confirmPassword;
  final bool isTouched;

  const PasswordTextFieldWidget({
    super.key,
    required this.labelText,
    required this.controller,
    this.confirmPassword,
    required this.isTouched,
  });

  @override
  State<PasswordTextFieldWidget> createState() =>
      _PasswordTextFieldWidgetState();
}

class _PasswordTextFieldWidgetState extends State<PasswordTextFieldWidget> {
  bool isObsText = true;

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double horizontalPadding = screenWidth * 0.07;

    // Логика проверки пароля
    String errorMessage = '';
    if (widget.isTouched) {
      if (widget.controller.text.isEmpty) {
        errorMessage = 'Пароль не может быть пустым';
      } else if (widget.confirmPassword != null &&
          widget.controller.text != widget.confirmPassword) {
        errorMessage = 'Пароли не совпадают';
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
              fontSize: screenWidth * 0.044, // Размер зависит от ширины экрана
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
              obscureText: isObsText,
              style: TextStyle(
                fontSize: screenWidth * 0.04,
                color: const Color.fromRGBO(34, 34, 34, 1),
              ),
              cursorColor: Colors.grey,
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: '******',
                hintStyle: TextStyle(
                  color: Colors.grey.shade500,
                ),
                suffixIcon: InkWell(
                  onTap: () {
                    setState(() {
                      isObsText = !isObsText;
                    });
                  },
                  child: Icon(
                    isObsText ? Icons.visibility_off : Icons.visibility,
                    size: 18,
                    color: const Color.fromRGBO(168, 168, 168, 1),
                  ),
                ),
                prefixIcon: Icon(
                  Icons.lock,
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