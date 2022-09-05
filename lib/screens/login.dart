import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bounce/flutter_bounce.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:serviz/utils/colors.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _logintextController = TextEditingController();
  final _PasswordtextController = TextEditingController();
  FocusNode EmailFocusNode = new FocusNode();
  FocusNode PasswordFocusNode = new FocusNode();

  bool _isObscure = true;

  @override
  void initState() {
    super.initState();

    _logintextController.addListener(() => setState(() {}));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.yellow_accent,
      body: ScrollConfiguration(
        behavior: MyBehaviour(),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Center(
                  child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(70),
                      bottomRight: Radius.circular(70)),
                  color: AppColors.black_background,
                ),
                height: MediaQuery.of(context).size.height * 0.6,
                width: MediaQuery.of(context).size.width - 50,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      EmailIdTextForm(),
                      SizedBox(height: 30),
                      PasswordTextForm(),
                      SizedBox(
                        height: 60,
                      ),
                      Bounce(
                        duration: Duration(milliseconds: 110),
                        onPressed: () {
                          Get.toNamed('/createjoingroup');
                          //What to do on pressed
                        },
                        child: Container(
                          width: MediaQuery.of(context).size.width - 70,
                          height: MediaQuery.of(context).size.height * 1 / 15,
                          decoration: BoxDecoration(
                              border:
                                  Border.all(color: AppColors.yellow_accent),
                              borderRadius: BorderRadius.circular(30),
                              color: AppColors.yellow_accent),
                          child: Center(
                            child: Text(
                              'Login',
                              style: GoogleFonts.poppins(
                                  color: AppColors.black_background,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 15),
                      TextButton(
                        onPressed: () {},
                        child: Text(
                          "Create new account?",
                          style: GoogleFonts.poppins(
                              fontWeight: FontWeight.bold, fontSize: 12),
                        ),
                      )
                    ],
                  ),
                ),
              )),
              SizedBox(
                height: 70,
              ),
              Container(
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.design_services_rounded,
                          size: 40,
                          color: AppColors.grey_background,
                        ),
                        Text('servi',
                            style: GoogleFonts.poppins(
                                fontWeight: FontWeight.bold,
                                color: AppColors.black_background,
                                fontSize: 40)),
                        Text('z',
                            style: GoogleFonts.poppins(
                                fontWeight: FontWeight.bold,
                                color: AppColors.grey_background,
                                fontSize: 40))
                      ],
                    ),
                    SizedBox(height: 15),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Center(
                            child: Text(
                          'An app for service learning',
                          style: GoogleFonts.poppins(),
                        ))
                      ],
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget EmailIdTextForm() => TextField(
        focusNode: EmailFocusNode,
        cursorColor: AppColors.yellow_accent,
        controller: _logintextController,
        textInputAction: TextInputAction.next,
        style: GoogleFonts.poppins(
          color: AppColors.white_text,
          fontWeight: FontWeight.bold,
        ),
        decoration: InputDecoration(
          enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: AppColors.white_text),
              borderRadius: BorderRadius.circular(20)),
          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: AppColors.yellow_accent),
              borderRadius: BorderRadius.circular(20)),
          labelText: 'Email ID',
          labelStyle: GoogleFonts.poppins(
            color: EmailFocusNode.hasFocus
                ? AppColors.yellow_accent
                : AppColors.white_text,
          ),
        ),
      );

  Widget PasswordTextForm() => TextField(
        obscureText: _isObscure,
        focusNode: PasswordFocusNode,
        cursorColor: AppColors.yellow_accent,
        controller: _PasswordtextController,
        textInputAction: TextInputAction.next,
        style: GoogleFonts.poppins(
          color: AppColors.white_text,
          fontWeight: FontWeight.bold,
        ),
        decoration: InputDecoration(
            enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: AppColors.white_text),
                borderRadius: BorderRadius.circular(20)),
            focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: AppColors.yellow_accent),
                borderRadius: BorderRadius.circular(20)),
            labelText: 'Password',
            labelStyle: GoogleFonts.poppins(
              color: PasswordFocusNode.hasFocus
                  ? AppColors.yellow_accent
                  : AppColors.white_text,
            ),
            suffixIcon: IconButton(
              icon: Icon(
                _isObscure
                    ? Icons.visibility_rounded
                    : Icons.visibility_off_rounded,
                color: AppColors.white_text,
                size: 20,
              ),
              onPressed: () {
                setState(() {
                  _isObscure = !_isObscure;
                });
              },
            )),
      );
}

class MyBehaviour extends ScrollBehavior {
  @override
  Widget buildViewportChrome(
      BuildContext context, Widget child, AxisDirection axisDirection) {
    return child;
  }
}
