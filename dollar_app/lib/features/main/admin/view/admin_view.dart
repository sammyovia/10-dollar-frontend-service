import 'package:dollar_app/features/main/admin/users/view/users_view.dart';
import 'package:dollar_app/features/main/admin/videos/view/admin_video_view.dart';
import 'package:dollar_app/features/main/polls/provider/weekly_winnings_provider.dart';
import 'package:dollar_app/features/main/profile/views/stake_tickets.dart';
import 'package:dollar_app/features/shared/widgets/app_primary_button.dart';
import 'package:dollar_app/features/shared/widgets/app_text_field.dart';
import 'package:dollar_app/features/shared/widgets/custom_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconly/iconly.dart';

class AdminView extends ConsumerStatefulWidget {
  const AdminView({super.key});

  @override
  ConsumerState<AdminView> createState() => _AdminViewState();
}

class _AdminViewState extends ConsumerState<AdminView>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
    _tabController.addListener(() {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        height: 90.h,
        elevation: 5,
        title: Text(
          'Admin',
          style:
              GoogleFonts.aBeeZee(fontSize: 14.sp, fontWeight: FontWeight.bold),
        ),
        centerTitle: false,
        bottom: TabBar(controller: _tabController, tabs: [
          Tab(
            icon: Icon(
              Icons.people,
              color: _tabController.index == 0
                  ? Theme.of(context).primaryColor
                  : null,
            ),
            child: Text(
              'Users',
              style: GoogleFonts.lato(
                fontSize: 12.sp,
              ),
            ),
          ),
          Tab(
            icon: Icon(
              Icons.video_camera_front,
              color: _tabController.index == 1
                  ? Theme.of(context).primaryColor
                  : null,
            ),
            child: Text(
              'Videos',
              style: GoogleFonts.lato(
                fontSize: 12.sp,
              ),
            ),
          ),
          Tab(
            icon: Icon(
              IconlyBold.ticket,
              color: _tabController.index == 2
                  ? Theme.of(context).primaryColor
                  : null,
            ),
            child: Text(
              'Stakes',
              style: GoogleFonts.lato(
                fontSize: 12.sp,
              ),
            ),
          ),
          Tab(
            icon: Icon(
              Icons.money,
              color: _tabController.index == 2
                  ? Theme.of(context).primaryColor
                  : null,
            ),
            child: Text(
              'Winnings',
              style: GoogleFonts.lato(
                fontSize: 12.sp,
              ),
            ),
          ),
        ]),
      ),
      body: TabBarView(controller: _tabController, children: const [
        UsersView(),
        AdminVideoView(),
        StakeTicketsView(
          admin: 'yes',
        ),
        SetWinningsView(),
      ]),
    );
  }
}

class SetWinningsView extends ConsumerStatefulWidget {
  const SetWinningsView({
    super.key,
  });

  @override
  ConsumerState<SetWinningsView> createState() => _SetWinningsViewState();
}

class _SetWinningsViewState extends ConsumerState<SetWinningsView> {
  late TextEditingController amountController;
  bool isValid = false;
  @override
  void initState() {
    super.initState();
    amountController = TextEditingController();
  }

  @override
  void dispose() {
    amountController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 24.w),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: 20.h,
            ),
            AppTextField(
              controller: amountController,
                onchaged: (value) {
                  if (value != null && value.isNotEmpty) {
                    isValid = true;
                  } else {
                    isValid = false;
                  }
                  setState(() {});
                },
                keybordType:
                    const TextInputType.numberWithOptions(decimal: true),
                labelText: "Enter Amount",
                errorText: "",
                hintText: "NGN 10,0000"),
            SizedBox(
              height: 20.h,
            ),
            AppPrimaryButton(
              
              isLoading: ref.watch(setWinningsProvider).isLoading,
              putIcon: false,
              enabled: isValid,
              height: 40.h,
              title: "Post Winnings",
              onPressed: () {
                if (isValid) {
                  ref.read(setWinningsProvider.notifier).setWinning(
                      context: context,
                      percentage: num.parse(amountController.text));
                }
              },
            )
          ],
        ));
  }
}
