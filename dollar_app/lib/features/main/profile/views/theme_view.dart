import 'package:dollar_app/services/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:dollar_app/features/shared/widgets/custom_app_bar.dart';


class ThemeView extends ConsumerWidget {
  const ThemeView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeNotifier = ref.watch(themeProvider.notifier);
    final currentTheme = themeNotifier.appThemeMode;

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: const CustomAppBar(
        title: Text("Theme"),
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
          child: Wrap(
            runSpacing: 15.h,
            spacing: 15.w,
            children: AppThemeMode.values.map((mode) {
              return _buildThemeOption(
                  context, ref, mode, currentTheme == mode);
            }).toList(),
          ),
        ),
      ),
    );
  }

  Widget _buildThemeOption(
      BuildContext context, WidgetRef ref, AppThemeMode mode, bool isSelected) {
    IconData icon;
    String text;
    switch (mode) {
      case AppThemeMode.light:
        icon = Icons.light_mode;
        text = "Light Theme";
        break;
      case AppThemeMode.dark:
        icon = Icons.dark_mode;
        text = "Dark Theme";
        break;
      case AppThemeMode.system:
        icon = Icons.brightness_auto;
        text = "System Default";
        break;
    }

    return GestureDetector(
      onTap: () {
        ref.read(themeProvider.notifier).setThemeMode(mode);
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        width: 150.w,
        height: 150.w,
        decoration: BoxDecoration(
          border: isSelected ? Border.all(width: 3, color: Colors.amber) : null,
          borderRadius: BorderRadius.circular(8),
          color: Theme.of(context).cardColor,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            AnimatedSwitcher(
              duration: const Duration(milliseconds: 300),
              child: Icon(
                icon,
                key: ValueKey(isSelected),
                color:
                    isSelected ? Colors.amber : Theme.of(context).dividerColor,
                size: 22.r,
              ),
            ),
            SizedBox(height: 5.h),
            Text(text, style: GoogleFonts.lato()),
          ],
        ),
      ),
    );
  }
}
