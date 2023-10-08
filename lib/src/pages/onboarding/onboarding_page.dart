import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:frontend_flutter/src/pages/authentication/login_page.dart';
import 'package:frontend_flutter/src/pages/authentication/register_page.dart';
import 'package:frontend_flutter/src/pages/onboarding/slide_page.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OnboardingPage extends StatefulWidget {
  const OnboardingPage({super.key});

  @override
  State<OnboardingPage> createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage> {
  int _currentPage = 0;
  final PageController _pageController = PageController();

  final List _pages = [
    const SlidePage(
      title: "Welcome Pet`s Owner",
      description:
          "With a single click, quickly find pet boarding for your beloved companions",
      image: "assets/images/onboard1.png",
    ),
    const SlidePage(
      title: "Right person To Your Pet",
      description: "Your pets will be treated by animal lovers, just like you",
      image: "assets/images/onboard2.png",
    ),
    const SlidePage(
      title: "Easy, Secure & Dependable",
      description:
          "Trust is the foundation, and we're here to build it with you.",
      image: "assets/images/onboard3.png",
    )
  ];

  _onChanged(int index) {
    setState(() {
      _currentPage = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      padding: EdgeInsets.only(bottom: 50.sp),
      child: Stack(children: [
        PageView.builder(
          scrollDirection: Axis.horizontal,
          controller: _pageController,
          onPageChanged: _onChanged,
          itemCount: _pages.length,
          itemBuilder: ((context, int index) {
            return _pages[index];
          }),
        ),
        Column(mainAxisAlignment: MainAxisAlignment.end, children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(
              _pages.length,
              (int index) {
                return AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  height: (index == _currentPage) ? 7.h : 7.h,
                  width: (index == _currentPage) ? 30.w : 7.w,
                  margin: EdgeInsets.all(8.sp),
                  decoration: BoxDecoration(
                    color: (index == _currentPage)
                        ? const Color(0xEE3282B8)
                        : const Color(0xEE3282B8).withOpacity(0.5),
                  ),
                );
              },
            ),
          ),
          SizedBox(
            height: 60.h,
          ),
          Visibility(
            visible: _currentPage ==
                _pages.length - 1, // Set visibility based on the condition
            child: Container(
              width: 315.w,
              height: 40.h,
              decoration:
                  BoxDecoration(borderRadius: BorderRadius.circular(4.r)),
              child: ElevatedButton(
                style: const ButtonStyle(
                  backgroundColor: MaterialStatePropertyAll(Color(0xEE3282B8)),
                ),
                onPressed: () async {
                  if (_currentPage == _pages.length - 1) {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const RegisterPage(),
                      ),
                    );
                    final SharedPreferences prefs =
                        await SharedPreferences.getInstance();
                    await prefs.setBool('isOnboardingComplete', true);
                  } else {
                    _pageController.nextPage(
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.easeInOutQuint,
                    );
                  }
                },
                child: Text(
                  'Sign Up',
                  style: GoogleFonts.openSans(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w600,
                    color: const Color(0xEEFFFFFF),
                  ),
                ),
              ),
            ),
          ),
          SizedBox(
            height: 20.h,
          ),
          Container(
            width: 315.w,
            height: 40.h,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(4.r),
                border: Border.all(color: const Color(0xEE3282B8))),
            child: ElevatedButton(
              style: const ButtonStyle(
                backgroundColor: MaterialStatePropertyAll(Colors.white),
              ),
              onPressed: () async {
                if (_currentPage == _pages.length - 1) {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const LoginPage(),
                    ),
                  );
                  final SharedPreferences prefs =
                      await SharedPreferences.getInstance();
                  await prefs.setBool('isOnboardingComplete', true);
                } else {
                  _pageController.nextPage(
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.easeInOutQuint);
                }
              },
              child: Text(
                (_currentPage == _pages.length - 1) ? 'Sign In' : 'Berikutnya',
                style: GoogleFonts.openSans(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w600,
                  color: const Color(0xEE3282B8),
                ),
              ),
            ),
          ),
          SizedBox(
            height: 80.h,
          )
        ]),
        Visibility(
          visible: _currentPage != _pages.length - 1,
          child: Positioned(
            top: 60.sp,
            right: 30.sp,
            child: TextButton(
              onPressed: () async {
                _pageController.jumpToPage(_pages.length - 1);
              },
              child: Text(
                'Skip',
                style: GoogleFonts.inter(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w400,
                  color: const Color(0xEE144272),
                ),
              ),
            ),
          ),
        ),
      ]),
    ));
  }
}
