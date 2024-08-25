import 'package:dollar_app/features/main/home/provider/top_artist_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

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
