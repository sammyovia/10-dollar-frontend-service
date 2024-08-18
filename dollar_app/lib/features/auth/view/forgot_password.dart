import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconly/iconly.dart';

import '../../shared/widgets/app_primary_button.dart';
import '../../shared/widgets/app_text_field.dart';

class ChangePasswordPage extends StatefulWidget {
  const ChangePasswordPage({super.key});

  @override
  State<ChangePasswordPage> createState() => _ChangePasswordPageState();
}

class _ChangePasswordPageState extends State<ChangePasswordPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Change Password',
          style: GoogleFonts.lato(color: Colors.white),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: Column(
            children: [
              SizedBox(
                height: 20.h,
              ),
              const AppTextField(
                  labelText: '',
                  errorText: '',
                  hintText: 'Enter Password',
                  icon: IconlyBold.lock),
              SizedBox(
                height: 10.h,
              ),
              const AppTextField(
                  labelText: '',
                  errorText: '',
                  hintText: 'Confirm Password',
                  icon: IconlyBold.lock),
              SizedBox(
                height: 50.h,
              ),
              AppPrimaryButton(
                title: 'Change Password',
                color: Theme.of(context).primaryColor,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
