import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:room_chat/auth/Auth_service.dart';

import '../components/my_button.dart';
import '../components/my_textfield.dart';

class RegisterPage extends StatefulWidget {
  final void Function()? onTap;

  RegisterPage({super.key, required this.onTap});

  @override
  State<RegisterPage> createState() => _RegisterPageState(onTap: onTap);
}

class _RegisterPageState extends State<RegisterPage> {
  final TextEditingController _emailController = TextEditingController();

  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  //show pass
  bool _isPassword = true;

  //show pass ->confirm
  bool _isPasswordToConfirm = true;

  final void Function()? onTap;

  _RegisterPageState({required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(height: 200),
            Icon(
              Icons.message,
              size: 80,
              color: Theme.of(context).colorScheme.primary,
            ),
            const SizedBox(
              height: 50,
            ),

            //welcome text
            Text(
              'Let\'s create an account for you',
              style: TextStyle(
                  fontSize: 14, color: Theme.of(context).colorScheme.primary),
            ),
            const SizedBox(
              height: 25,
            ),

            //email TextField
            MyTextField(
              keyboardType: TextInputType.emailAddress,
              label: 'Email Address',
              isPassword: false,
              controller: _emailController,
              prefixIcon: Icon(
                Icons.email,
                color: Theme.of(context).colorScheme.primary,
              ), radius: 2.0,
            ),
            const SizedBox(
              height: 10,
            ),

            //pass TextField
            MyTextField(
              keyboardType: TextInputType.text,
              label: 'Password',
              isPassword: _isPassword,
              controller: _passwordController,
              prefixIcon: Icon(
                Icons.lock,
                color: Theme.of(context).colorScheme.primary,
              ),
              suffixIcon: IconButton(
                  onPressed: () {
                    setState(() {
                      _isPassword = !_isPassword;
                    });
                  },
                  icon: Icon(
                    Icons.remove_red_eye,
                    color: _isPassword
                        ? Theme.of(context).colorScheme.primary
                        : Colors.blue,
                  )), radius: 2.0,
            ),
            const SizedBox(
              height: 10,
            ),

            //confirm pass TextField
            MyTextField(
              keyboardType: TextInputType.text,
              label: 'Confirm Password',
              isPassword: _isPasswordToConfirm,
              controller: _confirmPasswordController,
              prefixIcon: Icon(
                Icons.lock,
                color: Theme.of(context).colorScheme.primary,
              ),
              suffixIcon: IconButton(
                  onPressed: () {
                    setState(() {
                      _isPasswordToConfirm = !_isPasswordToConfirm;
                    });
                  },
                  icon: Icon(
                    Icons.remove_red_eye,
                    color: _isPasswordToConfirm
                        ? Theme.of(context).colorScheme.primary
                        : Colors.blue,
                  )), radius: 2.0,
            ),
            const SizedBox(
              height: 25,
            ),

            // Register btn
            MyButton(
              onTap: () => register(context),
              text: 'Register',
            ),
            const SizedBox(
              height: 25,
            ),

            //text & buttonText
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Already have an account?',
                  style:
                      TextStyle(color: Theme.of(context).colorScheme.primary),
                ),
                TextButton(
                    onPressed: onTap,
                    child: Text('Login now',
                        style: TextStyle(
                            fontWeight: FontWeight.w900,
                            color: Theme.of(context).colorScheme.primary))),
              ],
            )
          ],
        ),
      ),
    );
  }

  void register(BuildContext context) {
    final _auth = AuthService();

    if (_passwordController.text == _confirmPasswordController.text) {
      try {
        _auth.signUpWithEmailPass(
            _emailController.text, _passwordController.text);
      } catch (e) {
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text(
              e.toString(),
              style: const TextStyle(color: Colors.black),
            ),
          ),
        );
      }
    } else {

      showDialog(
        context: context,
        builder: (context) => const AlertDialog(
          title: Text('Password don\'t match!',
            style: TextStyle(color: Colors.black),
          ),
        ),
      );
    }
  }
}
