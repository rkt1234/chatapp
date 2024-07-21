import 'dart:io';

import 'package:chatapp/models/user_profile.dart';
import 'package:chatapp/services/alert_service.dart';
import 'package:chatapp/services/auth_service.dart';
import 'package:chatapp/services/database_service.dart';
import 'package:chatapp/services/media_service.dart';
import 'package:chatapp/services/navigation_service.dart';
import 'package:chatapp/services/storage_service.dart';
import 'package:chatapp/utils/constants.dart';
import 'package:chatapp/widgets/custom_textfield.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  File? selectedImage;
  final GetIt getIt = GetIt.instance;
  final GlobalKey<FormState> _registerFormKey = GlobalKey();
  late MediaService _mediaService;
  late AuthService _authService;
  late StorageService _storageService;
  late NavigationService _navigationService;
  late DatabaseService _databaseService;
  late AlertService _alertService;
  String? email, password, name;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    _mediaService = getIt.get<MediaService>();
    _navigationService = getIt.get<NavigationService>();
    _authService = getIt.get<AuthService>();
    _storageService = getIt.get<StorageService>();
    _databaseService = getIt.get<DatabaseService>();
    _alertService = getIt.get<AlertService>();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: buildUI(),
    );
  }

  Widget buildUI() {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
        child: Column(
          children: [
            headerText(),
            if (!isLoading) registerForm(),
            if (!isLoading) loginAccountLink(),
            if (isLoading)
              const Expanded(
                  child: Center(
                child: CircularProgressIndicator(),
              ))
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
            "Let's, get going!",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.w800),
          ),
          Text(
            "Register an account using the form below",
            style: TextStyle(
                fontSize: 15, fontWeight: FontWeight.w500, color: Colors.grey),
          )
        ],
      ),
    );
  }

  Widget registerForm() {
    return Container(
      height: MediaQuery.sizeOf(context).height * 0.6,
      margin: EdgeInsets.symmetric(
          vertical: MediaQuery.sizeOf(context).height * 0.05),
      child: Form(
        key: _registerFormKey,
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            pfpSelectionField(),
            CustomTextField(
                hintText: "Name",
                height: MediaQuery.sizeOf(context).height * 0.1,
                validationRegExp: NAME_VALIDATION_REGEX,
                onSaved: (value) {
                  setState(() {
                    name = value;
                  });
                }),
            CustomTextField(
                hintText: "E-mail",
                height: MediaQuery.sizeOf(context).height * 0.1,
                validationRegExp: EMAIL_VALIDATION_REGEX,
                onSaved: (value) {
                  setState(() {
                    email = value;
                  });
                }),
            CustomTextField(
                obscureText: true,
                hintText: "Password",
                height: MediaQuery.sizeOf(context).height * 0.1,
                validationRegExp: PASSWORD_VALIDATION_REGEX,
                onSaved: (value) {
                  setState(() {
                    password = value;
                  });
                }),
            registerButton()
          ],
        ),
      ),
    );
  }

  Widget pfpSelectionField() {
    return InkWell(
      onTap: () async {
        File? file = await _mediaService.getImageFromGallery();
        if (file != null) {
          setState(() {
            selectedImage = file;
          });
        }
      },
      child: CircleAvatar(
          radius: MediaQuery.of(context).size.width * .2,
          backgroundImage: selectedImage != null
              ? FileImage(selectedImage!)
              : NetworkImage(PLACEHOLDER_IMAGE) as ImageProvider),
    );
  }

  Widget registerButton() {
    return SizedBox(
      width: MediaQuery.sizeOf(context).width,
      child: MaterialButton(
          color: Theme.of(context).colorScheme.primary,
          onPressed: () async {
            setState(() {
              isLoading = true;
            });
            try {
              if ((_registerFormKey.currentState?.validate() ?? false) &&
                  selectedImage != null) {
                _registerFormKey.currentState?.save();
                bool result = await _authService.signUp(email!, password!);
                if (result) {
                  String? pfpURL = await _storageService.uploadUserPfp(
                      file: selectedImage!, uid: _authService.user!.uid);
                  if (pfpURL != null) {
                    print("isme aya hu");
                    await _databaseService.createUserProfile(
                        userProfile: UserProfile(
                            uid: _authService.user!.uid,
                            name: name,
                            pfpURL: pfpURL));
                    _alertService.showToast(
                        text: "User registered successfully!",
                        icon: Icons.check);
                    _navigationService.goBack();
                    _navigationService.pushReplacementNamed('/home');
                  }
                }
              }
            } catch (e) {
              print(e);
              _alertService.showToast(
                  text: "Failed to register, try again!", icon: Icons.error);
            }
            setState(() {
              isLoading = false;
            });
          },
          child: const Text(
            "Register",
            style: TextStyle(color: Colors.white),
          )),
    );
  }

  Widget loginAccountLink() {
    return Expanded(
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          const Text("Do you already have an account? "),
          InkWell(
            onTap: () {
              _navigationService.goBack();
            },
            child: const Text(
              "Login",
              style: TextStyle(fontWeight: FontWeight.w800),
            ),
          )
        ],
      ),
    );
  }
}
