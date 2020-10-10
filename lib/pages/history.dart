import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:xpire/constants/shared.dart';

class History extends StatefulWidget {
  @override
  _HistoryState createState() => _HistoryState();
}

class _HistoryState extends State<History> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white24,
        elevation: 0,
        title: Text(
            "History",
            style: GoogleFonts.beVietnam(color: Colors.black,fontSize: 20),
          ),
      ),
      body: ListView.builder(
        itemCount: history.length,
        itemBuilder: (context, index) {
          var item = history[index];
          var itemName = item.title.toString();
          var itemDate = item.expirationDate.toString();
          return Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10))),
              child: Dismissible(
                direction: DismissDirection.endToStart,
                background: Container(
                  alignment: Alignment.centerRight,
                  padding: EdgeInsets.only(right: 20.0),
                  color: Colors.redAccent,
                  child: Icon(
                    Icons.delete,
                    color: Colors.white,
                  ),
                ),
                key: UniqueKey(),
                onDismissed: (direction) {
                  setState(() {
                    history.removeAt(index);
                  });
                  Scaffold.of(context).showSnackBar(SnackBar(
                    content: Text("$itemName was removed"),
                    action: SnackBarAction(
                      label: "Undo",
                      onPressed: () {
                        undoDeletion(index, item);
                      },
                    ),
                  ));
                },
                child: ListTile(
                  leading: Container(
                    width: 40,
                    child: FittedBox(
                      fit: BoxFit.scaleDown,
                      child: Image.network(
                        history[index].url,
                      ),
                    ),
                  ),
                  title: Container(
                      width: 150,
                      child: Text(history[index].title,
                          overflow: TextOverflow.ellipsis)),
                  subtitle: Container(
                      width: 40,
                      child: Text("True expiration on $itemDate",
                          overflow: TextOverflow.ellipsis)),
                  trailing: IconButton(
                    icon: Icon(Icons.info),
                    onPressed: () {
                      showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              shape: RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(20)),
                              ),
                              content: Container(
                                  child: Text(history[index].expirationInfo)),
                            );
                          });
                    },
                  ),
                ),
              ));
        },
      ),
    );
  }

  //this function is used to undo a delte
  void undoDeletion(index, item) {
    setState(() {
      history.insert(index, item);
    });
  }
}
