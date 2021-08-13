import 'package:flutter/material.dart';

class HelpApp extends StatefulWidget {
  @override
  _HelpAppState createState() => _HelpAppState();
}

class _HelpAppState extends State<HelpApp> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("How to use this app?",style: TextStyle(color: Colors.white),),
        centerTitle: true,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
              bottom: Radius.circular(20.0)
          ),
        ),
      ),
      body: Container(
        margin: EdgeInsets.all(15.0),
        padding: EdgeInsets.all(6.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: OutlineButton(
                    onPressed: null,
                    color: Colors.white,
                    child: Text("Method 1",style: TextStyle(color: Colors.white,fontSize: 20.0),), shape: new RoundedRectangleBorder(borderRadius: new BorderRadius.circular(30.0))
                ),
              ),
              ListTile(
                title: Text("Click a add button at bottom right of the screen "),
                leading: Icon(Icons.double_arrow_sharp,size: 32.0,),
              ),
              Divider(color: Colors.white,),
              ListTile(
                title: Text("In popup select image from gallery / Capture a picture."),
                leading: Icon(Icons.double_arrow_sharp,size: 32.0,),
              ),
              Divider(color: Colors.white,),
              ListTile(
                title: Text("Select an Image from gallery / Capture a picture with camera."),
                leading: Icon(Icons.double_arrow_sharp,size: 32.0,),
              ),
              Divider(color: Colors.white,),
              ListTile(
                title: Text("Crop a picture you selected / Captured and click tick button on top right"),
                leading: Icon(Icons.double_arrow_sharp,size: 32.0,),
              ),
              Divider(color: Colors.white,),
              ListTile(
                title: Text("Please wait while the app performs OCR operation to extract text."),
                leading: Icon(Icons.double_arrow_sharp,size: 32.0,),
              ),
              Divider(color: Colors.white,),
              ListTile(
                title: Text("Long press on any word and then copy all or partial text to clipboard and done!"),
                leading: Icon(Icons.double_arrow_sharp,size: 32.0,),
              ),
              Divider(color: Colors.white,),
              SizedBox(
                height: 10.0,
              ),
              Center(
                child: OutlineButton(
                  onPressed: null,
                  color: Colors.white,
                  child: Text("Method 2",style: TextStyle(color: Colors.white,fontSize: 20.0),), shape: new RoundedRectangleBorder(borderRadius: new BorderRadius.circular(30.0))
                ),
              ),
              SizedBox(
                height: 10.0,
              ),
              ListTile(
                title: Text("You can directly click share button in gallery and directly share the picture with Convert2Text and follow the same process from method 1."),
                leading: Icon(Icons.double_arrow_sharp,size: 32.0,),
              ),
              Divider(color: Colors.white,),
            ],
          ),
        ),
      ),
    );
  }
}
