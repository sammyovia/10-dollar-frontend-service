import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../shared/widgets/app_primary_button.dart';
import '../model/feeds_model.dart';
import '../providers/delete_post_provider.dart';


class DeletePostWidget extends ConsumerStatefulWidget {
  const DeletePostWidget({
    super.key,
    required this.post,
  });

  final FeedModelData post;

  @override
  ConsumerState<DeletePostWidget> createState() => _DeleteUserWidgetState();
}

class _DeleteUserWidgetState extends ConsumerState<DeletePostWidget> {
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
            'Delete Post',
            style: GoogleFonts.aBeeZee(fontSize: 18.sp),
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
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              AppPrimaryButton(
                  isLoading: ref.watch(deletePostProvider).isLoading,
                  onPressed: () {
                    ref
                        .read(deletePostProvider.notifier)
                        .deletePost(context, id: widget.post.id);
                  },
                  color: Colors.red,
                  enabled: true,
                  putIcon: false,
                  height: 35.h,
                  width: 100.w,
                  title: 'Delete'),
              SizedBox(
                width: 30.w,
              ),
              AppPrimaryButton(
                  onPressed: () {
                    Navigator.of(context, rootNavigator: true).pop();
                  },
                  color: Colors.grey,
                  enabled: true,
                  putIcon: false,
                  height: 35.h,
                  width: 100.w,
                  title: "Back")
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
