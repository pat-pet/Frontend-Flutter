import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:frontend_flutter/src/pages/splash/splash_page.dart';
import 'package:frontend_flutter/src/view_models/auth_provider.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => AuthProvider()),
      ],
      child: ScreenUtilInit(
        designSize: const Size(428, 926),
        builder: (context, child) => MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'PatPet',
          theme: ThemeData(primarySwatch: Colors.blue),
          home: const SplashPage(),
        ),
      ),
    );
  }
}
