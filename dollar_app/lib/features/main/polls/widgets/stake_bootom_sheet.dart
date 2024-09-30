import 'package:dollar_app/features/main/polls/provider/stake_provider.dart';
import 'package:dollar_app/features/main/polls/provider/stake_videos_notifier.dart';
import 'package:dollar_app/features/shared/widgets/app_primary_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

void showStakeBottomSheet(BuildContext context, String videoId) {
  showModalBottomSheet(
    useRootNavigator: true,
    context: context,
    isScrollControlled: true,
    builder: (BuildContext context) {
      return Consumer(builder: (context, ref, child) {
        final stakedVideosNotifier =
            ref.watch(stakeVideoNotifierProvider.notifier);
        final stakedVideos = ref.watch(stakeVideoNotifierProvider);
        return Container(
          width: double.infinity,
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                "Select staking position",
                style: GoogleFonts.notoSans(fontSize: 14.sp),
              ),
              const SizedBox(height: 10),
              ...['First', 'Second', 'Third'].map((position) {
                final isPositionTaken =
                    !stakedVideosNotifier.isPositionAvailable(position);
                final isAlreadyStaked = stakedVideos[videoId] == position;

                return ElevatedButton(
                  onPressed: isPositionTaken && !isAlreadyStaked
                      ? null
                      : () {
                          if (isAlreadyStaked) {
                            stakedVideosNotifier.unStakeVideo(videoId);
                          } else {
                            stakedVideosNotifier.stakeVideo(videoId, position);
                          }
                        },
                  child: Text(
                    isAlreadyStaked
                        ? "Unstake from $position"
                        : "Stake on $position",
                  ),
                );
              }),
              SizedBox(height: 20.h,),
              if (!stakedVideosNotifier.canStakeMore())
                AppPrimaryButton(
                  putIcon: false,
                  enabled: true,
                  width: double.infinity,
                  isLoading: ref.watch(stakeProvider).isLoading,
                  title: "Submit stake  (NGN) 200",
                  onPressed: () {
                    ref.read(stakeProvider.notifier).sendStakeToServer(context);
                  },
                )
            ],
          ),
        );
      });
    },
  );
}
