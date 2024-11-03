import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:room_chat/auth/Auth_service.dart';
import 'package:room_chat/components/my_button.dart';
import 'package:room_chat/components/my_textfield.dart';

class LoginPage extends StatefulWidget {
  final void Function()? onTap;

  const LoginPage({super.key, required this.onTap});

  @override
  State<LoginPage> createState() => _LoginPageState(onTap: onTap);
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  //to show pass
  bool isPassword = true;

  //to navigate
  final void Function()? onTap;

  _LoginPageState({required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme
          .of(context)
          .colorScheme
          .background,
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: 200,
            ),
            Icon(
              Icons.message,
              size: 80,
              color: Theme
                  .of(context)
                  .colorScheme
                  .primary,
            ),
            const SizedBox(
              height: 50,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                'welcome back, you\'ve been missed!',
                style: TextStyle(
                    fontSize: 14, color: Theme
                    .of(context)
                    .colorScheme
                    .primary),
              ),
            ),
            const SizedBox(
              height: 25,
            ),
            MyTextField(
              label: 'Email Address',
              isPassword: false,
              controller: _emailController,
              prefixIcon: Icon(
                Icons.email,
                color: Theme
                    .of(context)
                    .colorScheme
                    .primary,
              ),
              keyboardType: TextInputType.emailAddress, radius: 2.0,
            ),
            const SizedBox(
              height: 10,
            ),
            MyTextField(
              keyboardType: TextInputType.text,
              label: 'password',
              isPassword: isPassword,
              controller: _passwordController,
              prefixIcon: Icon(
                Icons.lock,
                color: Theme
                    .of(context)
                    .colorScheme
                    .primary,
              ),
              suffixIcon: IconButton(
                  onPressed: () {
                    setState(() {
                      isPassword = !isPassword;
                    });
                  },
                  icon: Icon(
                    Icons.remove_red_eye,
                    color: isPassword
                        ? Theme
                        .of(context)
                        .colorScheme
                        .primary
                        : Colors.blue,
                  )), radius: 2.0,
            ),
            const SizedBox(
              height: 25,
            ),
            MyButton(
              onTap: () => login(context),
              text: 'Login',
            ),
            const SizedBox(
              height: 25,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Not a member?',
                  style:
                  TextStyle(color: Theme
                      .of(context)
                      .colorScheme
                      .primary),
                ),
                TextButton(
                  onPressed: onTap,
                  child: Text('Register now',
                      style: TextStyle(
                          fontWeight: FontWeight.w900,
                          color: Theme
                              .of(context)
                              .colorScheme
                              .primary)),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  void login(BuildContext context) {
    final authService = AuthService();
    try {
      authService.signInWithEmailPass(
          _emailController.text.toString(),
          _passwordController.text.toString());
    } catch (e) {
      setState(() {
        showDialog(context: context, builder: (context) =>
            AlertDialog(
              title: Text(e.hashCode.toString(), style: TextStyle(color: Colors.black),),
            ),);
      });
    }
  }
}
