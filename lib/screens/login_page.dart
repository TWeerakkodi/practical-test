import 'package:flutter/material.dart';
import 'package:flutter_application_1/screens/ProductListpage.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  String emailErrorText = '';
  String passwordErrorText = '';

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  void validateInputs() {
    setState(() {
      emailErrorText = _validateEmail(emailController.text);
      passwordErrorText = _validatePassword(passwordController.text);
    });

    if (emailErrorText.isEmpty && passwordErrorText.isEmpty) {
      _login();
    }
  }

  void _login() {
    print('Email: ${emailController.text}');
    print('Password: ${passwordController.text}');

    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const ProductListPage()),
    );
  }

  String _validateEmail(String value) {
    if (value.isEmpty) {
      return 'Email cannot be empty';
    } else if (!RegExp('@gmail').hasMatch(value)) {
      return 'Enter a valid email address';
    }
    return '';
  }

  String _validatePassword(String value) {
    if (value.isEmpty) {
      return 'Password cannot be empty';
    } else if (value.length < 6) {
      return 'Password must be at least 6 characters';
    }
    return '';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // const Text(
            //   'Flutter Intern Practical Test',
            //   style: TextStyle(fontSize: 24, fontWeight: FontWeight.w600),
            // ),
            const SizedBox(height: 30),
            TextField(
              controller: emailController,
              decoration: InputDecoration(
                border: const OutlineInputBorder(),
                labelText: 'Email',
                errorText: emailErrorText,
              ),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: passwordController,
              obscureText: true,
              decoration: InputDecoration(
                border: const OutlineInputBorder(),
                labelText: 'Password',
                errorText: passwordErrorText,
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: validateInputs,
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFBD1F2D),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                minimumSize: const Size(367, 50),
              ),
              child: const Text(
                'Login',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
