import 'dart:convert';

import 'package:dqc/Api_Service/Api_service.dart';
import 'package:dqc/Model/Object.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);
  @override
  // ignore: library_private_types_in_public_api
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
    List<Object>? objListFromFB = [];

  bool isDetected = false;

  Image imageFromBase64String(String base64String) {
    return Image.memory(base64Decode(base64String));
  }

  Future<void> fetchData() async {
    // Fetch data from the service
    var response = await ApiService.getObj();

    // Update the state with the fetched data
    if (response != null) {
      setState(() {
        objListFromFB = response ?? [];
        isDetected = true;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text("0"),
        ),
        body: isDetected
            ? Center(
                child: ListView.builder(
                    physics: const AlwaysScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: objListFromFB?.length,
                    itemBuilder: (context, index) {
                      Object currentObj = objListFromFB![index];
                      return GestureDetector(
                        onTap: () {},
                        onLongPress: () {},
                        child: Container(
                          decoration: const BoxDecoration(
                            border:
                                Border(bottom: BorderSide(color: Colors.grey)),
                          ),
                          margin: const EdgeInsets.fromLTRB(10, 10, 10, 10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Image.memory(
                                  base64Decode(objListFromFB![index].img)),
                              Text(
                                objListFromFB![index].name,
                                maxLines: 1,
                                style: const TextStyle(
                                    fontSize: 30, fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        ),
                      );
                    }))
            : Container(
              child: Center(child: Text("Nothing to show, Try again"),),
            ));
  }
}
