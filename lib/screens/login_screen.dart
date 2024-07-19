import 'package:chatapp/utils/constants.dart';
import 'package:chatapp/widgets/custom_textfield.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final GlobalKey<FormState> _loginFormKey = GlobalKey();
  String? email,password;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: _buildUI(),
    );
  }

  Widget _buildUI() {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            headerText(),
            loginForm(),
            createAccountLink()
          ],
        ),
      ),
    );
  }

  Widget headerText() {
    return SizedBox(
      width: MediaQuery.sizeOf(context).width,
      child: const Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Hi, Welcome Back!",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.w800),
          ),
          Text(
            "Hello again, you have been missed",
            style: TextStyle(
                fontSize: 15, fontWeight: FontWeight.w500, color: Colors.grey),
          )
        ],
      ),
    );
  }

  Widget loginForm() {
    return Container(
        height: MediaQuery.sizeOf(context).height * 0.4,
        margin: EdgeInsets.symmetric(
            vertical: MediaQuery.sizeOf(context).height * 0.05),
        child: Form(
          key: _loginFormKey,
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CustomTextField(
                height: MediaQuery.sizeOf(context).height * 0.1,
                hintText: 'E-mail', 
                validationRegExp: EMAIL_VALIDATION_REGEX,
                onSaved: (value) {
                  setState(() {
                    password = value;
                  });
                },
              ),
              CustomTextField(
                obscureText: true,
                height: MediaQuery.sizeOf(context).height * 0.1,
                hintText: 'Password', 
                validationRegExp: PASSWORD_VALIDATION_REGEX,
                 onSaved: (value) {
                  setState(() {
                    password = value;
                  });
                },
              ),
              _loginButton()
            ],
            
          ),
        ));
  }

  Widget _loginButton() {
    return SizedBox(
      width: MediaQuery.sizeOf(context).width,
      child: MaterialButton(
        color: Theme.of(context).primaryColor,
        onPressed: () {
          if(_loginFormKey.currentState?.validate() ?? false) {
            _loginFormKey.currentState?.save();
          }
        },
        child: const Text("Login", style: TextStyle(color: Colors.white)),
      ),
    );
  }

  Widget createAccountLink() {
    return const Expanded(
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Text("Don't have an account? "),
          Text(
            "Signup",
            style: TextStyle(fontWeight: FontWeight.w800),
          )
        ],
      ),
    );
  }
}
