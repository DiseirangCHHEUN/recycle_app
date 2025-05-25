import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:recycle_app/admin/admin_rejected.dart';
import 'package:recycle_app/core/consts/app_strings.dart';
import 'package:recycle_app/firebase_options.dart' show DefaultFirebaseOptions;
import 'package:recycle_app/pages/login_page.dart';
import 'package:recycle_app/pages/home_page.dart';
import 'package:recycle_app/pages/onboarding_page.dart';
import 'package:recycle_app/settings/setting_page.dart';

import 'admin/admin_approval.dart';
import 'core/consts/app_routes.dart';
import 'pages/bottom_nav.dart';
import 'wrapper/auth_checker.dart';
import 'pages/upload_item.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.white,
        appBarTheme: const AppBarTheme(
          color: Colors.green,
          foregroundColor: Colors.white,
          centerTitle: true,
        ),
      ),
      title: AppStrings.appName,
      initialRoute: AppRoutes.authCheck,
      routes: {
        AppRoutes.authCheck: (context) => AuthChecker(),
        AppRoutes.login: (context) => LoginPage(),
        AppRoutes.home: (context) => HomePage(),
        AppRoutes.onboarding: (context) => OnboardingPage(),
        AppRoutes.uploadItem: (context) => UploadItem(),
        AppRoutes.adminApproval: (context) => AdminApproval(),
        AppRoutes.adminRejected: (context) => AdminReject(),
        AppRoutes.settings: (context) => SettingPage(),
        AppRoutes.bottomNav: (context) => BottomNav(),
      },
    );
  }
}
