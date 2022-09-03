import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:serviz/utils/colors.dart';
import 'package:serviz/widgets/appbar.dart';
import 'package:serviz/widgets/drawer/drawer.dart';
import 'package:google_fonts/google_fonts.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);
  final String week = "Week";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(),
      drawer: NavigationDrawer(),
      body: Container(
        height: MediaQuery.of(context).size.height - 10,
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(20)),
          color: Color(0xFFF5F5F5),
        ),
        child: ListView.builder(
            physics: BouncingScrollPhysics(),
            itemCount: 8,
            shrinkWrap: false,
            itemBuilder: (BuildContext context, index) => Container(
                  width: MediaQuery.of(context).size.width,
                  padding:
                      EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
                  child: Container(
                    child: SingleChildScrollView(
                      child: Card(
                        elevation: 5.0,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20.0)),
                        child: Container(
                          width: MediaQuery.of(context).size.width,
                          height: MediaQuery.of(context).size.height * (1 / 6),
                          padding: EdgeInsets.symmetric(
                              horizontal: 10.0, vertical: 10.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Align(
                                alignment: AlignmentDirectional.centerStart,
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Align(
                                      alignment: AlignmentDirectional.center,
                                      child: Container(
                                        width: 55.0,
                                        height: 55.0,
                                        decoration: BoxDecoration(
                                            color: Color(0xFFF5F5F5),
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(20))),
                                        child: Container(
                                          width: 55.0,
                                          height: 55.0,
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      width: 17,
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: <Widget>[
                                        Container(
                                          width: 100,
                                          child: Text(
                                            "Name",
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 18.0,
                                                fontWeight: FontWeight.bold),
                                            maxLines: 4,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ),
                                        Align(
                                          alignment:
                                              AlignmentDirectional.bottomEnd,
                                          child: Text("Text",
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 15.0,
                                                  fontWeight:
                                                      FontWeight.normal)),
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                )),
      ),
    );
  }
}
