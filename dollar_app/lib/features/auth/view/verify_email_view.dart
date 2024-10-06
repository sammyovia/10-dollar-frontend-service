import 'package:dollar_app/features/auth/providers/verify_email_provider.dart';
import 'package:dollar_app/features/shared/widgets/custom_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pinput/pinput.dart';

class VerifyEmailView extends ConsumerStatefulWidget {
  const VerifyEmailView({super.key, required this.email});
  final String email;

  @override
  ConsumerState<VerifyEmailView> createState() => _VerifyEmailViewState();
}

class _VerifyEmailViewState extends ConsumerState<VerifyEmailView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: CustomAppBar(
        showNofication: false,
        title: Text(
          'Verify Email',
          style:
              GoogleFonts.aBeeZee(fontSize: 14.sp, fontWeight: FontWeight.bold),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: Column(
            children: [
              SizedBox(
                height: 10.h,
              ),
              Text(
                "Enter the OTP code sent to ${widget.email}",
                style: GoogleFonts.lato(fontSize: 12.sp),
              ),
              SizedBox(
                height: 20.h,
              ),
              Pinput(
                length: 6,
                onCompleted: (value) {
                  ref
                      .read(verifyEmailProvider.notifier)
                      .verifyEmail(context, code: value, email: widget.email);
                },
                defaultPinTheme: PinTheme(
                    decoration: BoxDecoration(
                        border:
                            Border.all(color: Theme.of(context).dividerColor),
                        borderRadius: BorderRadius.circular(8)),
                    width: 100.w,
                    height: 40.h),
                focusedPinTheme: PinTheme(
                    decoration: BoxDecoration(
                        border:
                            Border.all(color: Theme.of(context).primaryColor),
                        borderRadius: BorderRadius.circular(8)),
                    width: 100.w,
                    height: 40.h),
              ),
              Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                  onPressed: () {
                    ref
                        .read(verifyEmailProvider.notifier)
                        .resendCode(context, email: widget.email);
                  },
                  child: Text(
                    "Resend Code",
                    style: GoogleFonts.lato(fontSize: 12.sp),
                  ),
                ),
              ),
              SizedBox(
                height: 5.h,
              ),
              if (ref.watch(verifyEmailProvider).isLoading)
                const LinearProgressIndicator(),
            ],
          ),
        ),
      ),
    );
  }
}
