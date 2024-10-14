import 'package:dollar_app/features/main/profile/providers/get_profile_provider.dart';
import 'package:dollar_app/services/router/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:iconly/iconly.dart';

class CustomAppBar extends StatelessWidget implements PreferredSize {
  const CustomAppBar(
      {super.key,
      this.title,
      this.centerTitle = true,
      this.actions,
      this.height = kToolbarHeight,
      this.elevation = 0,
      this.showLeading = false,
      this.showSearch = false,
      this.showProfile = false,
      this.action,
      this.showNofication = true,
      this.bottom,
      this.backgroundColor});
  final Widget? title;
  final bool centerTitle;
  final List<Widget>? actions;
  final double height;
  final double elevation;
  final bool showLeading;
  final bool showSearch;
  final bool showProfile;
  final List<Widget>? action;
  final bool showNofication;
  final PreferredSizeWidget? bottom;
  final Color? backgroundColor;

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, ref, child) {
        final image = ref.watch(getProfileProvider).value?.avatar;

        return AppBar(
          automaticallyImplyLeading: true,
          elevation: elevation,
          backgroundColor: backgroundColor ?? Theme.of(context).colorScheme.surface,
          centerTitle: centerTitle,
          leadingWidth: showLeading ? 100.w : null,
          leading: showLeading
              ? Image.asset(
                  'assets/images/dlog.png',
                )
              : null,
          title: title,
          bottom: bottom,
          actions: action ??
              [
                if (showSearch)
                  IconButton(
                    onPressed: () {},
                    icon: Icon(
                      IconlyLight.search,
                      size: 20.r,
                    ),
                  ),
                if (showNofication)
                  IconButton(
                    onPressed: () {},
                    icon: Icon(
                      IconlyBold.notification,
                      size: 20.r,
                    ),
                  ),
                if (showProfile)
                  IconButton(
                    onPressed: () {
                      context.push(AppRoutes.profile);
                    },
                    icon: CircleAvatar(
                        radius: 15.r,
                        backgroundColor: Colors.grey.shade300,
                        backgroundImage:
                            image != null ? NetworkImage(image) : null),
                  ),
              ],
          scrolledUnderElevation: 1,
        );
      },
    );
  }

  @override
  Widget get child => Container();

  @override
  Size get preferredSize => Size.fromHeight(height);
}
