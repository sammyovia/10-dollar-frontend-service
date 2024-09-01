import 'package:dollar_app/features/main/videos/provider/like_delete_video_provider.dart';
import 'package:dollar_app/features/shared/widgets/app_primary_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class VotePopupWidget extends ConsumerStatefulWidget {
  const VotePopupWidget({super.key, this.onPress, required this.postId});
  final String postId;
  final VoidCallback? onPress;

  @override
  ConsumerState<VotePopupWidget> createState() => _VotePopupWidgetState();
}

class _VotePopupWidgetState extends ConsumerState<VotePopupWidget> {
  Future<void>? _pendingAddTodo;
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: _pendingAddTodo,
        builder: (context, snapShot) {
          final isErrored = snapShot.hasError &&
              snapShot.connectionState != ConnectionState.waiting;
          return SizedBox(
            height: 100.h,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                !isErrored
                    ? Text(
                        'This action cannot be undone',
                        style: GoogleFonts.lato(fontSize: 12.sp),
                      )
                    : Text(
                        snapShot.error.toString(),
                        style: GoogleFonts.lato(
                            fontSize: 12.sp, color: Colors.red),
                      ),
                SizedBox(
                  height: 10.h,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    AppPrimaryButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      width: 100.w,
                      height: 30.h,
                      title: 'cancel',
                      putIcon: false,
                    ),
                    SizedBox(
                      width: 10.w,
                    ),
                    AppPrimaryButton(
                      onPressed: () {
                        final future = ref
                            .read(likeDeleteVideoProvider.notifier)
                            .voteVideo(context, postId: widget.postId);

                        setState(() {
                          _pendingAddTodo = future;
                        });
                      },
                      isLoading:
                          snapShot.connectionState == ConnectionState.waiting,
                      width: 100.w,
                      height: 30.h,
                      title: 'vote',
                      putIcon: false,
                      enabled: true,
                      color: Colors.green,
                    )
                  ],
                )
              ],
            ),
          );
        });
  }
}
