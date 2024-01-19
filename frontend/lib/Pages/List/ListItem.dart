import 'dart:convert';
import 'dart:core';
import 'dart:io';

import 'package:dqc/Model/Object.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:wikipedia/wikipedia.dart';

import '../../Api_Service/Api_service.dart';

class ListItem extends StatefulWidget {
  const ListItem({Key? key}) : super(key: key);
  @override
  // ignore: library_private_types_in_public_api
  _ListItemState createState() => _ListItemState();
}

class _ListItemState extends State<ListItem> {
  TextEditingController _controller = TextEditingController(text: "hello");

  List<WikipediaSearch> _data = [];
  List<Object> objList = [];

  bool _loading = false;
  bool isImageSelected = false;
  bool _apiCheck = false;

  late File imageFile;
  String? base64_img;

  @override
  void initState() {
    super.initState();
    ApiService.fetchAPICheck(_apiCheck);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.brown[400],
          centerTitle: true,
          title: Text("Home")
          ,
        ),
        body: Center(
            child: Column(
          children: [
            Container(
              height: 600,
              margin: EdgeInsets.all(10),
              child: isImageSelected
                  ? _apiCheck
                      ? Column(
                          children: [
                            Expanded(
                                child: ListView.builder(
                                    physics:
                                        const AlwaysScrollableScrollPhysics(),
                                    shrinkWrap: true,
                                    itemCount: objList?.length,
                                    itemBuilder: (context, index) {
                                      Object currentObj = objList![index];
                                      return Container(
                                        decoration: const BoxDecoration(
                                          border: Border(
                                              bottom: BorderSide(
                                                  color: Colors.grey)),
                                        ),
                                        margin: const EdgeInsets.fromLTRB(
                                            10, 10, 10, 10),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            Image.memory(base64Decode(
                                                objList![index].img)),
                                            Text(
                                              objList![index].name,
                                              maxLines: 1,
                                              textAlign: TextAlign.center,
                                              style: const TextStyle(
                                                  fontSize: 30,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ],
                                        ),
                                      );
                                    })),
                            Container(
                              height: 280,
                              child: Stack(
                                children: [
                                  ListView.builder(
                                    scrollDirection: Axis.vertical,
                                    itemCount: _data.length,
                                    padding: const EdgeInsets.all(8),
                                    itemBuilder: (context, index) => InkWell(
                                      onTap: () async {
                                        Wikipedia instance = Wikipedia();
                                        setState(() {
                                          _loading = true;
                                        });
                                        var pageData = await instance
                                            .searchSummaryWithPageId(
                                                pageId: _data[index].pageid!);
                                        setState(() {
                                          _loading = false;
                                        });
                                        if (pageData == null) {
                                          const snackBar = SnackBar(
                                            content: Text('Data Not Found'),
                                          );
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(snackBar);
                                        } else {
                                          showGeneralDialog(
                                            context: context,
                                            pageBuilder: (context, animation,
                                                    secondaryAnimation) =>
                                                Scaffold(
                                              appBar: AppBar(
                                                title: Text(_data[index].title!,
                                                    style: const TextStyle(
                                                        color: Colors.black)),
                                                backgroundColor: Colors.white,
                                                iconTheme: const IconThemeData(
                                                    color: Colors.black),
                                              ),
                                              body: ListView(
                                                padding:
                                                    const EdgeInsets.all(10),
                                                children: [
                                                  Text(
                                                    pageData!.title!,
                                                    style: const TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize: 20),
                                                  ),
                                                  const SizedBox(height: 8),
                                                  Text(
                                                    pageData.description!,
                                                    style: const TextStyle(
                                                        color: Colors.grey,
                                                        fontStyle:
                                                            FontStyle.italic),
                                                  ),
                                                  const SizedBox(height: 8),
                                                  Text(pageData.extract!)
                                                ],
                                              ),
                                            ),
                                          );
                                        }
                                      },
                                      child: Card(
                                        elevation: 5,
                                        margin: const EdgeInsets.all(8),
                                        child: Padding(
                                          padding: const EdgeInsets.all(10),
                                          child: Column(
                                            mainAxisSize: MainAxisSize.min,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: [
                                              Text(
                                                _data[index].title!,
                                                style: const TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 18),
                                              ),
                                              const SizedBox(height: 10),
                                              Text(_data[index].snippet!),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Visibility(
                                    visible: _loading,
                                    child: Container(
                                      width: MediaQuery.of(context).size.width,
                                      height:
                                          MediaQuery.of(context).size.height,
                                      child: const Center(
                                        child: CircularProgressIndicator(),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ],
                        )
                      : Apifailed()
                  : notSelectImage()
            ),
            Container(
              padding: EdgeInsets.fromLTRB(0, 20, 0, 5),
              margin: EdgeInsets.all(0.8),
              // child: Center()
              child:
                  Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                Container(
                    margin: EdgeInsets.fromLTRB(2.5, 0, 2.5, 0),
                    child: MaterialButton(

                      
                        minWidth: 150, // Set the minimum width
                        height: 50,
                        child: Text(
                          "Pick from Gallery",
                          style: TextStyle(color: Colors.white, fontSize: 20),
                        ),
                        color: Colors.brown[400],
                        onPressed: () async {
                          await _pickImagefromGallery();
                        })),
                Container(
                    margin: EdgeInsets.fromLTRB(2.5, 0, 2.5, 0),

                    //  EdgeInsets.all(2.5),
                    child: MaterialButton(
                        minWidth: 150, // Set the minimum width
                        height: 50,
                        child: Text("Pick from Camera",
                            style:
                                TextStyle(color: Colors.white, fontSize: 20)),
                        color: Colors.brown[400],
                        onPressed: () async {
                          await _pickImagefromCamera();
                        }))
              ]),
            ),
          ],
        )));
  }

  // Get image from gallery
  _pickImagefromGallery() async {
    try {
      final pickedImage =
          await ImagePicker().pickImage(source: ImageSource.gallery);
      if (pickedImage != null) {
        setState(() {
          imageFile = File(pickedImage.path);
          isImageSelected = true;
          detectImg3(imageFile);
        });
      } else {
        print('User didnt pick any image.');
      }
    } catch (e) {
      print(e.toString());
    }
  }

  //Chose image from Camera
  _pickImagefromCamera() async {
    try {
      final pickedImage =
          await ImagePicker().pickImage(source: ImageSource.camera);
      if (pickedImage != null) {
        setState(() {
          imageFile = File(pickedImage.path);
          isImageSelected = true;
        });
      } else {
        print('User didnt pick any image.');
      }
    } catch (e) {
      print(e.toString());
    }
  }

  // Detect image
  Future<void> detectImg3(File img) async {
    // Fetch data from the service
    var response = await ApiService.detectImg3(img);

    // Update the state with the fetched data
    if (response != null) {
      setState(() {
        objList = response ?? [];
        _controller.text = objList[0].name.toString();
        getLandingData();
      });
    }
  }

  // Get data from WikiAPI
  Future getLandingData() async {
    try {
      setState(() {
        _loading = true;
      });
      Wikipedia instance = Wikipedia();
      var result =
          await instance.searchQuery(searchQuery: _controller.text, limit: 10);
      setState(() {
        _loading = false;
        _data = result!.query!.search!;
      });
    } catch (e) {
      print(e);
      setState(() {
        _loading = false;
      });
    }
  }

  Widget Apifailed() {
    return Text("Server not working! Please try again");
  }

  Widget notSelectImage(){
    return Container(
                      child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Center(
                            child: Text(
                          "Nothing to show",
                          style: TextStyle(
                            fontWeight: FontWeight.normal,
                            fontSize: 20,
                          ),
                        )),
                      ],
                    ));
  }
}
