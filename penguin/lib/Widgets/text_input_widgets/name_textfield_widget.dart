import 'package:flutter/material.dart';

class NameTextFieldWidget extends StatefulWidget {
  final String labelText;
  final TextEditingController controller;
  final bool isTouched;

  const NameTextFieldWidget({
    super.key,
    required this.labelText,
    required this.controller,
    required this.isTouched,
  });

  @override
  State<NameTextFieldWidget> createState() => _NameTextFieldWidgetState();
}

class _NameTextFieldWidgetState extends State<NameTextFieldWidget> {
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double horizontalPadding = screenWidth * 0.07;

    // Логика проверки имени
    String errorMessage = '';
    if (widget.isTouched && widget.controller.text.isEmpty) {
      errorMessage = 'Поле не может быть пустым';
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
              style: TextStyle(
                fontSize: screenWidth * 0.04,
                color: const Color.fromRGBO(34, 34, 34, 1),
              ),
              cursorColor: Colors.grey,
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: 'Максим',
                hintStyle: TextStyle(
                  color: Colors.grey.shade500,
                ),
                prefixIcon: Icon(
                  Icons.person,
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