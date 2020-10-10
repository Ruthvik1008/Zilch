import 'package:flutter/material.dart';
import 'package:xpire/models/history_model.dart';
import 'package:google_fonts/google_fonts.dart';

List<History> history = List<History>();

//styling for text on bottom nav bar
var bottomnavStyle = TextStyle(
  color: Colors.blueAccent,
  fontWeight: FontWeight.bold,
);

//const color used throughout UI
Color pixelBlue = Color.fromRGBO(66, 133, 244, 1);

//app bar used in all main.dart(which every screen also has)
AppBar constAppBar = AppBar(
  shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.all(Radius.circular(0))),
  elevation: 0,
  centerTitle: true,
  backgroundColor: Colors.grey[800],
  title: RichText(
    text: TextSpan(
        style: TextStyle(
            color: Colors.white, fontWeight: FontWeight.bold, fontSize: 30),
        children: <TextSpan>[
          TextSpan(text: "Z"),
          TextSpan(text: "ilch", style: TextStyle(color: pixelBlue))
        ]),
  ),
);

//instructional card on scan page
getCard(text,left,top,right,bottom) {
  return Padding(
      padding: EdgeInsets.fromLTRB(15, 0, 15, 15),
      child: Container(
        height: 100,
        width: double.infinity,
        child: Card(
            elevation: 10,
            color: pixelBlue,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(5))),
            child: Padding(
              padding: EdgeInsets.fromLTRB(15, 15, 15, 15),
              child: Text(
                text,
                style: GoogleFonts.beVietnam(color: Colors.white,fontSize: 15),
              ),
            )),
      ));
}

getHomeTile(text, imageAsset, expirationInfo, context) {
  return Padding(
      padding: EdgeInsets.fromLTRB(5,0,5,0),
      child: Card(
      child: ListTile(
        onTap: () {
          showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  title: Text(text,style: TextStyle(color: pixelBlue)),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                  ),
                  content: Container(child: Text(
                  expirationInfo,
                  style: GoogleFonts.beVietnam(color:Colors.black),
                ),),
                );
              });
        },
        leading: Container(
          width: 40,
          child: FittedBox(
            fit: BoxFit.scaleDown,
            child: Image.asset(
              imageAsset,
            ),
          ),
        ),
        title: Container(
            width: 150, child: Text(text, overflow: TextOverflow.ellipsis)),
      ),
    ),
  );
}

