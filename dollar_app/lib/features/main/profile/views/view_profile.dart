import 'package:dollar_app/features/main/profile/model/profile_model.dart';
import 'package:dollar_app/features/main/profile/providers/get_profile_provider.dart';
import 'package:dollar_app/features/main/profile/widgets/profile_body_widgets.dart';
import 'package:dollar_app/features/shared/widgets/custom_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconly/iconly.dart';

class ViewProfile extends ConsumerStatefulWidget {
  const ViewProfile({super.key, required this.userData});
  final ProfileData userData;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ViewProfileState();
}

class _ViewProfileState extends ConsumerState<ViewProfile> {
  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Scaffold(
      appBar: CustomAppBar(
        title: Text(
          "View Profile",
          style: GoogleFonts.aBeeZee(fontWeight: FontWeight.bold, fontSize: 14.sp),
        ),
      ),
      body: RefreshIndicator(
        onRefresh: () async{
          ref.read(getProfileProvider.notifier).getProfile();
        },
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 23.w, vertical: 20.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 20.h,
              ),
              Align(
                alignment: Alignment.center,
                child: Container(
                  width: 100.w,
                  height: 100.h,
                  decoration: BoxDecoration(
                      image: widget.userData.avatar != null ? DecorationImage(
                          image: NetworkImage(widget.userData.avatar!),
                          fit: BoxFit.cover): null,
                      border: Border.all(
                          color: Theme.of(context).dividerColor),
                      shape: BoxShape.circle),
                ),
              ),
              SizedBox(height: 20.h),
              Text(
                "First Name",
                style: GoogleFonts.lato(
                    fontWeight: FontWeight.w500,
                    fontSize: 12.sp,
                    color: isDark ? Theme.of(context).dividerColor : null),
              ),
              SizedBox(height: 5.h,),
              ProfileBodyWidget(
                prefixIcon: IconlyBold.profile,
                title: "${widget.userData.firstName}",
              ),
              SizedBox(height: 10.h),
              Text(
                "Last Name",
                style: GoogleFonts.lato(
                    fontWeight: FontWeight.w500,
                    fontSize: 12.sp,
                    color: isDark ? Theme.of(context).dividerColor : null),
              ),
              SizedBox(height: 5.h,),
              ProfileBodyWidget(
                prefixIcon: IconlyBold.profile,
                title: "${widget.userData.lastName}",
              ),
              SizedBox(height: 10.h),
              Text(
                "Email",
                style: GoogleFonts.lato(
                    fontWeight: FontWeight.w500,
                    fontSize: 12.sp,
                    color: isDark ? Theme.of(context).dividerColor : null),
              ),
              SizedBox(height: 5.h,),
              ProfileBodyWidget(
                prefixIcon: IconlyBold.message,
                title: '${widget.userData.email}',
              ),
              SizedBox(height: 10.h),
              Text(
                "Phone Number",
                style: GoogleFonts.lato(
                    fontWeight: FontWeight.w500,
                    fontSize: 12.sp,
                    color: isDark ? Theme.of(context).dividerColor : null),
              ),
              SizedBox(height: 5.h,),
              ProfileBodyWidget(
                prefixIcon: Icons.phone,
                title: '${widget.userData.phoneNumber}',
              ),
              SizedBox(height: 10.h),
              Text(
                "Status",
                style: GoogleFonts.lato(
                    fontWeight: FontWeight.w500,
                    fontSize: 12.sp,
                    color: isDark ? Theme.of(context).dividerColor : null),
              ),
              SizedBox(height: 5.h,),
              ProfileBodyWidget(
                prefixIcon: Icons.local_activity,
                title: '${widget.userData.status}',
              ),
              SizedBox(height: 10.h),
              Text(
                "Email Status",
                style: GoogleFonts.lato(
                    fontWeight: FontWeight.w500,
                    fontSize: 12.sp,
                    color: isDark ? Theme.of(context).dividerColor : null),
              ),
              SizedBox(height: 5.h,),
              const ProfileBodyWidget(
                prefixIcon: Icons.check,
                title: 'Verified',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
