import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pat_pat/features_onboard/view/login.dart';
import 'package:pat_pat/features_onboard/view/mainpage.dart';
import 'package:pat_pat/features_onboard/view/onboard_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    navigateToPage();
  }

  navigateToPage() async {
    await Future.delayed(const Duration(milliseconds: 2500));
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final bool isLogin = prefs.getBool('isLogin') ?? false;

    if (context.mounted) {
      print('isLogin: $isLogin');
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) =>
                isLogin ? const MyWidget() : const OnboardPage(),
          ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text('PatPet',
            style: GoogleFonts.inter(
                fontSize: 30.sp,
                fontWeight: FontWeight.w700,
                color: Colors.black)),
      ),
    );
  }
}
