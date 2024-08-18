import 'package:carousel_slider/carousel_slider.dart';
import 'package:dollar_app/features/onboarding/model/onboarding.dart';
import 'package:dollar_app/features/shared/constant/image_constant.dart';
import 'package:dollar_app/services/network/token_storage.dart';
import 'package:dollar_app/services/router/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

class OnboardingView extends StatefulWidget {
  const OnboardingView({super.key});

  @override
  State<OnboardingView> createState() => _OnboardingViewState();
}

class _OnboardingViewState extends State<OnboardingView> {
  Future<void> loadTokensOnStartup(BuildContext context) async {
    final tokenStorage = TokenStorage();
    final accessToken = await tokenStorage.getAccessToken();
    final refreshToken = await tokenStorage.getRefreshToken();
    if (context.mounted) {
      if (accessToken != null && refreshToken != null) {
        // Use the tokens to authenticate the user
        context.go(AppRoutes.home);
      } else {
        // Redirect to login page
        context.go(AppRoutes.login);
      }
    }
  }

  final images = [
    const OnboardingModel(
        id: 1,
        image: AppImages.onboarding1,
        text:
            'Upload videos for voting and win money for being the top voted artist.'),
    const OnboardingModel(
        id: 2,
        image: AppImages.onboarding2,
        text: 'Showcase your talent and earn rewards for your creativity.'),
    const OnboardingModel(
        id: 3,
        image: AppImages.onboarding3,
        text: 'Stake on videos and win big.'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            width: double.infinity,
            height: 600.h,
            decoration: const BoxDecoration(
              color: Colors.black87,
              image: DecorationImage(
                image: AssetImage(AppImages.onboarding2),
                fit: BoxFit.cover,
                //opacity: 0.
              ),
            ),
          ),
          Container(
            height: 200.h,
            //width: 270,
            decoration: BoxDecoration(
              //borderRadius: BorderRadius.circular(24.0),
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Theme.of(context).colorScheme.primary,
                  Theme.of(context).colorScheme.primary.withOpacity(0),
                ],
              ),
            ),
          ),
          Column(
            children: [
              const Expanded(child: SizedBox()),
              Container(
                height: 400.h,
                //width: 270,
                decoration: BoxDecoration(
                  //borderRadius: BorderRadius.circular(24.0),
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Theme.of(context).colorScheme.secondary.withOpacity(0),
                      //Colors.transparent,
                      //Color(0xFFF9FAF8),
                      Theme.of(context).colorScheme.primary,
                      Theme.of(context).colorScheme.primary,
                      Theme.of(context).colorScheme.primary
                    ],
                  ),
                ),
              ),
            ],
          ),
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Column(
                children: [
                  const Expanded(child: SizedBox()),
                  SizedBox(
                    height: 200.h,
                  ),
                  Expanded(
                    child: CarouselSlider.builder(
                      itemCount: 3,
                      itemBuilder: (context, index, realIndex) {
                        return Text(
                          images[index].text,
                          textAlign: TextAlign.center,
                          style: GoogleFonts.redHatDisplay(
                              color: Colors.white,
                              fontSize: 14.sp,
                              fontWeight: FontWeight.bold),
                        );
                      },
                      options: CarouselOptions(
                          autoPlayInterval: const Duration(seconds: 7),
                          height: 70.h,
                          autoPlay: true,
                          viewportFraction: 1),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      loadTokensOnStartup(context);
                    },
                    child: Container(
                      height: 50.h,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.black),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Get Started',
                            style: GoogleFonts.notoSans(
                                fontSize: 20.sp, color: Colors.white),
                          ),
                          SizedBox(
                            width: 10.w,
                          ),
                          Icon(
                            size: 20.r,
                            Icons.play_circle_fill,
                            color: Colors.white,
                          )
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 50.h,
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
