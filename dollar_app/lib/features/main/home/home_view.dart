import 'package:dollar_app/features/auth/view/otp_view.dart';
import 'package:dollar_app/features/main/home/provider/home_artist_provider.dart';
import 'package:dollar_app/features/main/home/provider/top_artist_provider.dart';
import 'package:dollar_app/services/router/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconly/iconly.dart';
import 'package:go_router/go_router.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
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
              onPressed: () {
                context.push(AppRoutes.profile);
              },
              icon: CircleAvatar(
                radius: 15.r,
                backgroundColor: Colors.grey.shade300,
              )),
        ],
      ),
      body: SafeArea(
          child: SingleChildScrollView(
        child: Column(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 15.w),
                  child: Text(
                    "Top Voted Artist",
                    style: GoogleFonts.lato(fontSize: 16.sp),
                  ),
                ),
                const Divider(
                  thickness: 2,
                ),
                SizedBox(
                  height: 10.h,
                ),
                const TopArtistWidget()
              ],
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

class HomeArtistWidget extends ConsumerStatefulWidget {
  const HomeArtistWidget({
    super.key,
  });

  @override
  ConsumerState<HomeArtistWidget> createState() => _HomeArtistWidgetState();
}

class _HomeArtistWidgetState extends ConsumerState<HomeArtistWidget> {
  @override
  Widget build(BuildContext context) {
    final model = ref.watch(homeArtistProvider);
    return ListView.builder(
      physics: const NeverScrollableScrollPhysics(),
      padding: EdgeInsets.symmetric(horizontal: 15.w),
      itemCount: model.length,
      shrinkWrap: true,
      itemBuilder: (context, index) {
        final artist = model[index];
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  CircleAvatar(
                    backgroundColor: Colors.grey.shade300,
                    backgroundImage: NetworkImage(artist.profilePic),
                  ),
                  SizedBox(width: 8.w),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        artist.fullName,
                        style: GoogleFonts.lato(fontSize: 12.sp),
                      ),
                      Text(
                        artist.position,
                        style: GoogleFonts.lato(fontSize: 10.sp),
                      )
                    ],
                  )
                ],
              ),
              SizedBox(
                height: 10.h,
              ),
              Text(
                artist.description,
                style: GoogleFonts.lato(fontSize: 10.sp),
              ),
              SizedBox(
                height: 8.h,
              ),
              Stack(
                alignment: Alignment.center,
                children: [
                  Container(
                    width: double.infinity,
                    height: 150,
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            image: NetworkImage(artist.image),
                            fit: BoxFit.cover),
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.grey.shade300),
                  ),
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.5),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.play_arrow,
                      color: Colors.white,
                      size: 30,
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 5.h,
              ),
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        color: Theme.of(context).primaryColor),
                    child: Text(
                      'stake',
                      style: GoogleFonts.lato(
                          fontSize: 10.sp, color: Colors.white),
                    ),
                  ),
                  SizedBox(
                    width: 3.w,
                  ),
                  Text(
                    artist.stake.toString(),
                    style: GoogleFonts.lato(
                      fontSize: 12.sp,
                    ),
                  ),
                  SizedBox(
                    width: 10.w,
                  ),
                  Icon(
                    Icons.favorite,
                    color: Colors.red,
                    size: 20.r,
                  ),
                  SizedBox(
                    width: 3.w,
                  ),
                  Text(
                    artist.likes.toString(),
                    style: GoogleFonts.lato(
                      fontSize: 12.sp,
                    ),
                  ),
                  const Spacer(),
                  Icon(
                    Icons.share,
                    size: 20.r,
                    color: Theme.of(context).primaryColor,
                  )
                ],
              )
            ],
          ),
        );
      },
    );
  }
}

class TopArtistWidget extends ConsumerStatefulWidget {
  const TopArtistWidget({
    super.key,
  });

  @override
  ConsumerState<TopArtistWidget> createState() => _TopArtistWidgetState();
}

class _TopArtistWidgetState extends ConsumerState<TopArtistWidget> {
  @override
  Widget build(BuildContext context) {
    final model = ref.watch(topArtistProvider);
    return SizedBox(
      height: 120.h,
      child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, index) {
            final artist = model[index];
            return Padding(
              padding: EdgeInsets.only(left: 15.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  CircleAvatar(
                    radius: 40,
                    backgroundColor: Colors.grey.shade300,
                    backgroundImage: NetworkImage(artist.image),
                  ),
                  SizedBox(
                    height: 8.h,
                  ),
                  SizedBox(
                    width: 100.w,
                    child: Text(
                      textAlign: TextAlign.center,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                      artist.fullname,
                      style: GoogleFonts.lato(),
                    ),
                  )
                ],
              ),
            );
          },
          itemCount: model.length),
    );
  }
}
