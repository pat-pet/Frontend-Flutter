import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pat_pat/features_onboard/view/splash.dart';
import 'package:pat_pat/features_onboard/view_model/auth_provider.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [ChangeNotifierProvider(create: (context) => AuthProvider())],
      child: ScreenUtilInit(
        designSize: const Size(428, 926),
        builder: (context, child) => MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'PatPet',
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
          home: const SplashScreen(),
        ),
      ),
    );
  }
}
