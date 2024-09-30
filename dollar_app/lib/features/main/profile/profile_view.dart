import 'package:dollar_app/features/main/profile/widgets/log_out_dialog.dart';
import 'package:dollar_app/features/main/profile/widgets/profile_body_widgets.dart';
import 'package:dollar_app/features/shared/widgets/app_primary_button.dart';
import 'package:dollar_app/features/shared/widgets/custom_app_bar.dart';
import 'package:dollar_app/features/shared/widgets/dialog_method.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconly/iconly.dart';

class ProfileView extends StatefulWidget {
  const ProfileView({super.key});

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: Text(
          "Profile",
          style: GoogleFonts.lato(fontWeight: FontWeight.bold),
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 23.w, vertical: 20.h),
        child: Column(
          children: [
            Container(
              height: 180.h,
              width: double.infinity,
              decoration: BoxDecoration(
                  color: Theme.of(context).cardColor,
                  borderRadius: BorderRadius.circular(15)),
              child: Column(children: [
                SizedBox(
                  height: 20.h,
                ),
                Container(
                  padding: const EdgeInsets.all(15),
                  decoration: BoxDecoration(
                      color: Colors.grey.shade300, shape: BoxShape.circle),
                  child: Icon(
                    Icons.person,
                    color: Theme.of(context).primaryColor,
                  ),
                ),
                SizedBox(
                  height: 20.h,
                ),
                Text(
                  "Sammy Ovia",
                  style: GoogleFonts.lato(
                      fontSize: 20.sp, fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 20.h,
                ),
                AppPrimaryButton(
                    putIcon: false,
                    color: Theme.of(context).primaryColor,
                    enabled: true,
                    height: 30.h,
                    width: 200.w,
                    title: 'Edit')
              ]),
            ),
            SizedBox(height: 20.h),
            const ProfileBodyWidget(
              prefixIcon: IconlyBold.profile,
              title: 'Profile',
              suffixIcon: IconlyBold.arrow_right,
            ),
            SizedBox(height: 10.h),
            const ProfileBodyWidget(
              prefixIcon: IconlyBold.wallet,
              title: 'Wallet',
              suffixIcon: IconlyBold.arrow_right,
            ),
            SizedBox(height: 10.h),
            ProfileBodyWidget(
              onClick: () {
                context.push('/profile/admin');
              },
              prefixIcon: Icons.admin_panel_settings,
              title: 'Admin',
              suffixIcon: IconlyBold.arrow_right,
            ),
            SizedBox(height: 10.h),
            ProfileBodyWidget(
              onClick: () {
                context.go('/profile/videos');
              },
              prefixIcon: Icons.video_camera_front,
              title: 'Videos',
              suffixIcon: IconlyBold.arrow_right,
            ),
            SizedBox(height: 10.h),
            ProfileBodyWidget(
              onClick: () {
                context.go('/profile/theme');
              },
              prefixIcon: Icons.light_mode,
              title: 'Theme',
              suffixIcon: IconlyBold.arrow_right,
            ),
            SizedBox(height: 10.h),
            const ProfileBodyWidget(
              prefixIcon: Icons.question_mark_outlined,
              title: 'FAQS',
              suffixIcon: IconlyBold.arrow_right,
            ),
            SizedBox(height: 10.h),
            const ProfileBodyWidget(
              prefixIcon: Icons.phone,
              title: 'Contact Us',
              suffixIcon: IconlyBold.arrow_right,
            ),
            SizedBox(height: 10.h),
            const ProfileBodyWidget(
              prefixIcon: Icons.delete,
              title: 'Delete Account',
              suffixIcon: IconlyBold.arrow_right,
            ),
            SizedBox(height: 10.h),
            ProfileBodyWidget(
              onClick: () {
                diolagMethod(context, child: const LogoutDialog());
              },
              prefixIcon: Icons.logout,
              title: 'Log out',
              suffixIcon: IconlyBold.arrow_right,
            ),
          ],
        ),
      ),
    );
  }
}
