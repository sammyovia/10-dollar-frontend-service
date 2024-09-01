import 'package:dollar_app/features/main/home/provider/top_artist_provider.dart';
import 'package:dollar_app/features/shared/widgets/shimmer_widget.dart';
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
    return model.when(
        data: (data) {
          return SizedBox(
              height: 120.h,
              child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    final artist = data[index];
                    return Padding(
                      padding: EdgeInsets.only(left: 15.w),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          CircleAvatar(
                            radius: 40,
                            backgroundColor: Colors.grey.shade300,
                            backgroundImage: artist.artist.avatar != null
                                ? NetworkImage(artist.artist.avatar!)
                                : null,
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
                              '${artist.artist.firstName} ${artist.artist.lastName}',
                              style: GoogleFonts.lato(),
                            ),
                          )
                        ],
                      ),
                    );
                  },
                  itemCount: data.length));
        },
        error: (e, s) {
          return Text(e.toString());
        },
        loading: () => const ShimmerWidget(
              width: 100,
              height: 100,
              layoutType: LayoutType.homeArtist,
            ));
  }
}
