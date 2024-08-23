import 'dart:ui';

import 'package:dollar_app/features/auth/providers/login_provider.dart';
import 'package:dollar_app/features/auth/view/otp_view.dart';
import 'package:dollar_app/features/auth/widgets/auth_bottom_text.dart';
import 'package:dollar_app/features/shared/constant/image_constant.dart';
import 'package:dollar_app/features/shared/widgets/app_primary_button.dart';
import 'package:dollar_app/features/shared/widgets/app_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconly/iconly.dart';

class LoginView extends ConsumerStatefulWidget {
  const LoginView({super.key});

  @override
  ConsumerState<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends ConsumerState<LoginView> {
  bool showPassword = true;
  String email = '';
  String password = '';
  bool validated = false;

  void validate() {
    final valid = email.isNotEmpty && password.isNotEmpty;
    setState(() {
      validated = valid;
    });
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
                  opacity: 0.1)),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Login",
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
                    height: 450.h,
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
                            "Login to access great contents.",
                            style: GoogleFonts.redHatDisplay(
                                fontSize: 14.sp, fontWeight: FontWeight.w400),
                          ),
                        ),
                        SizedBox(height: 35.h),
                        AppTextField(
                          keybordType: TextInputType.emailAddress,
                          onchaged: (value) {
                            email = value!;
                            validate();
                          },
                          labelText: 'email',
                          errorText: '',
                          hintText: 'sammy@gmail.com',
                          icon: IconlyBold.message,
                        ),
                        SizedBox(
                          height: 16.h,
                        ),
                        AppTextField(
                          onchaged: (v) {
                            password = v!;
                            validate();
                          },
                          obscureText: showPassword,
                          labelText: 'Password',
                          errorText: '',
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
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const OTPView(),
                              ),
                            );
                          },
                          child: Align(
                            alignment: Alignment.centerRight,
                            child: Text(
                              "Forgot Password?",
                              style: GoogleFonts.redHatDisplay(
                                fontSize: 12.sp,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 20.h,
                        ),
                        AppPrimaryButton(
                          enabled: validated,
                          onPressed: () {
                            if (validated) {
                              ref.read(loginProvider.notifier).login(context,
                                  email: email, password: password);
                            }
                          },
                          isLoading: ref.watch(loginProvider).isLoading,
                          color: Colors.black,
                          title: 'login',
                        ),
                        const Divider(),
                        AppPrimaryButton(
                          color: Theme.of(context).colorScheme.primary,
                          title: 'Sign in with google',
                          putIcon: false,
                        ),
                        SizedBox(
                          height: 20.h,
                        ),
                        AuthBottomText(
                          title: "Are you new on our platform? ",
                          actionText: 'Register',
                          onClick: () {
                            GoRouter.of(context).go('/register');
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
      ),
    );
  }
}
