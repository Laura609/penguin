import 'package:auto_route/auto_route.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:penguin/Widgets/loading_widget.dart';
import 'package:penguin/Widgets/register_button_widget.dart';
import 'package:penguin/Widgets/text_input_widgets/email_textfield_widget.dart';
import 'package:penguin/Widgets/text_input_widgets/login_textfield_widget.dart';
import 'package:penguin/Widgets/text_input_widgets/name_textfield_widget.dart';
import 'package:penguin/Widgets/text_input_widgets/password_textfield_widget.dart';
import 'package:penguin/router/router.gr.dart';

@RoutePage()
class RegistrationPage extends StatefulWidget {
  final VoidCallback showLoginPage;
  const RegistrationPage({super.key, required this.showLoginPage});

  @override
  State<RegistrationPage> createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {
  final _phoneController = TextEditingController();
  final _firsNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  bool _isTouched = false;
  bool _isFormValid = false;

  @override
  void initState() {
    super.initState();
    _phoneController.addListener(_checkFormValidity);
    _firsNameController.addListener(_checkFormValidity);
    _emailController.addListener(_checkFormValidity);
    _passwordController.addListener(_checkFormValidity);
    _confirmPasswordController.addListener(_checkFormValidity);
  }

  @override
  void dispose() {
    _phoneController.removeListener(_checkFormValidity);
    _firsNameController.removeListener(_checkFormValidity);
    _emailController.removeListener(_checkFormValidity);
    _passwordController.removeListener(_checkFormValidity);
    _confirmPasswordController.removeListener(_checkFormValidity);
    super.dispose();
  }

  void _checkFormValidity() {
    setState(() {
      bool isValidPassword = _passwordController.text.trim() ==
          _confirmPasswordController.text.trim();

      bool isValidEmail =
          RegExp(r"^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,4}$")
              .hasMatch(_emailController.text.trim());

      _isFormValid = _phoneController.text.isNotEmpty &&
          _firsNameController.text.isNotEmpty &&
          _emailController.text.isNotEmpty &&
          isValidEmail &&
          _passwordController.text.isNotEmpty &&
          isValidPassword;
    });
  }

  Future<void> signUp() async {
    setState(() {
      _isTouched = true;
    });

    if (_isFormValid) {
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => const LoadingWidget(),
      );

      try {
        // Регистрация пользователя в Firebase
        await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: _emailController.text.trim(),
          password: _passwordController.text.trim(),
        );

        // Сохранение данных в Firestore
        await FirebaseFirestore.instance
            .collection('Users')
            .doc(_emailController.text.trim())
            .set({
          'email': _emailController.text.trim(),
          'phone': _phoneController.text.trim(),
          'first_name': _firsNameController.text.trim(),
          'created_at': FieldValue.serverTimestamp(),
        });

        if (!mounted) return;
        Navigator.of(context).pop(); // Закрываем диалог загрузки

        // Явная навигация на HomeRoute
        if (mounted) {
          context.router.replaceAll([const HomeRoute()]);
        }
      } on FirebaseAuthException catch (e) {
        if (mounted) Navigator.of(context).pop();
        
        String errorMessage = 'Ошибка регистрации. Попробуйте снова позже.';
        if (e.code == 'email-already-in-use') {
          errorMessage = 'Этот email уже используется. Попробуйте другой.';
        } else if (e.code == 'weak-password') {
          errorMessage =
              'Пароль слишком слабый. Используйте более сложный пароль.';
        } else if (e.code == 'invalid-email') {
          errorMessage = 'Некорректный email. Пожалуйста, проверьте формат.';
        }

        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(errorMessage)),
          );
        }
      } catch (e) {
        if (mounted) Navigator.of(context).pop();
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
                content: Text("Произошла ошибка. Пожалуйста, попробуйте снова.")),
          );
        }
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content: Text("Пожалуйста, заполните все поля правильно.")),
      );
    }
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
              child: Image.asset('assets/milkUp.png', fit: BoxFit.cover),
            ),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            child: SizedBox(
              width: screenWidth,
              height: screenHeight * 0.37,
              child: Image.asset('assets/milkDown.png', fit: BoxFit.cover),
            ),
          ),
          Center(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Регистрация',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 48,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                  const SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: PhoneTextFieldWidget(
                      controller: _phoneController,
                      isTouched: _isTouched,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: EmailTextFieldWidget(
                      controller: _emailController,
                      isTouched: _isTouched,
                      labelText: 'Почта',
                    ),
                  ),
                  const SizedBox(height: 10),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: NameTextFieldWidget(
                      controller: _firsNameController,
                      isTouched: _isTouched,
                      labelText: 'Имя',
                    ),
                  ),
                  const SizedBox(height: 10),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: PasswordTextFieldWidget(
                      controller: _passwordController,
                      isTouched: _isTouched,
                      labelText: 'Пароль',
                    ),
                  ),
                  const SizedBox(height: 10),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: PasswordTextFieldWidget(
                      controller: _confirmPasswordController,
                      confirmPassword: _passwordController.text,
                      isTouched: _isTouched,
                      labelText: 'Подтвердите пароль',
                    ),
                  ),
                  const SizedBox(height: 30),
                  RegisterButtonWidget(
                    isFormValid: _isFormValid,
                    onTap: signUp,
                  ),
                  const SizedBox(height: 5),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        'Уже есть аккаунт? ',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 15,
                        ),
                      ),
                      GestureDetector(
                        onTap: widget.showLoginPage,
                        child: const Text(
                          'Войти',
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