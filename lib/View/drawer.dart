import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppDrawer extends StatefulWidget {
  @override
  AppDrawerState createState() => AppDrawerState();
}

class AppDrawerState extends State<AppDrawer> {
  String logText = '';
  IconData logIcon ;
  bool _visableLoggedIn = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return buildColumn(context);
  }

  Column buildColumn(BuildContext context) {
    return Column(
      children: <Widget>[
          UserAccountsDrawerHeader(
            decoration: BoxDecoration(
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: AssetImage('assets/images/drawer-header.jpg'),
                )),
            currentAccountPicture: CircleAvatar(
              backgroundImage: NetworkImage(
                  'https://avatars2.githubusercontent.com/u/2400215?s=120&v=4'),
            ),
            // accountEmail: Text(""),
            accountName: Text("Omar Amarnah"), accountEmail: null,
          ),
        Expanded(
          child: ListView(
            shrinkWrap: true,
            children: <Widget>[
              // Visibility(
              //   visible: _visableLoggedIn,
              //   child: Column(
              //     children: [
              //       InkWell(
              //         onTap: () {
              //           Navigator.pop(context);
              //           Navigator.pushNamed(context, '/myAccount');
              //         },
              //         child: Container(
              //           height: 90,
              //           alignment: Alignment.center,
              //           decoration: BoxDecoration(
              //               shape: BoxShape.circle,
              //               gradient: LinearGradient(
              //                   colors: [Colors.orange, Colors.deepOrange])),
              //           child: CircleAvatar(
              //             radius: 40,
              //             backgroundImage:
              //             AssetImage("assets/images/drawer-header.jpg"),
              //           ),
              //         ),
              //       ),
              //       SizedBox(height: 5.0),
              //       Container(
              //         alignment: Alignment.center,
              //         child: Padding(
              //           padding: const EdgeInsets.only(left: 28.0, right: 25.0),
              //           child: Row(
              //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //             children: <Widget>[
              //               InkWell(
              //                 onTap: () {
              //                   Navigator.pop(context);
              //                   Navigator.pushNamed(context, '/myAccount');
              //                 },
              //                 child: Text(
              //                   "ProductService.nameUser",
              //                   style: TextStyle(
              //                       color: Colors.black,
              //                       fontSize: 18.0,
              //                       fontWeight: FontWeight.w600),
              //                 ),
              //               ),
              //               IconButton(
              //                 icon: Icon(
              //                   Icons.edit,
              //                   size: 20,
              //                 ),
              //                 onPressed: () {
              //                   Navigator.pop(context);
              //                   Navigator.pushNamed(context, '/myAccount');
              //                 },
              //               ),
              //             ],
              //           ),
              //         ),
              //       ),
              //       //SizedBox(height: 30.0),
              //     ],
              //   ),
              // ),
              ListTile(
                leading: Icon(Icons.home, color: Theme
                    .of(context)
                    .accentColor),
                title: Text('Home'),
                onTap: () {
                  //Navigator.pop(context);
                  Navigator.pushReplacementNamed(context, '/');
                },
              ),
              ListTile(
                leading: Icon(Icons.shopping_basket,
                    color: Theme
                        .of(context)
                        .accentColor),
                title: Text('My Orders'),
                onTap: () {
                },
              ),
              Divider(),
              ListTile(
                leading: Icon(Icons.g_translate,
                    color: Theme
                        .of(context)
                        .accentColor),
                title: Text('Languages'),
                onTap: () {
                },
              ),
            ],
          ),
        )
      ],
    );
  }
}
