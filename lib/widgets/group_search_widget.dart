import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:serviz/utils/colors.dart';

class SearchWidget extends StatefulWidget {
  const SearchWidget({super.key});

  @override
  State<SearchWidget> createState() => _SearchWidgetState();
}

class _SearchWidgetState extends State<SearchWidget>
    with SingleTickerProviderStateMixin {
  Animation<double>? animation;
  late AnimationController animController;
  bool isForward = false;
  bool isExtended = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    animController = AnimationController(
        duration: Duration(milliseconds: 1000), vsync: this);

    final curvedAnimation =
        CurvedAnimation(parent: animController, curve: Curves.easeOutExpo);

    animation = Tween<double>(begin: 0, end: 260).animate(curvedAnimation)
      ..addListener(() {
        setState(() {});
      });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Stack(children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(20, 48, 0, 0),
          child: Text(
            "Class Groups",
            style: GoogleFonts.poppins(
              fontWeight: FontWeight.bold,
              fontSize: 45,
              color: AppColors.white_text,
            ),
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Container(
              width: animation!.value,
              height: MediaQuery.of(context).size.height * 1 / 15,
              decoration: BoxDecoration(
                  color: AppColors.grey_background,
                  border: Border.all(color: AppColors.yellow_accent, width: 3),
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(50),
                      bottomLeft: Radius.circular(50))),
              child: Padding(
                padding: const EdgeInsets.only(
                  left: 20,
                  bottom: 5,
                ),
                child: TextField(
                  cursorColor: AppColors.white_text,
                  decoration: InputDecoration(
                      hintText: "Type here..",
                      hintStyle: GoogleFonts.poppins(color: Colors.white),
                      enabledBorder: UnderlineInputBorder(
                          borderSide:
                              BorderSide(color: AppColors.black_background))),
                  style: GoogleFonts.poppins(
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                    color: AppColors.white_text,
                  ),
                ),
              ),
            ),
            Container(
              width: 50,
              height: MediaQuery.of(context).size.height * 1 / 15,
              decoration: BoxDecoration(
                  borderRadius: animation!.value > 1
                      ? BorderRadius.only(
                          bottomRight: Radius.circular(50),
                          topRight: Radius.circular(50))
                      : BorderRadius.circular(50),
                  color: AppColors.yellow_accent),
              child: IconButton(
                  onPressed: () {
                    if (!isForward) {
                      animController.forward();
                      isForward = true;
                    } else {
                      animController.reverse();
                      isForward = false;
                    }
                  },
                  icon: Icon(Icons.search_rounded)),
            )
          ],
        ),
      ]),
    );
  }
}
