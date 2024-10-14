import 'package:carousel_slider/carousel_slider.dart';
import 'package:dollar_app/features/onboarding/model/onboarding.dart';
import 'package:dollar_app/features/onboarding/provider/indicator_provider.dart';
import 'package:dollar_app/features/onboarding/view/widgets/indicator.dart';
import 'package:dollar_app/features/shared/constant/image_constant.dart';
import 'package:dollar_app/features/shared/widgets/app_primary_button.dart';
import 'package:dollar_app/services/network/token_storage.dart';
import 'package:dollar_app/services/router/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

class OnboardingView extends ConsumerStatefulWidget {
  const OnboardingView({super.key});

  @override
  ConsumerState<OnboardingView> createState() => _OnboardingViewState();
}

class _OnboardingViewState extends ConsumerState<OnboardingView> {
  late CarouselSliderController _carouselController;
  @override
  initState() {
    super.initState();
    _carouselController = CarouselSliderController();
  }

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
        title: 'Upload Videos',
        id: 1,
        image: AppImages.onboarding1,
        text:
            'Upload videos for voting and win money for being the top voted artist.'),
    const OnboardingModel(
        title: 'Showcase Your Talent',
        id: 2,
        image: AppImages.onboarding2,
        text: 'Showcase your talent and earn rewards for your creativity.'),
    const OnboardingModel(
        title: 'Stake On Videos',
        id: 3,
        image: AppImages.onboarding3,
        text: 'Stake on videos and win big.'),
  ];

  @override
  Widget build(BuildContext context) {
    final curent = ref.watch(inidcatorProvider);
    final token = TokenStorage();
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: ListView(
        children: [
          CarouselSlider.builder(
            carouselController: _carouselController,
            itemCount: 3,
            itemBuilder: (context, index, realIndex) {
              return Column(
                children: [
                  SizedBox(
                    height: 390.h,
                    child: Stack(
                      children: [
                        Container(
                          height: double.infinity,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage(images[index].image),
                              fit: BoxFit.cover,
                            ),
                            color: const Color(0XFFD9D9D9),
                            borderRadius: BorderRadius.vertical(
                              bottom: Radius.circular(50.r),
                            ),
                          ),
                        ),
                        Positioned(
                          top: 20.h,
                          right: 30.w,
                          child: AppPrimaryButton(
                              onPressed: () {
                                context.go(AppRoutes.register);
                                token.saveUserOnboarded(true);
                              },
                              putIcon: false,
                              height: 30.h,
                              enabled: true,
                              color: const Color.fromARGB(148, 185, 88, 81),
                              width: 100.w,
                              title: 'Skip'),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 30.h,
                  ),
                  Text(
                    images[index].title,
                    textAlign: TextAlign.center,
                    style: GoogleFonts.notoSans(fontWeight: FontWeight.w700),
                  ),
                  SizedBox(
                    height: 30.h,
                  ),
                  SizedBox(
                    width: 300.w,
                    child: Text(
                      images[index].text,
                      textAlign: TextAlign.center,
                      style: GoogleFonts.lato(fontSize: 12.sp),
                    ),
                  ),
                  SizedBox(
                    height: 30.h,
                  ),
                  const IndicatorWidget(),
                  // SizedBox(
                  //   height: 30.h,
                  // ),
                ],
              );
            },
            options: CarouselOptions(
                enableInfiniteScroll: false,
                autoPlayInterval: const Duration(seconds: 7),
                height: MediaQuery.of(context).size.height * 0.85,
                autoPlay: false,
                viewportFraction: 1,
                onPageChanged: (index, reason) {
                  ref.watch(inidcatorProvider.notifier).state = index;
                }),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              if (ref.watch(inidcatorProvider) > 0)
                AppPrimaryButton(
                    onPressed: () {
                      _carouselController.previousPage(curve: Curves.easeIn);
                    },
                    radius: 8,
                    putIcon: false,
                    height: 30.h,
                    color: Theme.of(context).primaryColor,
                    enabled: true,
                    width: 100.w,
                    title: 'prev'),
              AppPrimaryButton(
                  onPressed: () {
                    if (curent < 2) {
                      _carouselController.nextPage(
                        curve: Curves.linear,
                      );
                    } else {
                      token.saveUserOnboarded(true);
                      context.go(AppRoutes.register);
                    }
                  },
                  radius: 8,
                  putIcon: false,
                  height: 30.h,
                  enabled: true,
                  width: 100.w,
                  title: curent == 2 ? 'Proceed' : 'next'),
            ],
          ),
          SizedBox(height: 10.h,),
        ],
      ),
    );
  }
}
