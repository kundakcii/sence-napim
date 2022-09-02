import 'package:flutter/material.dart';
import 'package:sence/helpers/secure_store_service.dart';
import 'package:sence/views/pages/navigation_page.dart';
import 'package:sence/views/pages/onboar/onboarding_page.dart';

class Layout extends StatefulWidget {
  const Layout({super.key});

  @override
  State<Layout> createState() => _LayoutState();
}

class _LayoutState extends State<Layout> {
  SecureStoreService? _secureStroeService;
  @override
  void initState() {
    super.initState();
    _secureStroeService = SecureStoreService();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _secureStroeService?.readValue(key: 'token'),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return const NavigationPage();
        } else {
          return const OnboardingPage();
        }
      },
    );
  }
}
