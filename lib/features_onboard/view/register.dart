import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pat_pat/features_onboard/view/login.dart';
import 'package:pat_pat/features_onboard/view_model/auth_provider.dart';
import 'package:provider/provider.dart';

import '../model/register_model.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneNumController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  bool _isVisible = false;

  @override
  Widget build(BuildContext context) {
    return Consumer<AuthProvider>(
      builder: (context, registerProvider, child) => Scaffold(
        body: Container(
          padding: EdgeInsets.only(
              left: 28.sp, right: 28.sp, top: 60.sp, bottom: 20.sp),
          child: ListView(
            children: [
              Text(
                "Sign Up",
                style: GoogleFonts.inter(
                    fontSize: 20.sp,
                    fontWeight: FontWeight.w700,
                    color: const Color(0xEE222831)),
              ),
              SizedBox(
                height: 12.h,
              ),
              Text(
                'Fill the blank input below here to sign up.',
                style: GoogleFonts.inter(
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w400,
                    color: const Color(0xEE727C8D)),
              ),
              SizedBox(
                height: 40.h,
              ),
              Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Name',
                      style: GoogleFonts.inter(
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w700,
                          color: const Color(0xEE222831)),
                    ),
                    SizedBox(
                      height: 8.h,
                    ),
                    SizedBox(
                      width: double.infinity,
                      child: TextFormField(
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        controller: _nameController,
                        validator: (name) {
                          if (name == null || name.isEmpty) {
                            return 'Please enter your name';
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(4.r)),
                          ),
                          hintText: 'Enter full name...',
                          hintStyle: GoogleFonts.inter(
                              fontSize: 12.sp,
                              fontWeight: FontWeight.w400,
                              color: const Color(0xEE727C8D)),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 30.h,
                    ),
                    Text(
                      'Email',
                      style: GoogleFonts.inter(
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w700,
                          color: const Color(0xEE222831)),
                    ),
                    SizedBox(
                      height: 8.h,
                    ),
                    SizedBox(
                      width: double.infinity,
                      child: TextFormField(
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        controller: _emailController,
                        validator: (email) {
                          if (email == null || email.isEmpty) {
                            return 'Email Cannot be Empty';
                          } else if (!EmailValidator.validate(email)) {
                            return 'Email is not valid';
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(4.r)),
                          ),
                          hintText: 'youremail@email.com',
                          hintStyle: GoogleFonts.inter(
                              fontSize: 12.sp,
                              fontWeight: FontWeight.w400,
                              color: const Color(0xEE727C8D)),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 30.h,
                    ),
                    Text(
                      'Phone Number',
                      style: GoogleFonts.inter(
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w700,
                          color: const Color(0xEE222831)),
                    ),
                    SizedBox(
                      height: 8.h,
                    ),
                    SizedBox(
                      width: double.infinity,
                      child: TextFormField(
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        controller: _phoneNumController,
                        validator: (phone) {
                          if (phone == null || phone.isEmpty) {
                            return 'Phone Number Cannot be Empty';
                          } else if (phone.length < 10) {
                            return 'Phone Number is Not Valid';
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(4.r)),
                          ),
                          hintText: 'Enter phone number...',
                          hintStyle: GoogleFonts.inter(
                              fontSize: 12.sp,
                              fontWeight: FontWeight.w400,
                              color: const Color(0xEE727C8D)),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 30.h,
                    ),
                    Text(
                      'Password',
                      style: GoogleFonts.inter(
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w700,
                          color: const Color(0xEE222831)),
                    ),
                    SizedBox(
                      height: 8.h,
                    ),
                    SizedBox(
                      width: double.infinity,
                      child: TextFormField(
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        controller: _passwordController,
                        validator: (password) {
                          if (password == null || password.isEmpty) {
                            return 'Password Cannot be Empty';
                          } else if (password.length < 8) {
                            return 'Minimum Password Length is 8';
                          }
                          return null;
                        },
                        obscureText: !_isVisible,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(4.r)),
                          ),
                          hintText: 'Enter password...',
                          hintStyle: GoogleFonts.inter(
                              fontSize: 12.sp,
                              fontWeight: FontWeight.w400,
                              color: const Color(0xEE727C8D)),
                          suffixIcon: IconButton(
                            onPressed: () {
                              setState(() {
                                _isVisible = !_isVisible;
                              });
                            },
                            icon: _isVisible
                                ? const Icon(
                                    Icons.visibility,
                                    color: Colors.grey,
                                  )
                                : const Icon(
                                    Icons.visibility_off,
                                    color: Colors.grey,
                                  ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 30.h,
                    ),
                    Text(
                      'Password Confirmation',
                      style: GoogleFonts.inter(
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w700,
                          color: const Color(0xEE222831)),
                    ),
                    SizedBox(
                      height: 8.h,
                    ),
                    SizedBox(
                      width: double.infinity,
                      child: TextFormField(
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        controller: _confirmPasswordController,
                        validator: (password) {
                          if (password == null || password.isEmpty) {
                            return 'Password Cannot be Empty';
                          } else if (password.length < 8) {
                            return 'Minimum Password Length is 8';
                          } else if (password != _passwordController.text) {
                            return 'Password is not match';
                          }
                          return null;
                        },
                        obscureText: !_isVisible,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(4.r)),
                          ),
                          hintText: 'Enter password confirmation...',
                          hintStyle: GoogleFonts.inter(
                              fontSize: 12.sp,
                              fontWeight: FontWeight.w400,
                              color: const Color(0xEE727C8D)),
                          suffixIcon: IconButton(
                            onPressed: () {
                              setState(() {
                                _isVisible = !_isVisible;
                              });
                            },
                            icon: _isVisible
                                ? const Icon(
                                    Icons.visibility,
                                    color: Colors.grey,
                                  )
                                : const Icon(
                                    Icons.visibility_off,
                                    color: Colors.grey,
                                  ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 30.h,
                    ),
                    Center(
                      child: Container(
                        width: double.infinity,
                        height: 40.h,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(4.r)),
                        child: ElevatedButton(
                          style: const ButtonStyle(
                            backgroundColor:
                                MaterialStatePropertyAll(Color(0xEE3282B8)),
                          ),
                          onPressed: () async {
                            String name = _nameController.text;
                            String email = _emailController.text;
                            String phone = _phoneNumController.text;
                            String password = _passwordController.text;

                            if (_formKey.currentState!.validate()) {
                              registerProvider.setEmail(email);
                              registerProvider.setFullName(name);
                              registerProvider.setPhoneNumber(phone);
                              registerProvider.setPassword(password);

                              debugPrint('Email ${registerProvider.email}'
                                  '\nFull Name ${registerProvider.fullName}'
                                  '\nPhone Number ${registerProvider.phoneNumber}'
                                  '\nPassword ${registerProvider.password}');

                              User userRegister = User(
                                fullName: registerProvider.fullName,
                                email: registerProvider.email,
                                phoneNumber: registerProvider.phoneNumber,
                                password: registerProvider.password,
                              );

                              await registerProvider.register(userRegister);
                              const snackBar = SnackBar(
                                content: Text('Berhasil disimpan'),
                                backgroundColor: Color(0xff0080FF),
                              );

                              if (context.mounted) {
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(snackBar);

                                Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const LoginPage()));
                              }
                            }

                            // final SharedPreferences prefs =
                            //     await SharedPreferences.getInstance();
                            // await prefs.setBool('isOnboardingComplete', true);
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
                      height: 60.h,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Already have an account?',
                          style: GoogleFonts.inter(
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w400,
                            color: const Color(0xEE3282B8),
                          ),
                        ),
                        TextButton(
                            onPressed: () {
                              Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => const LoginPage()));
                            },
                            child: Text('Sign In',
                                style: GoogleFonts.inter(
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.w700,
                                  color: const Color(0xEE3282B8),
                                )))
                      ],
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
