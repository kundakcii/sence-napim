import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:provider/provider.dart';
import 'package:sence/providers/auth_provider.dart';
import 'package:sence/utils/custom_theme.dart';
import 'package:sence/views/layout.dart';
import 'package:sence/views/pages/auth/login_page.dart';
import 'package:sence/views/pages/auth/register_page.dart';
import 'package:sence/views/pages/get_answers_detail_page.dart';
import 'package:sence/views/pages/get_answers_page.dart';
import 'package:sence/views/pages/give_answer_detail_page.dart';
import 'package:sence/views/pages/home_page.dart';
import 'package:sence/views/pages/navigation_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  MobileAds.instance.initialize();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthProvider()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: CustomTheme.lightTheme,
      debugShowCheckedModeBanner: false,
      routes: {
        '/login': (context) => const LoginPage(),
        '/register': (context) => const RegisterPage(),
        '/home': (context) => const HomePage(),
        '/navigation': (context) => const NavigationPage(),
        '/getAnswersDetail': (context) => const GetAnswerDetailPage(),
        '/getAnswers': (context) => const GetAnswersPage(),
        '/giveAnswersDetail': (context) => const GiveAnswerDetailPage()
      },
      title: 'Material App',
      home: const Layout(),
    );
  }
}
