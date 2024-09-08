import 'package:dollar_app/features/shared/widgets/custom_radio_button.dart';
import 'package:dollar_app/features/shared/widgets/stake_widget/helper/stake_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

Widget buildPositionTile(
  WidgetRef ref,
  BuildContext context,
      {required int videoIndex,
      required StakePosition position,
      required String title,
      required String id}) {
        final stakeHeleper = ref.watch(stakeHelperProvider);
    bool isSelected =  stakeHeleper.selectedPositions[videoIndex] == position;
    bool isDisabled = stakeHeleper.isPositionGloballySelected(position) && !isSelected;
    return GestureDetector(
      onTap: isDisabled
          ? null
          : () {
             stakeHeleper.handlePositionSelection(videoIndex, position, id, title);
            },
      child: ListTile(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        tileColor: isSelected ? Colors.grey : null,
        minVerticalPadding: 8.h,
        minTileHeight: 8.h,
        title: Text(title),
        trailing: CustomRadioButton(
          activeColor:
              isSelected ? Theme.of(context).colorScheme.primary : null,
        ),
        enabled: !isDisabled,
      ),
    );
  }
