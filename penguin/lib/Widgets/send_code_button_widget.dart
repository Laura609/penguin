import 'package:flutter/material.dart';

class SendCodeButtonWidget extends StatelessWidget {
  final bool isCodeSent;
  final int countdown;
  final bool isLoading;
  final VoidCallback onPressed;

  const SendCodeButtonWidget({
    super.key,
    required this.isCodeSent,
    required this.countdown,
    required this.isLoading,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 200,
      height: 50,
      child: ElevatedButton(
        onPressed: isLoading ? null : onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: isCodeSent || isLoading
              ? Colors.grey
              : const Color.fromRGBO(84, 170, 242, 1),
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        child: isLoading
            ? const CircularProgressIndicator(color: Colors.white)
            : isCodeSent
                ? Text('$countdown сек', style: const TextStyle(fontSize: 20))
                : const Text('Получить код', style: TextStyle(fontSize: 20)),
      ),
    );
  }
}