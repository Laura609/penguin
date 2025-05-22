import 'package:auto_route/auto_route.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:penguin/Widgets/loading_widget.dart';
import 'package:penguin/Widgets/text_input_widgets/email_textfield_widget.dart';
import 'package:penguin/Widgets/text_input_widgets/password_textfield_widget.dart';
import 'package:penguin/router/router.gr.dart';

@RoutePage()
class LoginPage extends StatefulWidget {
  final VoidCallback showRegisterPage;
  const LoginPage({super.key, required this.showRegisterPage});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final bool _isEmailTouched = false;
  final bool _isPasswordTouched = false;

  Future<void> signIn() async {
    if (_emailController.text.isEmpty || _passwordController.text.isEmpty) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Пожалуйста, заполните все поля")),
      );
      return;
    }

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => const LoadingWidget(),
    );

    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: _emailController.text.trim(),
        password: _passwordController.text.trim(),
      );

      if (!mounted) return;
      Navigator.of(context).pop();

      if (mounted) {
        context.router.replaceAll([const HomeRoute()]);
      }

    } on FirebaseAuthException catch (e) {
      Navigator.of(context).pop();
      String errorMessage = 'Ошибка входа. Попробуйте снова позже.';
      if (e.code == 'user-not-found') {
        errorMessage = 'Пользователь не найден. Проверьте email.';
      } else if (e.code == 'wrong-password') {
        errorMessage = 'Неверный пароль. Попробуйте снова.';
      } else if (e.code == 'invalid-email') {
        errorMessage = 'Некорректный email. Пожалуйста, проверьте формат.';
      }

      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(errorMessage)),
      );
    } catch (e) {
      Navigator.of(context).pop();
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Произошла ошибка. Попробуйте позже.")),
      );
    }
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: const Color.fromRGBO(0, 4, 40, 1),
      body: Stack(
        children: [
          Positioned(
            top: 0,
            left: 0,
            child: SizedBox(
              width: screenWidth,
              height: screenHeight * 0.26,
              child: Image.asset(
                'assets/milkUp.png',
                fit: BoxFit.cover,
              ),
            ),
          ),

          Positioned(
            bottom: 0,
            left: 0,
            child: SizedBox(
              width: screenWidth,
              height: screenHeight * 0.37,
              child: Image.asset(
                'assets/milkDown.png',
                fit: BoxFit.cover,
              ),
            ),
          ),

          Center(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Авторизация',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 48,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                  const SizedBox(height: 20),

                 Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: EmailTextFieldWidget(
                      controller: _emailController,
                      isTouched: _isEmailTouched,
                      labelText: 'Почта',
                    ),
                  ),

                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: PasswordTextFieldWidget(
                      controller: _passwordController,
                      isTouched: _isPasswordTouched, 
                      labelText: 'Пароль',
                    ),
                  ),
                  const SizedBox(height: 30),

                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30),
                    child: GestureDetector(
                      onTap: signIn,
                      child: Container(
                        height: 50,
                        width: 245,
                        decoration: BoxDecoration(
                          color: const Color.fromRGBO(84, 170, 242, 1),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: const Center(
                          child: Text(
                            'Войти',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w500,
                              fontSize: 24,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        'У вас нет аккаунта? ',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 15,
                        ),
                      ),
                      GestureDetector(
                        onTap: widget.showRegisterPage,
                        child: const Text(
                          'Зарегистрироваться',
                          style: TextStyle(
                            color: Color.fromRGBO(84, 170, 242, 1),
                            fontSize: 15,
                            decoration: TextDecoration.underline,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}