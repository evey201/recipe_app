import 'package:flutter/material.dart';
import 'package:recipe_app/services/auth_service.dart';
import 'package:status_alert/status_alert.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final GlobalKey<FormState> _loginFormKey = GlobalKey();

  String? username, password;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
      ),
      body: SafeArea(child: _buildLoginFormUI()),
    );
  }

  Widget _buildLoginFormUI() {
    return SizedBox(
      width: MediaQuery.sizeOf(context).width,
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          _buildTitle(),
          _loginForm(),
        ],
      ),
    );
  }

  Widget _buildTitle() {
    return const Text(
      'Recip Book',
      style: TextStyle(
        fontSize: 35,
        fontWeight: FontWeight.w300,
      ),
    );
  }

  Widget _loginForm() {
    return SizedBox(
        width: MediaQuery.sizeOf(context).width * 0.9,
        height: MediaQuery.sizeOf(context).height * 0.3,
        child: Form(
          key: _loginFormKey,
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              TextFormField(
                initialValue: "kminchelle",
                onSaved: (value) {
                  setState(() {
                    username = value;
                  });
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your username';
                  }
                  return null;
                },
                decoration: const InputDecoration(
                  labelText: 'Username',
                  hintText: 'Enter your username',
                ),
              ),
              TextFormField(
                initialValue: "0lelplR",
                onSaved: (value) {
                  setState(() {
                    password = value;
                  });
                },
                obscureText: true,
                validator: (value) {
                  if (value == null || value.length < 6) {
                    return 'Please enter a valid password';
                  }
                  return null;
                },
                decoration: const InputDecoration(
                  labelText: 'Password',
                  hintText: 'Enter your password',
                ),
              ),
              _loginButton(),
            ],
          ),
        ));
  }

  Widget _loginButton() {
    return SizedBox(
      width: MediaQuery.sizeOf(context).width * 0.6,
      child: ElevatedButton(
          onPressed: () async {
            if (_loginFormKey.currentState?.validate() ?? false) {
              _loginFormKey.currentState?.save();
              // print('Username: $_username, Password: $password');
              bool isLoginSuccess =
                  await AuthService().login(username!, password!);
              if (isLoginSuccess) {
                if (mounted) {
                  Navigator.pushReplacementNamed(context, '/home');
                }
              } else {
                if (mounted) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Login failed'),
                    ),
                  );
                }
                // StatusAlert.show(
                //   context,
                //   duration: const Duration(seconds: 2),
                //   title: 'Login failed',
                //   subtitle: 'Please try again',
                //   configuration: const IconConfiguration(icon: Icons.error),
                //   maxWidth: 260,
                // );
              }
            }
          },
          child: const Text('Login')),
    );
  }
}
