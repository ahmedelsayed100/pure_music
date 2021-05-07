import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:pure_music/compnents/custom_widgets.dart';

class Albums extends StatefulWidget {
  final String title;
  Albums({this.title});
  @override
  _AlbumsState createState() => _AlbumsState();
}

class _AlbumsState extends State<Albums> {
  final Map<String, dynamic> myAlbum = {};
  bool isClicked = false;
  Future getData() async {
    var url =
        Uri.parse("https://theaudiodb.com/api/v1/json/1/album.php?i=111239");
    var response = await http.get(url);
    var data = jsonDecode(response.body);

    for (int i = 0; i < data.length; i++) {
      print(data['album'][i]['strAlbum'].toString() + "---------");
      if (widget.title.toString().toLowerCase() ==
          data["album"][i]["strArtist"].toString().toLowerCase()) {
        myAlbum["strAlbum"] =
            data['album'][i]['strAlbum'].toString().toString();
        myAlbum["strAlbumThumb"] =
            data['album'][i]['strAlbumThumb'].toString().toString();
        myAlbum["strDescriptionEN"] =
            data['album'][i]['strDescriptionEN'].toString().toString();
      }
    }
    print("hi ${myAlbum['strAlbumThumb']}");
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    getData();
    final screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        title: Text("${widget.title}"),
      ),
      body: isClicked != true
          ? Padding(
              padding: const EdgeInsets.all(8.0),
              child: customElevatedButton(
                color: Colors.amber,
                label: "Show All Albums",
                myFun: () {
                  setState(() {
                    isClicked = true;
                  });
                },
                size: 18.0,
              ),
            )
          : Container(
              // margin: EdgeInsets.only(bottom: 40),
              child: ListView.builder(
                  padding: EdgeInsets.all(8),
                  itemCount: myAlbum.length,
                  itemBuilder: (context, index) {
                    return Column(
                      children: [
                        Text("${myAlbum["strAlbum"][index]}"),
                        Text("${myAlbum["strAlbumThumb"][index]}"),
                        Image.network("${myAlbum["strAlbumThumb"][index]}"),
                        AutoSizeText("${myAlbum["strDescriptionEN"][index]}"),
                        customSpacing(scHeight: screenHeight * 0.7),
                      ],
                    );
                  }),
            ),
    );
  }
}
