import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_to_text/help.dart';
import 'package:launch_review/launch_review.dart';
import 'package:share/share.dart';


class DrawerAppBar extends StatefulWidget {
  @override
  _DrawerAppBarState createState() => _DrawerAppBarState();
}

class _DrawerAppBarState extends State<DrawerAppBar> {


  @override
  void initState() {
    // TODO: implement initState
    super.initState();

  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 260.0,
      child: Drawer(
        child: Container(
          child: ListView(
            children: [
              SizedBox(
                height: 10.0,
              ),
              Center(
                child: Image.asset(
                  "assets/imagetext.png",
                  width: 160.0,
                  height: 160.0,
                  ),
                ),
              Center(
                child: Text(
                  "Convert 2 Text",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 20.0,
                      ),
                ),
              ),
              SizedBox(
                height: 15.0,
              ),
              Divider(
                color: Colors.white,
              ),
              SizedBox(
                height: 20.0,
              ),
              ListTile(
                onTap: () {
                  final RenderBox box = context.findRenderObject();
                  Share.share('Hey I am enjoying using this app.To download this app use below link. \n https://play.google.com/store/apps/details?id=com.muralijha.image_to_text');
                },
                leading: Icon(
                  Icons.share
                ),
                title: Text(
                  "Share",
                ),
              ),
              SizedBox(
                height: 10.0,
              ),
              ListTile(
                onTap: () {
                  return LaunchReview.launch(
                    androidAppId: "com.muralijha.image_to_text",
                  );
                },
                leading: Icon(
                  Icons.star_rate_outlined
                ),
                title: Text(
                  "Rate the app",
                )
              ),
              SizedBox(
                height: 10.0,
              ),
              ListTile(
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(builder: (context){
                    return HelpApp();
                  }));
                },
                leading: Icon(
                  Icons.help_outline_sharp
                ),
                title: Text(
                  "Help",
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
