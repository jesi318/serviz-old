import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:serviz/auth_controller.dart';
import 'package:serviz/utils/colors.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:get/get.dart';
import 'package:flutter_bounce/flutter_bounce.dart';

class SignUpPage extends StatefulWidget {
  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final _nametextController = TextEditingController();
  final _regnotextController = TextEditingController();
  final _emailidtextController = TextEditingController();
  final _passwordtextController = TextEditingController();
  final _classController = TextEditingController();

  FocusNode fullNamemyFocusNode = new FocusNode();
  FocusNode regnomyFocusNode = new FocusNode();
  FocusNode emailidmyFocusNode = new FocusNode();
  FocusNode passwordmyFocusNode = new FocusNode();
  FocusNode classFocusNode = new FocusNode();
  bool _repw_isObscure = true;
  List selClass = ['AIML', 'DS', 'IOT'];
  String _selectedval = 'AIML';

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.yellow_accent,
      body: ScrollConfiguration(
        behavior: MyBehavior(),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Center(
                child: Container(
                  height: MediaQuery.of(context).size.height * 0.83,
                  width: MediaQuery.of(context).size.width - 50,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(70),
                          bottomRight: Radius.circular(70)),
                      color: AppColors.grey_background),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        fullName(),
                        SizedBox(
                          height: 25,
                        ),
                        regno(),
                        SizedBox(
                          height: 25,
                        ),
                        emailid(),
                        SizedBox(
                          height: 25,
                        ),
                        password(),
                        SizedBox(
                          height: 25,
                        ),
                        classkey(),
                        SizedBox(
                          height: 25,
                        ),
                        Bounce(
                          duration: Duration(milliseconds: 110),
                          onPressed: () {
                            AuthController.instance.register(
                              _emailidtextController.text.trim(),
                              _passwordtextController.text,
                              _regnotextController.text,
                              _selectedval,
                              _nametextController.text,
                            );

                            AuthController.instance.postDetailsToFirestore(
                                _regnotextController.text,
                                _selectedval.toString(),
                                _nametextController.text);

                            //What to do on pressed
                          },
                          child: Center(
                            child: Container(
                              width: MediaQuery.of(context).size.width * 0.6,
                              height:
                                  MediaQuery.of(context).size.height * 1 / 15,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(30),
                                  color: AppColors.yellow_accent),
                              child: Center(
                                child: Bounce(
                                  duration: Duration(milliseconds: 110),
                                  onPressed: () {
                                    //do the auth control here
                                  },
                                  child: Text(
                                    'Sign Up',
                                    style: GoogleFonts.poppins(
                                        color: AppColors.black_background,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 15),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        TextButton(
                            onPressed: () {},
                            child: Bounce(
                              duration: Duration(milliseconds: 100),
                              onPressed: () {
                                Get.toNamed('/login');
                              },
                              child: Text(
                                'Already have an account?',
                                style: GoogleFonts.poppins(
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            )),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 15,
              ),
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
              Text(
                'An App for Service Learning',
                style: GoogleFonts.poppins(fontSize: 13),
              )
            ],
          ),
        ),
      ),
    );
  }

  //name field
  Widget fullName() => TextField(
        focusNode: fullNamemyFocusNode,
        cursorColor: AppColors.yellow_accent,
        controller: _nametextController,
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
          labelText: 'Name',
          labelStyle: GoogleFonts.poppins(
            color: fullNamemyFocusNode.hasFocus
                ? AppColors.yellow_accent
                : AppColors.white_text,
          ),
          // suffixIcon: _textController.text.isEmpty
          //     ? Container(
          //         width: 0,
          //       )
          //     : IconButton(
          //         icon: Icon(
          //           Icons.clear_rounded,
          //           color: AppColors.yellow_accent,
          //         ),
          //         onPressed: () {
          //           _textController.clear();
          //         },
          //       ),
        ),
      );

  //register number
  Widget regno() => TextField(
        focusNode: regnomyFocusNode,
        cursorColor: AppColors.yellow_accent,
        controller: _regnotextController,
        keyboardType: TextInputType.number,
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
          labelText: 'Register Number',
          labelStyle: GoogleFonts.poppins(
            color: regnomyFocusNode.hasFocus
                ? AppColors.yellow_accent
                : AppColors.white_text,
          ),
          // suffixIcon: _textController.text.isEmpty
          //     ? Container(
          //         width: 0,
          //       )
          //     : IconButton(
          //         icon: Icon(
          //           Icons.clear_rounded,
          //           color: AppColors.yellow_accent,
          //         ),
          //         onPressed: () {
          //           _textController.clear();
          //         },
          //       ),
        ),
      );

  //mail id
  Widget emailid() => TextField(
        focusNode: emailidmyFocusNode,
        cursorColor: AppColors.yellow_accent,
        controller: _emailidtextController,
        keyboardType: TextInputType.name,
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
          labelText: 'Email',
          labelStyle: GoogleFonts.poppins(
            color: emailidmyFocusNode.hasFocus
                ? AppColors.yellow_accent
                : AppColors.white_text,
          ),
          // suffixIcon: _textController.text.isEmpty
          //     ? Container(
          //         width: 0,
          //       )
          //     : IconButton(
          //         icon: Icon(
          //           Icons.clear_rounded,
          //           color: AppColors.yellow_accent,
          //         ),
          //         onPressed: () {
          //           _textController.clear();
          //         },
          //       ),
        ),
      );

  //password
  Widget password() => TextField(
        obscureText: _repw_isObscure,
        focusNode: passwordmyFocusNode,
        cursorColor: AppColors.yellow_accent,
        controller: _passwordtextController,
        textInputAction: TextInputAction.next,
        style: GoogleFonts.poppins(
          color: AppColors.white_text,
          fontWeight: FontWeight.bold,
        ),
        decoration: InputDecoration(
          suffixIcon: IconButton(
            icon: Icon(
                _repw_isObscure
                    ? Icons.visibility_rounded
                    : Icons.visibility_off_rounded,
                color: AppColors.white_text,
                size: 20),
            onPressed: () {
              setState(() {
                _repw_isObscure = !_repw_isObscure;
              });
            },
          ),
          enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: AppColors.white_text),
              borderRadius: BorderRadius.circular(20)),
          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: AppColors.yellow_accent),
              borderRadius: BorderRadius.circular(20)),
          labelText: 'Password',
          labelStyle: GoogleFonts.poppins(
            color: passwordmyFocusNode.hasFocus
                ? AppColors.yellow_accent
                : AppColors.white_text,
          ),
          // suffixIcon: _textController.text.isEmpty
          //     ? Container(
          //         width: 0,
          //       )
          //     : IconButton(
          //         icon: Icon(
          //           Icons.clear_rounded,
          //           color: AppColors.yellow_accent,
          //         ),
          //         onPressed: () {
          //           _textController.clear();
          //         },
          //       ),
        ),
      );

  //retype password
  Widget classkey() => DropdownButtonFormField(
      decoration: InputDecoration(
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(30))),
      focusColor: AppColors.yellow_accent,
      alignment: AlignmentDirectional.center,
      style: GoogleFonts.poppins(
        color: AppColors.white_text,
        fontWeight: FontWeight.bold,
      ),
      dropdownColor: AppColors.black_background,
      borderRadius: BorderRadius.circular(30),
      value: _selectedval,
      items: selClass
          .map((item) => DropdownMenuItem(
                child: Text(item),
                value: item,
              ))
          .toList(),
      onChanged: (val) {
        setState(() {
          _selectedval = val.toString();
        });
      });
  //
  // TextField(
  //       focusNode: classFocusNode,
  //       cursorColor: AppColors.yellow_accent,
  //       controller: _classController,
  //       textInputAction: TextInputAction.next,
  //       onSubmitted: (_) => FocusScope.of(context).unfocus(),
  //       style: GoogleFonts.poppins(
  //         color: AppColors.white_text,
  //         fontWeight: FontWeight.bold,
  //       ),
  //       decoration: InputDecoration(
  //         enabledBorder: OutlineInputBorder(
  //             borderSide: BorderSide(color: AppColors.white_text),
  //             borderRadius: BorderRadius.circular(20)),
  //         focusedBorder: OutlineInputBorder(
  //             borderSide: BorderSide(color: AppColors.yellow_accent),
  //             borderRadius: BorderRadius.circular(20)),
  //         labelText: 'Class',
  //         labelStyle: GoogleFonts.poppins(
  //           color: classFocusNode.hasFocus
  //               ? AppColors.yellow_accent
  //               : AppColors.white_text,
  //         ),

  //   ),
  // );
}

class MyBehavior extends ScrollBehavior {
  @override
  Widget buildViewportChrome(
      BuildContext context, Widget child, AxisDirection axisDirection) {
    return child;
  }
}
