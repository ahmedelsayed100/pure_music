import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:pure_music/compnents/custom_widgets.dart';

import 'albums.dart';

class HomeScreen extends StatefulWidget {
  static String id = "home";
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _key = GlobalKey<FormState>();
  final _songController = TextEditingController();
  bool isSearched = false, toNav = false, showAlbums = false;

  String keyword = "";

  final List<dynamic> musicX = [];

  Future getData() async {
    var url = Uri.parse(
        "https://www.theaudiodb.com/api/v1/json/1/search.php?s=coldplay");
    var response = await http.get(url);
    var data = jsonDecode(response.body);
    // for (int i = 0; i < data.length; i++) {
    // temp = data["artists"][0];
    print(data['artists'][0]['strArtist'].toString());

    if (_songController.text.toString().toLowerCase() ==
        data["artists"][0]["strArtist"].toString().toLowerCase()) {
      musicX.add(data['artists'][0]['strArtist'].toString());
    }
    print(data['artists'][0]['strArtist'].toString());
  }

  @override
  void dispose() {
    _songController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
  }

  final _textStyle = TextStyle(
    fontFamily: "Cairo",
    fontSize: 24,
  );

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text("Pure Music"),
      ),
      drawer: mainDrawer(
          screenHeight: screenHeight,
          screenWidth: screenWidth,
          context: context),
      body: Container(
        padding: EdgeInsets.all(screenWidth * 0.06),
        child: Form(
          key: _key,
          child: ListView(
            children: [
              Text(
                "Write the name of your favorite singer",
                textAlign: TextAlign.center,
                style: _textStyle,
              ),
              customSpacing(scHeight: screenHeight * 0.02),
              Text(
                "It's just a click",
                textAlign: TextAlign.center,
                style: _textStyle,
              ),
              customSpacing(scHeight: screenHeight * 0.08),
              TextFormField(
                controller: _songController,
                validator: (value) {
                  if (value.isEmpty) {
                    return "can not search with this status 😐😐";
                  }
                  // return "";
                },
                decoration: InputDecoration(
                  labelText: "Singer",
                  labelStyle: TextStyle(
                    fontFamily: "Cairo",
                    fontSize: 24,
                  ),
                  hintText: "Ex: waka waka",
                  prefixIcon: Icon(
                    Icons.music_note,
                    size: 30,
                    color: Colors.amber,
                  ),
                  // filled: true,
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(screenWidth * 0.02),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(screenWidth * 0.02),
                  ),
                  errorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(screenWidth * 0.02),
                    borderSide: BorderSide(color: Colors.red),
                  ),
                  contentPadding: EdgeInsets.all(screenWidth * 0.055),
                ),
              ),
              customSpacing(scHeight: screenHeight * 0.06),
              isSearched == false
                  ? customElevatedButton(
                      color: Colors.amber,
                      myFun: () {
                        if (_key.currentState.validate()) {
                          // getData();
                          getData();
                          setState(() {
                            isSearched = true;
                          });
                        }
                      },
                      size: 20.0,
                      label: "Search",
                    )
                  : Container(
                      height: screenHeight * 0.6,
                      child: musicX[0].toString().isNotEmpty
                          ? Column(
                              children: [
                                musicX[0].toString().isNotEmpty
                                    ? CircularProgressIndicator()
                                    : Text(
                                        "name is " + musicX[0].toString(),
                                        // "${keyword.toString()}",
                                        style: _textStyle,
                                      ),
                                customSpacing(scHeight: 10.0),
                                toNav != true
                                    ? customElevatedButton(
                                        color: Colors.amber,
                                        myFun: () {
                                          setState(() {
                                            toNav = true;
                                          });
                                        },
                                        size: 20.0,
                                        label: "show Album",
                                      )
                                    : TextButton(
                                        onPressed: () {
                                          Navigator.of(context).push(
                                              MaterialPageRoute(
                                                  builder: (context) {
                                            return Albums(
                                              title: keyword.toString(),
                                            );
                                          }));
                                        },
                                        child: Text(
                                          "Go to albums page",
                                        ),
                                      ),
                              ],
                            )
                          : CircularProgressIndicator()
                      //  Column(
                      //     children: [
                      //       Text("not founded"),
                      //       customSpacing(scHeight: 10.0),
                      //       customElevatedButton(
                      //         color: Colors.amber,
                      //         myFun: () {
                      //           if (_key.currentState.validate()) {
                      //             setState(() {
                      //               _songController.text = "";
                      //               isSearched = false;
                      //             });
                      //           }
                      //         },
                      //         size: 20.0,
                      //         label: "try again",
                      //       )
                      //     ],
                      //   ),
                      ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.pink,
        child: Icon(
          Icons.favorite,
        ),
        onPressed: () {},
      ),
    );
  }
}
