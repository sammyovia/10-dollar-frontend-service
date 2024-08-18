import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconly/iconly.dart';

class BottomNavbar extends StatefulWidget {
  const BottomNavbar({super.key, required this.child});
  final StatefulNavigationShell child;

  @override
  State<BottomNavbar> createState() => _BottomNavbarState();
}

class _BottomNavbarState extends State<BottomNavbar> {
  String selectedTab = "Home";

  void setSelectedTab(String value) {
    setState(() {
      selectedTab = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: widget.child,
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: Colors.black,
        unselectedItemColor: Colors.grey.shade500,
        backgroundColor: Theme.of(context).colorScheme.surface,
        type: BottomNavigationBarType.fixed,
        currentIndex: widget.child.currentIndex,
        onTap: (index) {
          widget.child.goBranch(index,
              initialLocation: index == widget.child.currentIndex);
          setState(() {});
        },
        items: [
          BottomNavigationBarItem(
            icon: _buildIconWithIndicator(
              icon: Icons.home,
              label: "Home",
              isActive: widget.child.currentIndex == 0,
            ),
            label: "",
          ),
          BottomNavigationBarItem(
            icon: _buildIconWithIndicator(
              icon: Icons.bar_chart,
              label: "Polls",
              isActive: widget.child.currentIndex == 1,
            ),
            label: "",
          ),
          BottomNavigationBarItem(
            icon: _buildIconWithIndicator(
              icon: Icons.featured_play_list,
              label: "Feeds",
              isActive: widget.child.currentIndex == 2,
            ),
            label: "",
          ),
          BottomNavigationBarItem(
            icon: _buildIconWithIndicator(
              icon: IconlyBold.chat,
              label: "Chat",
              isActive: widget.child.currentIndex == 3,
            ),
            label: "",
          ),
        ],
      ),
    );
  }

  Widget _buildIconWithIndicator({
    required IconData icon,
    required String label,
    required bool isActive,
  }) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Stack(
      children: [
        if (isActive)
          Positioned(
            top: 3.h, // Adjust the top distance proportionally to screen height
            right: 20
                .w, // Set right to 0 and center the stack child using alignment
            child: Container(
              width: 5.w,
              height: 5.h,
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Theme.of(context).colorScheme.primary,
              ),
            ),
          ),
        Column(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: isActive ? 
                isDark? Colors.white12:
                 Colors.grey.shade300 :
                  null,
                shape: BoxShape.circle,
              ),
              child: Center(
                child: Icon(
                  icon,
                  color: isActive ? Theme.of(context).colorScheme.primary : null,
                ),
              ),
            ),
            Text(
              label,
              style: GoogleFonts.lato(
                fontSize: 10.sp,
                color: isActive ? Theme.of(context).colorScheme.primary: null,
              ),
            )
          ],
        ),
      ],
    );
  }
}

class BottomNavbarIcon extends StatefulWidget {
  const BottomNavbarIcon({
    super.key,
    required this.title,
    required this.icon,
    required this.iconBackgroundColor,
  });
  final String title;
  final IconData icon;
  final Color? iconBackgroundColor;

  @override
  State<BottomNavbarIcon> createState() => _BottomNavbarIconState();
}

class _BottomNavbarIconState extends State<BottomNavbarIcon> {
  String selectedIcon = 'Home';

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => setState(() {
        selectedIcon = widget.title;
      }),
      child: Stack(
        alignment: Alignment.center, // Center the stack child elements
        children: [
          if (selectedIcon == widget.title)
            Positioned(
              top: 3
                  .h, // Adjust the top distance proportionally to screen height
              child: Container(
                width: 5.w,
                height: 5.h,
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Theme.of(context).primaryColor),
              ),
            ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                height: 30.h,
                decoration: BoxDecoration(
                  color: widget.iconBackgroundColor,
                  shape: BoxShape.circle,
                ),
                child: Center(
                  child: Icon(
                    widget.icon,
                    color: Colors.black,
                  ),
                ),
              ),
              Text(
                widget.title,
                style: GoogleFonts.lato(fontSize: 10.sp),
              )
            ],
          ),
        ],
      ),
    );
  }
}
