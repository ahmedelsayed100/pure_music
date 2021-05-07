import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Widget mainDrawer({screenHeight, screenWidth, context}) {
  return Drawer(
    elevation: 4,
    child: Container(
      // color: Colors.pink,
      child: ListView(
        children: [
          Container(
            color: Colors.pink,
            height: screenHeight * 0.07,
          ),
          customListTile(
            label: "Home",
            iconData: Icons.home,
            myFun: () => Navigator.of(context).pushNamed("home"),
          ),
          customListTile(
            label: "About",
            iconData: Icons.info_outline,
            myFun: () => Navigator.of(context).pushNamed("home"),
          ),
        ],
      ),
    ),
  );
}

Widget customListTile({label, iconData, myFun}) {
  return ListTile(
    leading: Icon(iconData, size: 27, color: Colors.pink),
    title: Text(
      "$label",
      style: TextStyle(
        fontFamily: "Cairo",
        fontSize: 18,
      ),
    ),
    onTap: myFun,
  );
}

customSpacing({scHeight, scWidth}) {
  return SizedBox(
    height: scHeight,
    width: scWidth,
  );
}

Widget customElevatedButton({label, size, color, myFun}) {
  return ElevatedButton(
    onPressed: myFun,
    style: ButtonStyle(
      padding: MaterialStateProperty.resolveWith(
        (states) {
          return EdgeInsets.all(14);
        },
      ),
      backgroundColor: MaterialStateProperty.resolveWith(
        (states) {
          return color;
        },
      ),
      elevation: MaterialStateProperty.resolveWith(
        (states) {
          return 5;
        },
      ),
    ),
    child: Text(
      "$label",
      style: TextStyle(fontSize: size),
    ),
  );
}

Widget customFloatingActionButton({iconData, myFun}) {
  return FloatingActionButton(
    elevation: 4,
    backgroundColor: Colors.pink,
    child: Icon(
      iconData,
    ),
    onPressed: myFun,
  );
}
