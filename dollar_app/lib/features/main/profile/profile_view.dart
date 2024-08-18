import 'package:dollar_app/features/auth/view/otp_view.dart';
import 'package:dollar_app/features/shared/widgets/app_primary_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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
              height: 170.h,
              width: double.infinity,
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey.shade300),
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
                    color: Theme.of(context).primaryColor,
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
            const ProfileBodyWidget(
              prefixIcon: Icons.admin_panel_settings,
              title: 'Admin',
              suffixIcon: IconlyBold.arrow_right,
            ),
            SizedBox(height: 10.h),
            const ProfileBodyWidget(
              prefixIcon: Icons.video_camera_front,
              title: 'Saved Videos',
              suffixIcon: IconlyBold.arrow_right,
            ),
            SizedBox(height: 10.h),
            const ProfileBodyWidget(
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
            const ProfileBodyWidget(
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

class ProfileBodyWidget extends StatelessWidget {
  const ProfileBodyWidget(
      {super.key,
      required this.prefixIcon,
      required this.title,
      this.suffixIcon});
  final IconData prefixIcon;
  final String title;
  final IconData? suffixIcon;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      height: 40.h,
      width: double.infinity,
      decoration: BoxDecoration(
          border: Border.all(color: Colors.grey.shade300),
          borderRadius: BorderRadius.circular(8)),
      child: Row(children: [
        Icon(
          prefixIcon,
          color: Theme.of(context).primaryColor,
        ),
        SizedBox(
          width: 20.w,
        ),
        Text(
          title,
          style: GoogleFonts.lato(fontSize: 14.sp),
        ),
        const Spacer(),
        if (suffixIcon != null)
          Icon(
            suffixIcon,
            color: Theme.of(context).primaryColor,
          )
      ]),
    );
  }
}
