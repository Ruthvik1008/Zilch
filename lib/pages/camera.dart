import 'dart:convert';
import 'package:xpire/models/history_model.dart';
import 'package:flutter/material.dart';
import 'package:barcode_scan/barcode_scan.dart';
import 'package:http/http.dart' as http;
import 'package:xpire/constants/shared.dart';
import 'package:google_fonts/google_fonts.dart';

class Camera extends StatefulWidget {
  @override
  _CameraState createState() => _CameraState();
}

class _CameraState extends State<Camera> {
  var counter = 0;

  //returns information about scanned product
  scan() async {
    var result = await BarcodeScanner.scan();
    String barcode = result.rawContent.toString();
    print(barcode);

    //api call for product info
    http.Response myres = await http.get(
        "https://api.barcodelookup.com/v2/products?barcode=$barcode&key=5pgbv3jmqg29i8bmx81m3wqdqp7wy3");
    print(myres);

    //check for support(some barcodes are not supported)
    if (myres.body.isEmpty || barcode == null) {
      return null;
    }
    Map data;
    try {
      data = jsonDecode(myres.body);
    } on FormatException catch (e) {
      print('The provided string is not valid JSON');
      return null;
    }
    var myMap = new Map();
    try {
      myMap[0] = (data['products'][0]["images"][0]).toString();
    } catch (e) {
      myMap[0] =
          "https://upload.wikimedia.org/wikipedia/commons/thumb/a/ac/No_image_available.svg/1200px-No_image_available.svg.png";
    }
    myMap[1] = data['products'][0]['product_name'].toString();
    myMap[2] = data['products'][0]['description'].toString();
    var title1 = myMap[1];
    var date = DateTime.now();
    DateTime expireDate1;
    var expireDate;
    if (title1.contains("Mac & Cheese")) {
      myMap[3] =
          "If unopened, this product can be eaten a year after the expiration date"
              .toString();
      expireDate1 = DateTime(date.year + 1, date.day, date.month);
      expireDate = "4/26/22";
    } else if (myMap[1].contains("Beans")) {
      myMap[3] =
          "If sealed, this product can be eaten 3 years after the expiration date"
              .toString();
      expireDate1 = DateTime(date.year + 3, date.day, date.month);
      expireDate = "4/26/26";
    } else {
      myMap[3] = "This product can be eaten 2 weeks after the expiration date"
          .toString();
      expireDate = "Inspect product for foul smell before eating.";
    }

    print(data);

    var url = myMap[0];
    var title = myMap[1];
    var subText = myMap[2];
    var expirationInfo = myMap[3];

    History currentScan = History(
        url: url,
        title: title,
        subText: subText,
        expirationInfo: expirationInfo,
        expirationDate: expireDate.toString());
    //checks for duplicated and adds item to history page
    history.removeWhere((it) =>
          it.url == currentScan.url &&
          it.title == currentScan.title &&
          it.subText == currentScan.subText);
      history.add(currentScan);
    
    setState(() {
    });
    counter++;

    return myMap;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: new FloatingActionButton(
        backgroundColor: Colors.grey[800],
        child: const Icon(
          Icons.photo_camera,
        ),
        onPressed: () async {
          final url = await scan();
          print(url);

          showDialog(
              barrierDismissible: true,
              context: context,
              builder: (context) {
                // Future.delayed(Duration(seconds: 5), () {
                //   Navigator.of(context).pop(true);
                // });
                return (url == null || url.toString().isEmpty)
                    ? error
                    : AlertDialog(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(20)),
                        ),
                        content: Container(
                            height: 200,
                            width: double.infinity,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: <Widget>[
                                Container(
                                  width: 150,
                                  child: FittedBox(
                                    fit: BoxFit.scaleDown,
                                    child: Image.network(
                                      url[0],
                                      scale: 2.5,
                                    ),
                                  ),
                                ),
                                Flexible(
                                  child: Column(
                                    children: <Widget>[
                                      Container(
                                        width: 200,
                                        //height: 50,
                                        child: Text(
                                          url[1] == null ? "Error" : url[1],
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: Colors.black,
                                            fontSize: 15,
                                          ),
                                          textAlign: TextAlign.left,
                                          maxLines: 2,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                      SizedBox(height: 10),
                                      Container(
                                        width: 200,
                                        //height: 150,
                                        child: Text(
                                            url[2] == null ? "Error" : url[2],
                                            textAlign: TextAlign.left,
                                            style: TextStyle(
                                              color:
                                                  Colors.black.withOpacity(0.8),
                                              fontSize: 8,
                                            ),
                                            maxLines: 2,
                                            overflow: TextOverflow.ellipsis),
                                      ),
                                      SizedBox(height: 10),
                                      Divider(
                                        color: Colors.grey[800],
                                        thickness: 1,
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Expanded(
                                        child: Text(
                                          url[3] == null
                                              ? "Expiration date not supported yet"
                                              : url[3],
                                          style: TextStyle(
                                            fontSize: (12),
                                            color: Colors.black,
                                          ),
                                          textAlign: TextAlign.left,
                                          maxLines: 5,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      )
                                    ],
                                  ),
                                )
                              ],
                            )));
              });
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      body: Padding(
        padding: EdgeInsets.fromLTRB(0, 15, 0, 0),
        child: ListView(
          children: <Widget>[
            getCard("If you are unable to find your product in the homepage, you can scan it here. Your scanned products will be in logs page.",15,15,15,15),
            getCard("Remeber that the expiration date is not a safety date. You can consume many products after the expiration date.",15,0,15,5),
          ],
        ),
      ),
    );
  }
}

//alert dialog for error
AlertDialog error = AlertDialog(
  shape: RoundedRectangleBorder(
    borderRadius: BorderRadius.all(Radius.circular(20)),
  ),
  content: Container(child: Text("Barcode not supported")),
);
