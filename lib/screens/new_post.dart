import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:location/location.dart';
import '../styles.dart';
import './home.dart';
import '../models/post.dart';

class NewPost extends StatefulWidget {
  static final routeName = "newPost";
  NewPost({Key key, this.title});
  final String title;
  @override
  NewPostState createState() => NewPostState();
}

class NewPostState extends State<NewPost> {
  Post post = Post();
  File image;
  final picker = ImagePicker();
  final formKey = GlobalKey<FormState>();

  LocationData locationData;
  var locationService = Location();

  @override
  void initState() {
    super.initState();
    getImage();
  }

  void getImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);
    image = File(pickedFile.path);
    setState(() {});
  }

  Future retrieveLocation() async {
    try {
      var _serviceEnabled = await locationService.serviceEnabled();
      if (!_serviceEnabled) {
        _serviceEnabled = await locationService.requestService();
        if (!_serviceEnabled) {
          print('Failed to enable service. Returning.');
          return;
        }
      }

      var _permissionGranted = await locationService.hasPermission();
      if (_permissionGranted == PermissionStatus.denied) {
        _permissionGranted = await locationService.requestPermission();
        if (_permissionGranted != PermissionStatus.granted) {
          print('Location service permission not granted. Returning.');
        }
      }

      locationData = await locationService.getLocation();
    } on PlatformException catch (e) {
      print('Error: ${e.toString()}, code: ${e.code}');
      locationData = null;
    }
    locationData = await locationService.getLocation();
    post.latitude = locationData.latitude;
    post.longitude = locationData.longitude;
  }

  Future uploadImage() async {
    StorageReference storageReference =
      FirebaseStorage.instance.ref().child('${DateTime.now()}');
    StorageUploadTask uploadTask = storageReference.putFile(image);
    await uploadTask.onComplete;
    post.imageUrl = await storageReference.getDownloadURL();
  }

  Widget build(BuildContext context) {
    if (image == null) {
      return Center(child: CircularProgressIndicator());
    } else {
      return Scaffold(
        appBar: AppBar(title: Center(child: Text(widget.title))),
        resizeToAvoidBottomInset: false,
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center, 
          children: [
            Center(
              child: Container(
                child: Image.file(image),
                height: Styles.adjustHeight(context, 0.4)
              )
            ),
            Center(
              child: Form(
                key: formKey,
                child: Semantics(
                  child: TextFormField(
                    autofocus: true,
                    keyboardType: TextInputType.number,
                    inputFormatters: [
                      FilteringTextInputFormatter.digitsOnly
                    ],
                    decoration: InputDecoration(
                        labelText: "Leftover Items",
                        border: OutlineInputBorder()
                    ),
                    onSaved: (value) {
                      post.quantity = int.parse(value);
                    },
                    validator: (value) {
                      if (value.isEmpty || int.parse(value) < 0) {
                        return 'Please enter a postive number of items.';
                      } else {
                        return null;
                      }
                    }
                  ),
                  textField: true,
                  enabled: true,
                  onTapHint: 'Enter the number of items'
                ), 
              )
            ),
            Semantics(
              child: ElevatedButton(
                child: Text("Post"),
                onPressed: () async {
                  if (formKey.currentState.validate()) {
                    formKey.currentState.save();
                    await uploadImage();
                    await retrieveLocation();
                    FirebaseFirestore.instance.collection('posts').add({
                      'date': DateTime.now(),
                      'imageURL': post.imageUrl,
                      'latitude': post.latitude,
                      'longitude': post.longitude,
                      'quantity': post.quantity
                    });
                    Navigator.pop(context);
                  }
                }
              ),
              button: true,
              enabled: true,
              onTapHint: 'Post entry',
            ),
            
          ]
        ),
      );
    }
  }

  void displayPost(BuildContext context, Post item) {
    Navigator.of(context).pushNamed(HomePage.routeName);
  }
}
