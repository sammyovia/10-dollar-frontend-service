import 'package:dollar_app/features/auth/view/otp_view.dart';
import 'package:dollar_app/features/main/home/home_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconly/iconly.dart';

class PollsView extends StatefulWidget {
  const PollsView({super.key});

  @override
  State<PollsView> createState() => _PollsViewState();
}

class _PollsViewState extends State<PollsView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
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
                color: Theme.of(context).primaryColor,
              ),
            ),
            Text(
              "Dollar",
              style: GoogleFonts.bebasNeue(
                fontWeight: FontWeight.w900,
                color: Theme.of(context).primaryColor,
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
                "Video Polls",
                style: GoogleFonts.lato(fontSize: 16.sp),
              ),
            ),
               
            
            SizedBox(
              height: 10.h,
            ),
            const Divider(
              thickness: 2,
            ),
            const HomeArtistWidget()
          ],
        ),
      )),
    );
  }
}
