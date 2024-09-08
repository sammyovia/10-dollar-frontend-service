import 'package:dollar_app/features/auth/providers/change_password_provider.dart';
import 'package:dollar_app/features/auth/providers/forgot_password_code_provider.dart';
import 'package:dollar_app/features/auth/providers/resend_auth_otp.dart';
import 'package:dollar_app/features/shared/widgets/app_primary_button.dart';
import 'package:dollar_app/features/shared/widgets/app_text_field.dart';
import 'package:dollar_app/features/shared/widgets/custom_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconly/iconly.dart';
import 'package:pinput/pinput.dart';

class OTPView extends ConsumerStatefulWidget {
  const OTPView({super.key});

  @override
  ConsumerState<OTPView> createState() => _OTPViewState();
}

class _OTPViewState extends ConsumerState<OTPView> {
  String email = '';
  String password = '';
  String confirmPassword = '';
  String passwordError = '';
  String confirmPasswordError = '';
  String code = '';
  bool validated = false;
  bool confirmPasswordValidated = false;

  setPasswordError(String value) {
    if (value.length < 8) {
      passwordError = 'password cannot be less than six characters';
    } else {
      passwordError = '';
    }

    setState(() {});
  }

  setConfirmPasswordError(String value) {
    if (value != password) {
      confirmPasswordError = 'passwords does not match';
    } else {
      confirmPasswordError = '';
    }

    setState(() {});
  }

  void validate() {
    setState(() {
      validated = email.isNotEmpty;
    });
  }

  void validateConfirmPassword() {
    final hasemail = validated;
    final hasPassword = password.isNotEmpty && passwordError.isEmpty;
    final hasConfirmPassword = confirmPassword == password;
    final valid =
        hasemail && hasPassword && hasConfirmPassword && code.length == 6;

    setState(() {
      confirmPasswordValidated = valid;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: CustomAppBar(
        action: const [],
        title: Text(
          "OTP",
          style: GoogleFonts.lato(fontWeight: FontWeight.bold),
        ),
      ),
      body: PopScope(
        onPopInvokedWithResult: (didPop, v) {
          ref.invalidate(forgotPasswordCodeProvider);
          ref.invalidate(changePasswordProvider);
          ref.invalidate(reseendOtpAuth);
        },
        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: Column(
              children: [
                SizedBox(
                  height: 20.h,
                ),
                AppTextField(
                    onchaged: (value) {
                      email = value!;
                      validate();
                    },
                    labelText: '',
                    errorText: '',
                    hintText: 'Enter email',
                    icon: IconlyBold.message),
                SizedBox(
                  height: 20.h,
                ),
                if (ref.watch(forgotPasswordCodeProvider).value != null &&
                    ref.watch(forgotPasswordCodeProvider).value?['success'] ==
                        true)
                  Column(
                    children: [
                      AppTextField(
                          onchaged: (value) {
                            password = value!;
                            setPasswordError(value);
                            validateConfirmPassword();
                          },
                          labelText: '',
                          errorText: passwordError,
                          hintText: 'Enter Password',
                          icon: IconlyBold.lock),
                      SizedBox(
                        height: 10.h,
                      ),
                      AppTextField(
                          onchaged: (value) {
                            confirmPassword = value!;
                            setConfirmPasswordError(value);
                            validateConfirmPassword();
                          },
                          labelText: '',
                          errorText: confirmPasswordError,
                          hintText: 'Confirm Password',
                          icon: IconlyBold.lock),
                      SizedBox(
                        height: 50.h,
                      ),
                      Text(
                        'Enter OTP',
                        style: GoogleFonts.notoSans(
                            fontSize: 16.sp, fontWeight: FontWeight.w700),
                      ),
                      SizedBox(
                        height: 10.h,
                      ),
                      Pinput(
                        onCompleted: (value) {
                          setState(() {
                            code = value;
                          });
                        },
                        length: 6,
                      ),
                      Align(
                        alignment: Alignment.centerRight,
                        child: IconButton(
                          onPressed: () {
                            ref
                                .read(reseendOtpAuth.notifier)
                                .resendOtp(context, email: email);
                          },
                          icon: Text(
                            "Resend-OTP",
                            style: GoogleFonts.redHatDisplay(
                                fontWeight: FontWeight.bold,
                                color: Theme.of(context).colorScheme.primary),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 100.h,
                      ),
                    ],
                  ),
                ref.watch(forgotPasswordCodeProvider).value != null &&
                        ref
                                .watch(forgotPasswordCodeProvider)
                                .value?['success'] ==
                            true
                    ? AppPrimaryButton(
                        isLoading:
                            ref.watch(changePasswordProvider).isLoading ||
                                ref.watch(reseendOtpAuth).isLoading,
                        enabled: validated,
                        onPressed: () {
                          ref
                              .watch(changePasswordProvider.notifier)
                              .changePassword(context,
                                  email: email,
                                  password: password,
                                  confirmPassword: confirmPassword,
                                  code: code);
                        },
                        title: 'Change Password',
                        color: Theme.of(context).primaryColor,
                      )
                    : AppPrimaryButton(
                        isLoading:
                            ref.watch(forgotPasswordCodeProvider).isLoading,
                        enabled: validated,
                        onPressed: () {
                          ref
                              .read(forgotPasswordCodeProvider.notifier)
                              .getCode(context, email: email);
                        },
                        title: 'Request OTP Code',
                        color: Theme.of(context).primaryColor,
                      ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
