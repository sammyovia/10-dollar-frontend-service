import 'package:dollar_app/features/main/admin/users/provider/user_provider.dart';
import 'package:dollar_app/features/main/admin/users/widgets/user_chat_status.dart';
import 'package:dollar_app/features/shared/widgets/app_primary_button.dart';
import 'package:dollar_app/features/shared/widgets/shimmer_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../shared/widgets/app_bottom_sheet.dart';
import '../../../../shared/widgets/app_text_field.dart';
import '../widgets/delete_user_widget.dart';
import '../widgets/user_role.dart';

class UsersView extends ConsumerStatefulWidget {
  const UsersView({super.key});

  @override
  ConsumerState createState() => _UsersViewState();
}

class _UsersViewState extends ConsumerState<UsersView> {
  late TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final users = ref.watch(userProvider);
    return users.when(
        data: (data) {
          return data.isEmpty
              ? Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.w),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        "No Users Currently",
                        style: GoogleFonts.lato(),
                      ),
                      SizedBox(
                        height: 20.h,
                      ),
                      AppPrimaryButton(
                        enabled: true,
                        title: "retry",
                        onPressed: () {
                          ref.read(userProvider.notifier).getUsers();
                        },
                      )
                    ],
                  ),
                )
              : RefreshIndicator(
                  onRefresh: () async {
                    ref.read(userProvider.notifier).getUsers();
                  },
                  child: Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20.w),
                        child: AppTextField(
                            onchaged: (value) {
                              ref
                                  .watch(userProvider.notifier)
                                  .searchUsers(value!);
                            },
                            suffix: Icon(
                              Icons.search,
                              color: Theme.of(context).primaryColor,
                            ),
                            labelText: '',
                            errorText: '',
                            hintText: 'Search name, role'),
                      ),
                      Expanded(
                        child: ListView.builder(
                            padding: EdgeInsets.symmetric(
                                horizontal: 20.w, vertical: 10.h),
                            itemCount: data.length,
                            itemBuilder: (context, index) {
                              final user = data[index];
                              return SizedBox(
                                height: 100.h,
                                child: Card(
                                  child: Padding(
                                    padding: const EdgeInsets.all(10.0),
                                    child: Column(
                                      children: [
                                        Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            CircleAvatar(
                                              radius: 25.r,
                                              backgroundImage: user.avatar !=
                                                      null
                                                  ? NetworkImage(user.avatar!)
                                                  : null,
                                            ),
                                            SizedBox(
                                              width: 10.w,
                                            ),
                                            Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  "${user.firstName} ${user.lastName}",
                                                  style: GoogleFonts.lato(
                                                      fontSize: 14.sp),
                                                ),
                                                SizedBox(
                                                  height: 5.h,
                                                ),
                                                Text(
                                                  "${user.role}",
                                                  style: GoogleFonts.lato(
                                                      fontSize: 10.sp),
                                                ),
                                              ],
                                            ),
                                            const Spacer(),
                                            IconButton(
                                                onPressed: () {
                                                  AppBottomSheet
                                                      .showBottomSheet(context,
                                                          child:
                                                              DeleteUserWidget(
                                                                  user: user));
                                                },
                                                icon: Icon(
                                                  Icons.delete,
                                                  size: 17.r,
                                                  color: Theme.of(context)
                                                      .primaryColor,
                                                ))
                                          ],
                                        ),
                                        Divider(
                                          color: Theme.of(context).dividerColor,
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.end,
                                          children: [
                                            GestureDetector(
                                              onTap: () {
                                                AppBottomSheet.showBottomSheet(
                                                  isDismissible: false,
                                                  context,
                                                  child: UserRoleWidget(
                                                    user: user,
                                                  ),
                                                );
                                              },
                                              child: Container(
                                                width: 70.w,
                                                height: 22.h,
                                                decoration: BoxDecoration(
                                                    color:
                                                        Colors.amber.shade900,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            6)),
                                                child: Center(
                                                  child: Text(
                                                    "role",
                                                    style: GoogleFonts.lato(
                                                        fontSize: 9.sp,
                                                        color: Colors.white),
                                                  ),
                                                ),
                                              ),
                                            ),
                                            SizedBox(
                                              width: 15.w,
                                            ),
                                            GestureDetector(
                                              onTap: () {
                                                AppBottomSheet.showBottomSheet(
                                                  isDismissible: false,
                                                  context,
                                                  child: UserChatStatusWidget(
                                                    user: user,
                                                  ),
                                                );
                                              },
                                              child: Container(
                                                width: 70.w,
                                                height: 22.h,
                                                decoration: BoxDecoration(
                                                    color: user.chatStatus ==
                                                            'active'
                                                        ? Colors.green
                                                        : Colors.red,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            6)),
                                                child: Center(
                                                  child: Text(
                                                    "chat status",
                                                    style: GoogleFonts.lato(
                                                        fontSize: 9.sp,
                                                        color: Colors.white),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            }),
                      ),
                    ],
                  ),
                );
        },
        error: (error, trace) {
          return Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: Column(
              children: [
                Text(
                  error.toString(),
                  style: GoogleFonts.lato(),
                ),
                SizedBox(
                  height: 10.h,
                ),
                AppPrimaryButton(
                  enabled: true,
                  title: "Retry",
                  onPressed: () {
                    ref.read(userProvider.notifier).getUsers();
                  },
                )
              ],
            ),
          );
        },
        loading: () => const ShimmerWidget(
              layoutType: LayoutType.howVideo,
            ));
  }
}
