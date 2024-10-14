import 'package:dollar_app/features/main/admin/posts/view/pinne_post.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';


class AdminPostView extends ConsumerStatefulWidget {
  const AdminPostView({super.key});

  @override
  ConsumerState createState() => _AdminPostViewState();
}

class _AdminPostViewState extends ConsumerState<AdminPostView> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:  EdgeInsets.symmetric(horizontal: 20.w),
      child: Column(
        children: [
          SizedBox(height: 10.h,),
          const PinnedInfoWidget(),
        ],
      ),
    );
  }
}
