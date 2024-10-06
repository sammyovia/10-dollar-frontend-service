import 'dart:ui';

import 'package:dollar_app/features/auth/providers/google_sign_in_provider.dart';
import 'package:dollar_app/features/auth/providers/register_provider.dart';
import 'package:dollar_app/features/auth/widgets/auth_bottom_text.dart';
import 'package:dollar_app/features/shared/constant/image_constant.dart';
import 'package:dollar_app/features/shared/widgets/app_primary_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconly/iconly.dart';
import 'package:go_router/go_router.dart';

import '../../shared/widgets/app_text_field.dart';

class RegisterView extends ConsumerStatefulWidget {
  const RegisterView({super.key});

  @override
  ConsumerState<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends ConsumerState<RegisterView> {
  String userName = '';
  String usernameErrorText = '';
  String email = '';
  String password = '';
  String confirmPassword = '';
  String emailErrorText = '';
  String passwordErrorText = '';
  String confirmPasswordErrorText = '';
  bool showPassword = true;
  bool showConfirmPassword = true;
  bool validated = false;

  void validate() {
    final hasEmail = email.isNotEmpty && emailErrorText.isEmpty;
    final hasPassword = password.isNotEmpty && passwordErrorText.isEmpty;
    final hasConfimpassword = password == confirmPassword;
    final valid = hasEmail && hasPassword && hasConfimpassword;

    setState(() {
      validated = valid;
    });
  }

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

  void setConfirmPasswordError(String value) {
    confirmPassword = value; // Update confirmPassword first
    if (password != confirmPassword) {
      confirmPasswordErrorText = 'passwords do not match';
    } else {
      confirmPasswordErrorText = '';
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
      body: Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(horizontal: 23.w),
        decoration: const BoxDecoration(
            //color: Color(0xFFF5F5F5),
            image: DecorationImage(
                image: AssetImage(AppImages.onboarding2),
                fit: BoxFit.fill,
                opacity: 0.1)),
        child: ListView(
  
          children: [
            SizedBox(
              height: 30.h,
            ),
            Text(
              "Sign up",
              style: GoogleFonts.aBeeZee(
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
                  padding:
                      EdgeInsets.symmetric(horizontal: 15.w, vertical: 10.h),
                  width: 450.w,
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
                          style: GoogleFonts.lato(
                              fontSize: 14.sp, fontWeight: FontWeight.w400),
                        ),
                      ),
                      SizedBox(height: 35.h),
                      AppTextField(
                        keybordType: TextInputType.emailAddress,
                        onchaged: (value) {
                          validateEmail(value ?? '');
                          email = value!;
                          validate();
                        },
                        labelText: 'email',
                        errorText: emailErrorText,
                        hintText: 'sammy@gmail.com',
                        icon: IconlyBold.message,
                      ),
                      SizedBox(
                        height: 8.h,
                      ),
                      AppTextField(
                        onchaged: (v) {
                          password = v!;
                          setPasswordError(v);
                          setConfirmPasswordError(v);
                          validate();
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
                            size: 17.r,
                            color: Theme.of(context).dividerColor,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 8.h,
                      ),
                      AppTextField(
                        onchaged: (v) {
                          confirmPassword = v!;
                          setConfirmPasswordError(v);
                          validate();
                        },
                        obscureText: showPassword,
                        labelText: 'Confirm Password',
                        errorText: confirmPasswordErrorText,
                        hintText: '********',
                        icon: IconlyBold.lock,
                        suffix: GestureDetector(
                          onTap: () {
                            showConfirmPassword = !showConfirmPassword;
                            setState(() {});
                          },
                          child: Icon(
                            showConfirmPassword
                                ? Icons.visibility
                                : Icons.visibility_off,
                                color: Theme.of(context).dividerColor,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 20.h,
                      ),
                      AppPrimaryButton(
                        putIcon: false,
                        height: 35.h,
                        enabled: validated,
                        isLoading: ref.watch(registerProvider).isLoading,
                        onPressed: () {
                          if (validated) {
                            ref.read(registerProvider.notifier).register(
                                context,
                                email: email,
                                password: password);
                          }
                        },
                        color: Colors.black,
                        title: 'Register',
                      ),
                      Divider(
                        color: Theme.of(context).dividerColor,
                      ),
                      AppPrimaryButton(
                        height: 35.h,
                        enabled: true,
                        isLoading: ref.watch(googleSinginProvider).isLoading,
                        onPressed: () => ref
                            .read(googleSinginProvider.notifier)
                            .signInWithGoogle(context),
                        color: Theme.of(context).colorScheme.primary,
                        title: 'Sign in with google',
                        putIcon: false,
                      ),
                      SizedBox(
                        height: 20.h,
                      ),
                      AuthBottomText(
                        title: 'Already have an account?',
                        actionText: 'Login',
                        onClick: () {
                          GoRouter.of(context).go('/login');
                        },
                      )
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
