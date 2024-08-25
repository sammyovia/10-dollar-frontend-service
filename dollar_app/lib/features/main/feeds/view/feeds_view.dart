import 'package:dollar_app/features/auth/view/otp_view.dart';
import 'package:dollar_app/features/shared/widgets/home_artist_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconly/iconly.dart';

class FeedsView extends StatefulWidget {
  const FeedsView({super.key});

  @override
  State<FeedsView> createState() => _FeedsViewState();
}

class _FeedsViewState extends State<FeedsView> {
  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Scaffold(
      appBar: CustomAppBar(
        height: 70.h,
        title: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "10",
              style: GoogleFonts.bebasNeue(
                fontWeight: FontWeight.w900,
                color: Theme.of(context).colorScheme.primary,
              ),
            ),
            Text(
              "Dollar",
              style: GoogleFonts.bebasNeue(
                fontWeight: FontWeight.w900,
                color: Theme.of(context).colorScheme.primary,
              ),
            ),
          ],
        ),
        centerTitle: false,
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(
              IconlyLight.search,
              size: 20.r,
            ),
          ),
          IconButton(
            onPressed: () {},
            icon: Icon(
              IconlyBold.notification,
              size: 20.r,
            ),
          ),
          IconButton(
              onPressed: () {},
              icon: CircleAvatar(
                radius: 15.r,
                backgroundColor: Colors.grey.shade300,
              )),
        ],
      ),
      body: SafeArea(
          child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 15.w),
              child: Text(
                "Feed",
                style: GoogleFonts.lato(fontSize: 16.sp),
              ),
            ),
            SizedBox(
              height: 10.h,
            ),
            const Divider(
              thickness: 2,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 15.w),
              child: Row(
                children: [
                  CircleAvatar(
                    backgroundColor: Colors.grey.shade300,
                  ),
                  SizedBox(
                    width: 10.w,
                  ),
                  GestureDetector(
                    onTap: () {
                      context.go('/feeds/new');
                    },
                    child: SizedBox(
                        width: 230.w,
                        child: TextField(
                          enabled: false,
                          readOnly: true,
                          decoration: InputDecoration(
                              isDense: true,
                              fillColor: isDark
                                  ? const Color(0xFF064D4D)
                                  : const Color(0xFFE0F7F7),
                              filled: true,
                              border: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: isDark
                                          ? const Color(0xFFB2DFDF)
                                          : const Color(0xFF5AA3A3)),
                                  borderRadius: BorderRadius.circular(50)),
                              enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: isDark
                                          ? const Color(0xFFB2DFDF)
                                          : const Color(0xFF5AA3A3)),
                                  borderRadius: BorderRadius.circular(50)),
                              focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: isDark
                                          ? const Color(0xFFB2DFDF)
                                          : const Color(0xFF5AA3A3)),
                                  borderRadius: BorderRadius.circular(50)),
                              hintText: "What's Popping?"),
                        )),
                  ),
                  const Spacer(),
                  IconButton(
                    onPressed: () {},
                    icon: Icon(
                      IconlyBold.image,
                      size: 20.r,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  )
                ],
              ),
            ),
            SizedBox(
              height: 15.h,
            ),
            const PinnedInfoWidget(),
            SizedBox(
              height: 15.h,
            ),
            const HomeArtistWidget()
          ],
        ),
      )),
    );
  }
}

class PinnedInfoWidget extends StatelessWidget {
  const PinnedInfoWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 15.w),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          
          SizedBox(width: 8.w),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [Row(
              children: [
                CircleAvatar(
                    backgroundColor: Colors.grey.shade300,
                  ),
                  SizedBox(width: 8.w),
                Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'sammy rado',
                        style: GoogleFonts.lato(fontSize: 12.sp),
                      ),
                      Text(
                        'admin',
                        style: GoogleFonts.lato(fontSize: 10.sp),
                      ),
                    ],
                  ),
                 const Spacer(),
                  
              Icon(
                Icons.push_pin,
                color: Colors.red,
                size: 20.r,
              ),
              Icon(
                Icons.more_vert,
                size: 20.r,
              ),
                
              ],
            ),

              
             
              SizedBox(
                height: 10.h,
              ),
              SizedBox(
                width: 270.w,
                child: Text(
                  'Hello everyone, welcome and we are hope you have gotten your winings',
                  style: GoogleFonts.lato(fontSize: 10.sp),
                ),
              ),
              SizedBox(
                height: 8.h,
              ),
              Container(
                width:double.infinity,
                height: 150,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.grey.shade300),
              ),
              SizedBox(
                height: 5.h,
              ),
              Row(
                children: [
                  Icon(
                    Icons.thumb_up,
                    color: Colors.green,
                    size: 20.r,
                  ),
                  SizedBox(
                    width: 3.w,
                  ),
                  Text(
                    '445',
                    style: GoogleFonts.redHatDisplay(fontSize: 12.sp),
                  ),
                  SizedBox(
                    width: 10.w,
                  ),
                  Icon(
                    Icons.chat_rounded,
                    color: Colors.green.shade900,
                    size: 20.r,
                  ),
                  SizedBox(
                    width: 3.w,
                  ),
                  Text(
                    '445',
                    style: GoogleFonts.redHatDisplay(fontSize: 12.sp),
                  ),
                  SizedBox(
                    width: 10.w,
                  ),
                  Icon(
                    Icons.send,
                    color: Theme.of(context).colorScheme.primary,
                    size: 20.r,
                  ),
                  SizedBox(
                    width: 3.w,
                  ),
                  Text(
                    '445',
                    style: GoogleFonts.redHatDisplay(fontSize: 12.sp),
                  ),
                ],
              )
            ],
          ),
        ],
      ),
    );
  }
}
