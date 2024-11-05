import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:presetup/flavor_banner.dart';
import 'package:presetup/screens/create_action_screen/create_action_screen.dart';
import 'package:presetup/screens/dashboard_screen/dashboard_tab.dart';
import 'package:presetup/screens/dashboard_screen/ads_tab.dart';
import 'package:presetup/screens/dashboard_screen/settings_tab.dart';
import 'package:presetup/screens/widgets_showcase_screen.dart/widgets_showcase_screen.dart';
import 'package:presetup/widgets/floating_bottom_bar.dart';

// Update MainDashboard
class MainDashboard extends ConsumerStatefulWidget {
  const MainDashboard({super.key});

  @override
  ConsumerState<MainDashboard> createState() => _MainDashboardState();
}

class _MainDashboardState extends ConsumerState<MainDashboard> {
  int _currentIndex = 0;

  final List<Widget> _screens = [
    const DashboardTab(),
    const AdsTab(),
    const CreateActionScreen(), // New screen for the plus button
    const WidgetsShowcaseTab(),
    const SettingsTab(),
  ];

  @override
  Widget build(BuildContext context) {
    return FlavorBanner(
      child: Scaffold(
        extendBody: true,
        body: IndexedStack(
          index: _currentIndex,
          children: _screens,
        ),
        bottomNavigationBar: FloatingBottomBar(
          currentIndex: _currentIndex,
          onTap: (index) => setState(() => _currentIndex = index),
        ),
      ),
    );
  }
}
