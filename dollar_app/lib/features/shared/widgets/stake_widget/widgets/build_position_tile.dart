import 'package:dollar_app/features/shared/widgets/custom_radio_button.dart';
import 'package:dollar_app/features/shared/widgets/stake_widget/helper/stake_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

Widget buildPositionTile(WidgetRef ref, BuildContext context,
    {required int videoIndex,
    required StakePosition position,
    required String title,
    required String id}) {
  final stakeHelper = ref.watch(stakeHelperProvider);
  bool isSelected = stakeHelper.selectedPositions[videoIndex] == position;
  bool isDisabled =
      stakeHelper.isPositionGloballySelected(position) && !isSelected;
  return GestureDetector(
    onTap: isDisabled
        ? null
        : () {
            stakeHelper.handlePositionSelection(
                videoIndex, position, id, title);
          },
    child: ListTile(
      tileColor: isSelected ? Colors.grey.shade100 : null,
      minVerticalPadding: 8.h,
      minTileHeight: 8.h,
      title: Text(
        title,
        style: GoogleFonts.lato(fontSize: 12.sp),
      ),
      trailing: CustomRadioButton(
        activeColor: isSelected ? Theme.of(context).colorScheme.primary : null,
      ),
      enabled: !isDisabled,
    ),
  );
}
