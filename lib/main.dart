import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:recycle_app/admin/admin_rejected.dart';
import 'package:recycle_app/firebase_options.dart' show DefaultFirebaseOptions;
import 'package:recycle_app/pages/login_page.dart';
import 'package:recycle_app/pages/home_page.dart';
import 'package:recycle_app/pages/onboarding_page.dart';
import 'package:recycle_app/settings/setting_page.dart';

import 'admin/admin_approval.dart';
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
      title: 'Recycle App',
      initialRoute: '/authcheck',
      routes: {
        '/authcheck': (context) => AuthChecker(),
        '/login': (context) => LoginPage(),
        '/home': (context) => HomePage(),
        '/onboarding': (context) => OnboardingPage(),
        '/uploadItem': (context) => UploadItem(),
        '/admin_approval': (context) => AdminApproval(),
        '/rejected_items': (context) => AdminReject(),
        '/settings': (context) => SettingPage(),
      },
    );
  }
}
