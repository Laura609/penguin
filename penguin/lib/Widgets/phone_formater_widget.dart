import 'package:flutter/services.dart';

class SimplePhoneFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(TextEditingValue oldValue, TextEditingValue newValue) {
    String newText = newValue.text;
    TextSelection newSelection = newValue.selection;

    String digits = newText.replaceAll(RegExp(r'[^\d]'), '');

    if (digits.isEmpty) {
      return const TextEditingValue(text: '');
    }

    if (digits.length > 11) {
      digits = digits.substring(0, 11);
    }

    final StringBuffer buffer = StringBuffer();
    buffer.write('+7 ');

    if (digits.length > 1) {
      buffer.write('(');
      buffer.write(digits.substring(1, digits.length >= 4 ? 4 : digits.length));
      if (digits.length >= 4) buffer.write(') ');
    }

    if (digits.length > 4) {
      buffer.write(digits.substring(4, digits.length >= 7 ? 7 : digits.length));
      if (digits.length >= 7) buffer.write('-');
    }

    if (digits.length > 6) {
      buffer.write(digits.substring(7, digits.length >= 9 ? 9 : digits.length));
      if (digits.length >= 9) buffer.write('-');
    }

    if (digits.length > 8) {
      buffer.write(digits.substring(9));
    }

    String formattedText = buffer.toString();

    int cursorPosition = newSelection.start;

    if (oldValue.text.length > formattedText.length) {
      if (cursorPosition > 0 && cursorPosition <= formattedText.length) {
        String charAtCursor = formattedText[cursorPosition - 1];
        if (charAtCursor == ')' || charAtCursor == '-') {
          cursorPosition -= 1;
        }
      } else if (cursorPosition > formattedText.length) {
        cursorPosition = formattedText.length;
      }
    } else {
      cursorPosition = formattedText.length;
    }

    return TextEditingValue(
      text: formattedText,
      selection: TextSelection.collapsed(offset: cursorPosition),
    );
  }
}