import 'package:dollar_app/features/main/admin/users/model/user.dart';
import 'package:dollar_app/features/main/admin/users/provider/user_role_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../shared/widgets/app_primary_button.dart';

class UserRoleWidget extends ConsumerStatefulWidget {
  const UserRoleWidget({
    super.key,
    required this.user,
  });
  final UserDatum user;


  @override
  ConsumerState<UserRoleWidget> createState() => _UserRoleWidgetState();
}

class _UserRoleWidgetState extends ConsumerState<UserRoleWidget> {
  int _selectedIndex = -1;
  String _selectedRole = '';
  final _roles = [
    'USER',
    'ARTIST',
    'ADMIN',
  ];

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Column(
        children: [
          SizedBox(
            height: 20.h,
          ),
          Text(
            'Upgrade Or Downgrade User',
            style: GoogleFonts.lato(fontSize: 18.sp),
          ),
          SizedBox(
            height: 10.h,
          ),
          Divider(
            color: Theme.of(context).dividerColor,
          ),
          SizedBox(
            height: 10.h,
          ),
          ListView.builder(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              shrinkWrap: true,
              itemCount: _roles.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    setState(() {
                      _selectedIndex = index;
                      _selectedRole = _roles[index];
                    });
                  },
                  child: Container(
                      margin: EdgeInsets.only(bottom: 10.h),
                      padding: EdgeInsets.all(10.r),
                      width: double.infinity,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8.r),
                        border: Border.all(
                            color: _selectedIndex == index
                                ? Theme.of(context).primaryColor
                                : Theme.of(context).dividerColor),
                      ),
                      child: Text(_roles[index])),
                );
              }),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              AppPrimaryButton(
                  onPressed: () {
                    ref.invalidate(userRoleProvider);
                    Navigator.of(context, rootNavigator: true).pop();
                  },
                  color: Colors.grey,
                  enabled: true,
                  putIcon: false,
                  height: 35.h,
                  width: 100.w,
                  title: 'back'),


              SizedBox(
                width: 30.w,
              ),
              AppPrimaryButton(
                  onPressed: () {
                    if (_selectedRole.isNotEmpty) {
                      ref.read(userRoleProvider.notifier).changeUserRole(
                          context,
                          id: widget.user.id!,
                          newRole: _selectedRole);
                    }
                  },
                  color: Theme.of(context).primaryColor,
                  enabled: _selectedRole.isNotEmpty,
                  putIcon: false,
                  height: 35.h,
                  width: 100.w,
                  isLoading: ref.watch(userRoleProvider).isLoading,
                  title: "Proceed")
            ],
          ),
          SizedBox(
            height: 20.h,
          ),
        ],
      ),
    );
  }
}
