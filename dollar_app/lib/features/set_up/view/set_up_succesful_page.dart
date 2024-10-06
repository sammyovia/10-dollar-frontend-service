import 'package:dollar_app/features/shared/widgets/app_primary_button.dart';
import 'package:dollar_app/features/shared/widgets/custom_app_bar.dart';
import 'package:dollar_app/services/router/app_router.dart';
import 'package:dollar_app/services/router/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class SetUPSuccessfulView extends ConsumerStatefulWidget {
  const SetUPSuccessfulView({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _SetUPSuccessfulViewState();
}

class _SetUPSuccessfulViewState extends ConsumerState<SetUPSuccessfulView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        showNofication: false,
        title: Text(
          "Complete Setup",
          style:
              GoogleFonts.aBeeZee(fontSize: 14.sp, fontWeight: FontWeight.bold),
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(
              height: 20.h,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: Card(
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 20.w),
                  height: 200.h,
                  width: double.infinity,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        width: 100.w,
                        height: 50.h,
                        decoration: BoxDecoration(
                            border: const Border(
                                bottom:
                                    BorderSide(width: 3, color: Colors.grey),
                                right:
                                    BorderSide(width: 3, color: Colors.grey)),
                            borderRadius: BorderRadius.circular(8),
                            color: Theme.of(context).primaryColor),
                        child: Center(
                          child: Icon(
                            Icons.check,
                            size: 40.r,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 20.h,
                      ),
                      Text(
                        "Profile Setup Successful",
                        style: GoogleFonts.lato(
                            fontSize: 14.sp, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: 20.h,
                      ),
                      AppPrimaryButton(
                        putIcon: false,
                        title: "Go To Home",
                        onPressed: () {
                          ref.read(router).go(AppRoutes.home);
                        },
                        enabled: true,
                      )
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
