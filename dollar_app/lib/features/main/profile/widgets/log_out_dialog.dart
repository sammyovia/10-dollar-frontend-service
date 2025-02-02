import 'package:dollar_app/features/main/profile/providers/log_out_provider.dart';
import 'package:dollar_app/features/shared/widgets/app_primary_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class LogoutDialog extends ConsumerStatefulWidget {
  const LogoutDialog({
    super.key,
  });

  @override
  ConsumerState<LogoutDialog> createState() => _LoginDialogState();
}

class _LoginDialogState extends ConsumerState<LogoutDialog> {
  @override
  Widget build(
    BuildContext context,
  ) {
    return SizedBox(
      height: 250.h,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 36),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Log out',
                    style: GoogleFonts.redHatDisplay(
                        fontWeight: FontWeight.bold, fontSize: 22.sp)),
                Text('Seems you want to log out of your account',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.redHatDisplay(
                        fontSize: 15.sp, color: Colors.grey)),
              ],
            ),
            SizedBox(
              height: 36.h,
            ),
            if (ref.watch(logoutProvider).isLoading)
              const CircularProgressIndicator(),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                AppPrimaryButton(
                  putIcon: false,
                  enabled: true,

                  width: 100.w,
                  title: 'Cancel',
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  color: Colors.grey,
                ),
                SizedBox(width: 50.w,),
                AppPrimaryButton(
                  enabled: true,
                  putIcon: false,
                  width: 100.w,
                  onPressed: () {
                    ref.read(logoutProvider.notifier).logout(context);
                  },
                  title: 'Logout',
                  color: Theme.of(context).colorScheme.primary,
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
