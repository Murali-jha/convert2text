import 'dart:async';
import 'dart:io';
import 'package:image_cropper/image_cropper.dart';
import 'package:firebase_ml_vision/firebase_ml_vision.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:image_to_text/drawer.dart';
import 'package:receive_sharing_intent/receive_sharing_intent.dart';
import 'package:image_to_text/help.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  String result = "" ;
  File image;
  ImagePicker imagePicker;
  File val;
  StreamSubscription _intentDataStreamSubscription;
  List<SharedMediaFile> _sharedFiles;

  pickImageFromGallery() async{
    PickedFile pickedFile = await imagePicker.getImage(source: ImageSource.gallery);
    File croppedFile = await ImageCropper.cropImage(
       sourcePath: pickedFile.path,
        aspectRatioPresets: Platform.isAndroid
            ? [
          CropAspectRatioPreset.square,
          CropAspectRatioPreset.ratio3x2,
          CropAspectRatioPreset.original,
          CropAspectRatioPreset.ratio4x3,
          CropAspectRatioPreset.ratio16x9
        ]
            : [
          CropAspectRatioPreset.original,
          CropAspectRatioPreset.square,
          CropAspectRatioPreset.ratio3x2,
          CropAspectRatioPreset.ratio4x3,
          CropAspectRatioPreset.ratio5x3,
          CropAspectRatioPreset.ratio5x4,
          CropAspectRatioPreset.ratio7x5,
          CropAspectRatioPreset.ratio16x9
        ],
        androidUiSettings: AndroidUiSettings(
            toolbarTitle: 'Cropper',
            toolbarColor: Colors.deepOrange,
            toolbarWidgetColor: Colors.white,
            initAspectRatio: CropAspectRatioPreset.original,
            lockAspectRatio: false),
        iosUiSettings: IOSUiSettings(
          title: 'Cropper',
        ));

    image = File(croppedFile.path);

    setState(() {
      image;
      performImageLabelling();
    });
  }

  captureImage() async{
    PickedFile pickedFile = await imagePicker.getImage(source: ImageSource.camera);

      File croppedFile = await ImageCropper.cropImage(
          sourcePath: pickedFile.path,
          aspectRatioPresets: Platform.isAndroid
              ? [
            CropAspectRatioPreset.square,
            CropAspectRatioPreset.ratio3x2,
            CropAspectRatioPreset.original,
            CropAspectRatioPreset.ratio4x3,
            CropAspectRatioPreset.ratio16x9
          ]
              : [
            CropAspectRatioPreset.original,
            CropAspectRatioPreset.square,
            CropAspectRatioPreset.ratio3x2,
            CropAspectRatioPreset.ratio4x3,
            CropAspectRatioPreset.ratio5x3,
            CropAspectRatioPreset.ratio5x4,
            CropAspectRatioPreset.ratio7x5,
            CropAspectRatioPreset.ratio16x9
          ],
          androidUiSettings: AndroidUiSettings(
              toolbarTitle: 'Cropper',
              toolbarColor: Colors.deepOrange,
              toolbarWidgetColor: Colors.white,
              initAspectRatio: CropAspectRatioPreset.original,
              lockAspectRatio: false),
          iosUiSettings: IOSUiSettings(
            title: 'Cropper',
          ));

    image = File(croppedFile.path);

    setState(() {
      image;
      performImageLabelling();
    });
  }

  performImageLabelling() async{
    final FirebaseVisionImage firebaseVisionImage = FirebaseVisionImage.fromFile(image);
    final TextRecognizer recognizer = FirebaseVision.instance.textRecognizer();
    VisionText visionText = await recognizer.processImage(firebaseVisionImage);
    result = "";
    setState(() {
      for(TextBlock block in visionText.blocks){
        final String txt = block.text;

        for(TextLine line in block.lines ){
          for(TextElement element in line.elements){
            result+=element.text+" ";
          }
        }
        result += "\n";
      }
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    imagePicker = ImagePicker();

    _intentDataStreamSubscription = ReceiveSharingIntent.getMediaStream()
        .listen((List<SharedMediaFile> value) {
      setState(() {
        _sharedFiles = value;
        print("Shared:" + (_sharedFiles?.map(
                (f) async{
                  File croppedFile = await ImageCropper.cropImage(
                      sourcePath: f.path,
                      aspectRatioPresets: Platform.isAndroid
                          ? [
                        CropAspectRatioPreset.square,
                        CropAspectRatioPreset.ratio3x2,
                        CropAspectRatioPreset.original,
                        CropAspectRatioPreset.ratio4x3,
                        CropAspectRatioPreset.ratio16x9
                      ]
                          : [
                        CropAspectRatioPreset.original,
                        CropAspectRatioPreset.square,
                        CropAspectRatioPreset.ratio3x2,
                        CropAspectRatioPreset.ratio4x3,
                        CropAspectRatioPreset.ratio5x3,
                        CropAspectRatioPreset.ratio5x4,
                        CropAspectRatioPreset.ratio7x5,
                        CropAspectRatioPreset.ratio16x9
                      ],
                      androidUiSettings: AndroidUiSettings(
                          toolbarTitle: 'Cropper',
                          toolbarColor: Colors.deepOrange,
                          toolbarWidgetColor: Colors.white,
                          initAspectRatio: CropAspectRatioPreset.original,
                          lockAspectRatio: false),
                      iosUiSettings: IOSUiSettings(
                        title: 'Cropper',
                      ));

                  image = File(croppedFile.path);
                  performImageLabelling();
                  return f.path;
            }
        )?.join(",") ?? ""));
      });
    }, onError: (err) {
      print("getIntentDataStream error: $err");
    });

    // For sharing images coming from outside the app while the app is closed
    ReceiveSharingIntent.getInitialMedia().then((List<SharedMediaFile> value) {
      setState(() {
        _sharedFiles = value ;
        print("Shared:" + (_sharedFiles?.map(
                (f) async {
                  File croppedFile = await ImageCropper.cropImage(
                      sourcePath: f.path,
                      aspectRatioPresets: Platform.isAndroid
                          ? [
                        CropAspectRatioPreset.square,
                        CropAspectRatioPreset.ratio3x2,
                        CropAspectRatioPreset.original,
                        CropAspectRatioPreset.ratio4x3,
                        CropAspectRatioPreset.ratio16x9
                      ]
                          : [
                        CropAspectRatioPreset.original,
                        CropAspectRatioPreset.square,
                        CropAspectRatioPreset.ratio3x2,
                        CropAspectRatioPreset.ratio4x3,
                        CropAspectRatioPreset.ratio5x3,
                        CropAspectRatioPreset.ratio5x4,
                        CropAspectRatioPreset.ratio7x5,
                        CropAspectRatioPreset.ratio16x9
                      ],
                      androidUiSettings: AndroidUiSettings(
                          toolbarTitle: 'Cropper',
                          toolbarColor: Colors.deepOrange,
                          toolbarWidgetColor: Colors.white,
                          initAspectRatio: CropAspectRatioPreset.original,
                          lockAspectRatio: false),
                      iosUiSettings: IOSUiSettings(
                        title: 'Cropper',
                      ));

                  image = File(croppedFile.path);
                  performImageLabelling();
                  return f.path;
                }
        )?.join(",") ?? ""));
      });
    });


  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: DrawerAppBar(),
      appBar: AppBar(
        //backgroundColor: Colors.deepOrange,
        actions: [
          IconButton(
            icon: Icon(Icons.help_outline_sharp),
            onPressed: (){
              Navigator.of(context).push(MaterialPageRoute(builder: (context){
                return HelpApp();
              }));
            },
          )

        ],
        title: Text("Convert 2 Text",style: TextStyle(color: Colors.white),),
        centerTitle: true,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(20.0)
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.deepOrange,
        child: Icon(
          Icons.add,color: Colors.white,
        ),
        onPressed: (){
          showDialog(
              context: context,
              builder: (context){
                  return AlertDialog(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18.0),
                      ),
                    title: Column(
                      children: [
                        ListTile(
                          title: Text(
                              "Click a picture",
                            style: TextStyle(fontSize: 20.0),
                          ),
                          leading: Icon(Icons.camera),
                          onTap: (){
                            captureImage();
                            Navigator.of(context).pop();
                          },
                        ),
                        ListTile(
                          leading: Icon(Icons.photo_size_select_actual_rounded),
                          title: Text("Choose from gallery",style: TextStyle(fontSize: 20.0),),
                          onTap: (){
                            pickImageFromGallery();
                            Navigator.of(context).pop();
                          },
                        )
                      ],
                    ),
                  );
              }
          );
        },
      ),
      body: SizedBox.expand(
        child: Container(
          child: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: Colors.black87,
                      border: Border.all(
                        color: Colors.white54,
                      ),
                      borderRadius: BorderRadius.all(Radius.circular(15))
                  ),
                  //color: Colors.black,
                  margin: const EdgeInsets.only(top: 30.0),
                  height: 200.0,
                  width: 170.0,
                  child: InkWell(
                    onTap: (){
                      showDialog(
                          context: context,
                          builder: (context){
                            return AlertDialog(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(18.0),
                              ),
                              title: Column(
                                children: [
                                  ListTile(
                                    title: Text(
                                      "Click a picture",
                                      style: TextStyle(fontSize: 20.0),
                                    ),
                                    leading: Icon(Icons.camera),
                                    onTap: (){
                                      captureImage();
                                      Navigator.of(context).pop();
                                    },
                                  ),
                                  ListTile(
                                    leading: Icon(Icons.photo_size_select_actual_rounded),
                                    title: Text("Choose from gallery",style: TextStyle(fontSize: 20.0),),
                                    onTap: (){
                                      pickImageFromGallery();
                                      Navigator.of(context).pop();
                                    },
                                  )
                                ],
                              ),
                            );
                          }
                      );
                    },
                    child: Center(
                      child: image!=null?
                          ClipRRect(
                              borderRadius: BorderRadius.circular(15),
                              child: Image.file(
                                image,width: 170.0,
                                height: 200.0,
                                fit: BoxFit.fill,
                              )
                          )
                          :Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(Icons.photo_camera,color: Colors.white,size: 40.0,),
                                  SizedBox(height: 10.0,),
                                  Text(
                                    "No Image Selected",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 19.0
                                    ),
                                  ),
                                ],
                              )
                          )
                    ),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.fromLTRB(15.0,20.0,15.0,0.0),
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        SelectableText(
                          result ,
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 23.0
                          ),
                          textAlign: TextAlign.justify,
                        ),
                        SizedBox(height: 59.0,)
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      )
    );
  }
}
