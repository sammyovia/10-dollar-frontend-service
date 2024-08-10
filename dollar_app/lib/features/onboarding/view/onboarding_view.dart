import 'package:carousel_slider/carousel_slider.dart';
import 'package:dollar_app/features/auth/register_view.dart';
import 'package:dollar_app/features/onboarding/model/onboarding.dart';
import 'package:dollar_app/features/shared/constant/image_constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class OnboardingView extends StatefulWidget {
  const OnboardingView({super.key});

  @override
  State<OnboardingView> createState() => _OnboardingViewState();
}

class _OnboardingViewState extends State<OnboardingView> {
  final images = [
    const OnboardingModel(
        id: 1,
        image: AppImages.onboarding1,
        text:
            'Recieve real-time feedback from  peers, upload videos for voting and win money for being the top voted atrtist'),
    const OnboardingModel(
        id: 2,
        image: AppImages.onboarding2,
        text:
            'Connect with your other musicians, showcase your talent and earn rewards for your creativity'),
    const OnboardingModel(
        id: 3,
        image: AppImages.onboarding3,
        text:
            'Connect with audience, get free promotions for your and record deals'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            width: double.infinity,
            height: 600.h,
            decoration: BoxDecoration(
              color: Colors.red.shade300,
              image: const DecorationImage(
                  image: AssetImage(AppImages.onboarding2),
                  fit: BoxFit.fill,
                  opacity: 0.4),
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
                  Theme.of(context).colorScheme.secondary,
                  Theme.of(context).colorScheme.secondary.withOpacity(0),
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
                      Theme.of(context).colorScheme.secondary,
                      Theme.of(context).colorScheme.secondary,
                      Theme.of(context).colorScheme.secondary,
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
                          autoPlayInterval: const Duration(seconds: 3),
                          height: 70.h,
                          autoPlay: true,
                          viewportFraction: 1),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const RegisterView(),
                        ),
                      );
                    },
                    child: Container(
                      height: 50.h,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.white),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Get Started',
                            style: GoogleFonts.notoSans(color: Colors.red),
                          ),
                          SizedBox(
                            width: 10.w,
                          ),
                          const Icon(
                            Icons.play_circle_fill,
                            color: Colors.red,
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
