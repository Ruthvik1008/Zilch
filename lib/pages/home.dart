import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:xpire/constants/shared.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: ListView(
      children: <Widget>[
        Padding(
          padding: EdgeInsets.all(10),
          child: Text(
            "Common Products",
            style: GoogleFonts.beVietnam(color: Colors.black,fontSize: 20),
          ),
        ),
        getHomeTile("Bread", "assets/bread.png", "Stale bread is edible, but be sure to remove any mold. You can even turn them into croutons.", context),
        getHomeTile("Canned Goods", "assets/canned-food.png", "Canned goods can be consumed up to four years after the expiration date as long as there are no punctures to the seal. Additionally, store in a cool and dry spot to maximize shelf life.", context),
        getHomeTile("Cereal", "assets/cereal.png", "If unopened, cereal can last 6-8 months past the expiration date. If opened, it will go stale in 4-6 monhts. You can still continue to eat it if you don't mind the stale taste.", context),
        getHomeTile("Cheese", "assets/cheese.png", "Hard cheeses are edible up to a month after the expiration date. Be sure to remove any mold.", context),
        getHomeTile("Chocolate", "assets/chocolate.png", "If stored in a cool,dry place, chocolate can be eater 2-4 months after the expiration date. If refrigerated, it can be eater 6-8 months after the expiration date.", context),
        getHomeTile("Eggs", "assets/eggs.png", "Eggs can last for 3-5 weeks after the expiration date. Additionally, you can place an egg in a glass of water. If it floats, it's spoiled. If not, you can cook it. ", context),
        getHomeTile("Yogurt", "assets/yogurt.png", "If refrigerated, yogurt can last up to a week after the expiration date. ", context),
      ],
    ));
  }
}
