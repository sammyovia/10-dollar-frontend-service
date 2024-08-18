import 'package:dollar_app/features/auth/view/otp_view.dart';
import 'package:dollar_app/features/shared/widgets/app_primary_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class NewFeedsView extends ConsumerStatefulWidget {
  const NewFeedsView({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _NewFeedsViewState();
}

class _NewFeedsViewState extends ConsumerState<NewFeedsView> {
  final QuillController _controller = QuillController.basic();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: CircleAvatar(
          backgroundColor: Colors.grey.shade300,
        ),
        centerTitle: false,
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: AppPrimaryButton(
                putIcon: false,
                height: 30.h,
                color: Theme.of(context).colorScheme.primary,
                width: 100.w,
                title: "Post"),
          )
        ],
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 23.w),
        child: Column(
          children: [
            Expanded(
                child: TextFormField(
              keyboardType: TextInputType.multiline,
              maxLines: 99999999,
              decoration: InputDecoration.collapsed(
                  hintText: "Whats' popping?",
                  hintStyle: GoogleFonts.redHatDisplay(fontSize: 12.sp)),
              scrollPadding: const EdgeInsets.all(20.0),
              autofocus: true,
            )),
            SizedBox(
              height: 20.h,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        isExtended: true,
        child: const Icon(Icons.upload),
      ),
    );
  }
}
