import 'dart:ui';

import 'package:dollar_app/features/auth/widgets/auth_bottom_text.dart';
import 'package:dollar_app/features/shared/constant/image_constant.dart';
import 'package:dollar_app/features/shared/widgets/app_primary_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconly/iconly.dart';

import '../shared/widgets/app_text_field.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({super.key});

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  String userName = '';
  String usernameErrorText = '';
  String email = '';
  String emailErrorText = '';
  String passwordErrorText = '';
  bool showPassword = false;
  bool validated = false;

  void setUsernameError(String value) {
    if (value.isEmpty) {
      usernameErrorText = 'field cannot be empty';
    } else {
      usernameErrorText = '';
    }
    setState(() {});
  }

  void setPasswordError(String value) {
    if (value.length < 8) {
      passwordErrorText = 'cannot be less than 8 characters';
    } else {
      passwordErrorText = '';
    }
    setState(() {});
  }

  void validateEmail(String value) {
    String pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = RegExp(pattern);
    if (!regex.hasMatch(value)) {
      emailErrorText = 'invalid email';
    } else {
      emailErrorText = '';
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Container(
          width: double.infinity,
          padding: EdgeInsets.symmetric(horizontal: 23.w),
          decoration: const BoxDecoration(
              color: Color(0xFFF5F5F5),
              image: DecorationImage(
                  image: AssetImage(AppImages.onboarding2),
                  fit: BoxFit.fill,
                  opacity: 0.8)),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Sign up",
                style: GoogleFonts.notoSans(
                    //color: Colors.white,
                    fontSize: 35.sp,
                    fontWeight: FontWeight.w700),
              ),
              SizedBox(height: 16.h),
              ClipRRect(
                borderRadius: const BorderRadius.all(Radius.circular(25)),
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 30, sigmaY: 30),
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 15.w),
                    width: 450.w,
                    height: 500.h,
                    decoration: BoxDecoration(
                      color: Colors.grey.withOpacity(0.1),
                      borderRadius: BorderRadius.all(
                        Radius.circular(25.r),
                      ),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 20.sp,
                        ),
                        SizedBox(
                          width: 300.w,
                          child: Text(
                            "It seems you dont't have an account, lets create one.",
                            style: GoogleFonts.redHatDisplay(
                                fontSize: 14.sp, fontWeight: FontWeight.w400),
                          ),
                        ),
                        SizedBox(height: 35.h),
                        AppTextField(
                          keybordType: TextInputType.name,
                          onchaged: (value) {
                            setUsernameError(value ?? '');
                          },
                          labelText: 'Username',
                          errorText: usernameErrorText,
                          hintText: 'sammy_boy',
                          icon: IconlyBold.profile,
                        ),
                        SizedBox(
                          height: 16.h,
                        ),
                        AppTextField(
                          keybordType: TextInputType.emailAddress,
                          onchaged: (value) {
                            validateEmail(value ?? '');
                          },
                          labelText: 'email',
                          errorText: emailErrorText,
                          hintText: 'sammy@gmail.com',
                          icon: IconlyBold.message,
                        ),
                        SizedBox(
                          height: 16.h,
                        ),
                        AppTextField(
                          onchaged: (v) {
                            setPasswordError(v ?? '');
                          },
                          obscureText: showPassword,
                          labelText: 'Password',
                          errorText: passwordErrorText,
                          hintText: '********',
                          icon: IconlyBold.lock,
                          suffix: GestureDetector(
                            onTap: () {
                              showPassword = !showPassword;
                              setState(() {});
                            },
                            child: Icon(
                                showPassword
                                    ? Icons.visibility
                                    : Icons.visibility_off,
                                color: Colors.black87),
                          ),
                        ),
                        SizedBox(
                          height: 20.h,
                        ),
                        AppPrimaryButton(
                          color: Theme.of(context).colorScheme.secondary,
                          title: 'proceed',
                        ),
                        const Divider(),
                        const AppPrimaryButton(
                          title: 'Sign in with google',
                          putIcon: false,
                        ),
                        SizedBox(
                          height: 20.h,
                        ),
                        AuthBottomText(
                          title: 'Already have an account?',
                          actionText: 'Login',
                          onClick: () {},
                        )
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
