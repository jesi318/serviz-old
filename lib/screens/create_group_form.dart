import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:serviz/utils/colors.dart';
import 'package:flutter_bounce/flutter_bounce.dart';

class CreateGroupForm extends StatefulWidget {
  @override
  State<CreateGroupForm> createState() => _CreateGroupFormState();
}

class _CreateGroupFormState extends State<CreateGroupForm> {
  final _textController = TextEditingController();
  FocusNode myFocusNode = new FocusNode();

  @override
  void initState() {
    super.initState();

    _textController.addListener(() => setState(() {}));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.grey_background,
      body: Container(
        child: Padding(
          padding: const EdgeInsets.all(70),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              groupcodetext(),
              SizedBox(
                height: 30,
              ),
              Bounce(
                duration: Duration(milliseconds: 110),
                onPressed: () {
                  //What to do on pressed
                },
                child: Container(
                  padding: EdgeInsets.only(
                      left: 100, right: 100, top: 20, bottom: 20),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      color: AppColors.yellow_accent),
                  child: Text(
                    'Join',
                    style: GoogleFonts.poppins(
                        color: AppColors.black_background,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget groupcodetext() => TextField(
        focusNode: myFocusNode,
        cursorColor: AppColors.yellow_accent,
        controller: _textController,
        decoration: InputDecoration(
          enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: AppColors.white_text),
              borderRadius: BorderRadius.circular(20)),
          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: AppColors.yellow_accent),
              borderRadius: BorderRadius.circular(20)),
          labelText: 'Group Code',
          labelStyle: GoogleFonts.poppins(
            color: myFocusNode.hasFocus
                ? AppColors.yellow_accent
                : AppColors.white_text,
          ),
          suffixIcon: _textController.text.isEmpty
              ? Container(
                  width: 0,
                )
              : IconButton(
                  icon: Icon(
                    Icons.clear_rounded,
                    color: AppColors.yellow_accent,
                  ),
                  onPressed: () {
                    _textController.clear();
                  },
                ),
        ),
      );
}
