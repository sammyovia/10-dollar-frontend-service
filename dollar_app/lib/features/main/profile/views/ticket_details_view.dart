import 'package:dollar_app/features/main/feeds/widgets/feeds_video_preview_widget.dart';
import 'package:dollar_app/features/main/profile/providers/ticket_details_provider.dart';
import 'package:dollar_app/features/shared/widgets/app_primary_button.dart';
import 'package:dollar_app/features/shared/widgets/custom_app_bar.dart';
import 'package:dollar_app/features/shared/widgets/shimmer_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:screenshot/screenshot.dart';
import 'dart:developer';
import 'dart:io';
import 'dart:typed_data' as ui;

import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';

class TicketDetailsView extends ConsumerStatefulWidget {
  const TicketDetailsView({super.key, required this.id});
  final String id;

  @override
  ConsumerState<TicketDetailsView> createState() => _TicketDetailsViewState();
}

class _TicketDetailsViewState extends ConsumerState<TicketDetailsView> {
  ScreenshotController screenshotController = ScreenshotController();
  String _formatTime(String dateTimeString) {
    final dateTime = DateTime.parse(dateTimeString);
    return DateFormat('d/M/y').format(dateTime);
  }

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(ticketDetailsProvider.notifier).getTicketDetails(widget.id);
    });
  }

  @override
  Widget build(BuildContext context) {
    final ticketDetails = ref.watch(ticketDetailsProvider);
    return Scaffold(
      appBar: CustomAppBar(
        title: Text(
          "Ticket Details",
          style:
              GoogleFonts.aBeeZee(fontSize: 14.sp, fontWeight: FontWeight.bold),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
          child: ticketDetails.when(
            data: (data) {
              final tick = data['data'];
              return Column(
                children: [
                  Screenshot(
                    controller: screenshotController,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 100.h,
                          child: Card(
                            child: Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Column(
                                children: [
                                  Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      CircleAvatar(
                                        radius: 25.r,
                                        backgroundImage:
                                            tick['user']['avatar'] != null
                                                ? NetworkImage(
                                                    tick['user']['avatar'])
                                                : null,
                                      ),
                                      SizedBox(
                                        width: 10.w,
                                      ),
                                      Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            "${tick['user']['firstName']} ${tick['user']['lastName']}",
                                            style: GoogleFonts.lato(
                                                fontSize: 14.sp),
                                          ),
                                          SizedBox(
                                            height: 5.h,
                                          ),
                                          Text(
                                            _formatTime("${tick['createdAt']}"),
                                            style: GoogleFonts.lato(
                                                fontSize: 14.sp),
                                          ),
                                        ],
                                      ),
                                      const Spacer(),
                                      Text(
                                        tick['code'].toString(),
                                        style:
                                            GoogleFonts.lato(fontSize: 12.sp),
                                      ),
                                      SizedBox(
                                        width: 10.w,
                                      ),
                                    ],
                                  ),
                                  Container(
                                    width: 50.w,
                                    height: 20.h,
                                    decoration: BoxDecoration(
                                      color: Colors.green,
                                      borderRadius: BorderRadius.circular(4),
                                    ),
                                    child: Center(
                                      child: Text(
                                        tick['status'].toString(),
                                        style: GoogleFonts.lato(
                                            fontSize: 10.sp,
                                            color: Colors.white),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 16.h,
                        ),
                        Text(
                          "${tick['first']['video']['title']} Video",
                          style: GoogleFonts.lato(
                              fontSize: 18.sp, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          height: 5.h,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            FeedsVideoPreview(
                                width: 200.w,
                                height: 100.h,
                                file: "${tick['first']['video']['videoUrl']}"),
                            Text(
                              "First Position",
                              style: GoogleFonts.lato(
                                fontSize: 14.sp,
                              ),
                            )
                          ],
                        ),
                        SizedBox(
                          height: 8.h,
                        ),
                        Text(
                          "${tick['second']['video']['title']} Video",
                          style: GoogleFonts.lato(
                              fontSize: 18.sp, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          height: 5.h,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            FeedsVideoPreview(
                                width: 200.w,
                                height: 100.h,
                                file: "${tick['second']['video']['videoUrl']}"),
                            Text(
                              "Second Position",
                              style: GoogleFonts.lato(
                                fontSize: 14.sp,
                              ),
                            )
                          ],
                        ),
                        SizedBox(
                          height: 8.h,
                        ),
                        Text(
                          "${tick['third']['video']['title']} Video",
                          style: GoogleFonts.lato(
                              fontSize: 18.sp, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          height: 5.h,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            FeedsVideoPreview(
                                width: 200.w,
                                height: 100.h,
                                file: "${tick['third']['video']['videoUrl']}"),
                            Text(
                              "Third Position",
                              style: GoogleFonts.lato(
                                fontSize: 14.sp,
                              ),
                            )
                          ],
                        ),
                        SizedBox(
                          height: 20.h,
                        ),
                      ],
                    ),
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: AppPrimaryButton(
                        onPressed: () {
                          screenshotController
                              .capture(delay: const Duration(milliseconds: 10))
                              .then((capturedImage) async {
                            captureAndShareScreenshot(capturedImage!);
                          });
                        },
                        enabled: true,
                        putIcon: false,
                        width: 150.w,
                        height: 35.h,
                        title: "Share"),
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                ],
              );
            },
            error: (error, trace) {
              return Text(
                error.toString(),
                style: GoogleFonts.lato(),
              );
            },
            loading: () => const ShimmerWidget(
              layoutType: LayoutType.howVideo,
            ),
          ),
        ),
      ),
    );
  }
}

Future<void> captureAndShareScreenshot(ui.Uint8List bytes) async {
  try {
    final directory = await getApplicationDocumentsDirectory();
    final imageFile =
        File('${directory.path}/plug_receipt${DateTime.now()}.png');
    await imageFile.writeAsBytes(bytes);

    final xFile = XFile(imageFile.path); // Convert to XFile
    await Share.shareXFiles([xFile]);
  } catch (e) {
    log("Error sharing: $e");
  }
}
