import 'package:dollar_app/features/main/home/provider/home_artist_provider.dart';
import 'package:dollar_app/features/shared/widgets/app_bottom_sheet.dart';
import 'package:dollar_app/features/shared/widgets/stake_widget.dart';
import 'package:dollar_app/features/shared/widgets/video_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

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
              VideoWidget(video: artist.image),
              SizedBox(
                height: 5.h,
              ),
              Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      AppBottomSheet.showBottomSheet(
                          context, child:  const StakeWidget());
                    },
                    child: Container(
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



