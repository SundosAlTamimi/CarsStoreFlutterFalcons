import 'dart:developer';

import 'package:fancy_bottom_navigation/fancy_bottom_navigation.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:stores_app/View/NewOrder.dart';
import 'package:stores_app/View/SaleInv.dart';
import 'package:morpheus/morpheus.dart';
import '../app_localizations.dart';
import 'cart.dart';
import 'drawer.dart';
import 'loader/Loader.dart';
import 'loader/dot_type.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _currentIndex = 0;
  List<Widget> _children = [];
  List<Widget> _appBars = [];
  bool _visabile = false;
  final searchValue  = TextEditingController();
  String _scanBarcode = 'Unknown';
  bool resultScan = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _children.add(SaleInv());
    _children.add(NewOrder());
    _appBars.clear();
    _appBars.add(_buildAppBarOne("${AppLocalizations.of(context).translate('SaleInv')}"));
    _appBars.add(_buildAppBar());
  }

  Future<void> scanBarcodeNormal() async {
    // SaleInvState saleInv = new  SaleInvState();
    String barcodeScanRes;
    try {
      barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
          "#ff6666", "${AppLocalizations.of(context).translate('Cancel')}", true, ScanMode.BARCODE);
      log("barcodeScanRes 1 : $barcodeScanRes");
      SaleInvState(barcodeScanRes , context);
      // saleInv.getItemByBarcode(barcodeScanRes);
      // saleInv.build(context);
    } on PlatformException {
      barcodeScanRes = 'Failed to get platform version.';
    }
    if (!mounted) return;
    setState(() {
      print("barcodeScanRes 2 : $barcodeScanRes");
      _scanBarcode = barcodeScanRes;
      if (_scanBarcode != "-1")
        resultScan = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer:ClipPath(
        // clipper: OvalRightBorderClipper(),
        child: Container(
          width: 250.0,
          child: Drawer(
            child: AppDrawer(),
          ),
        ),
      ),
      backgroundColor: Colors.white70,
      appBar: _appBars[_currentIndex],
      body:  MorpheusTabView(
        child: DefaultTabController(
          length: 50,
          child: Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: Stack(
              children: <Widget>[
                Container(
                  //padding: EdgeInsets.only(top: 100),
                  height: MediaQuery.of(context).size.height,
                  width: double.infinity,
                  child: _children[_currentIndex] ,
                ),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: _buildBottomNavigationBar(),
    );
  }

  Widget _buildAppBarOne(String title) {
    return AppBar(
      iconTheme: IconThemeData(color:Colors.white),
      actions: <Widget>[
        Stack(
          children: [
            IconButton(
              icon: Icon(Icons.casino_outlined, color: Colors.white),
              onPressed: () {
                scanBarcodeNormal();
              },
            ),
          ],
        ),
      ],
      title: Text(title, style: TextStyle(color: Colors.white ,fontWeight: FontWeight.bold), textAlign: TextAlign.center,),

    );
  }

  Widget _buildBottomNavigationBar() {
    if(AppLocalizations.of(context).translate('Barcode') == "Barcode")
      return FancyBottomNavigation(
        tabs: [
          TabData(iconData: Icons.casino_outlined, title: AppLocalizations.of(context).translate('Barcode')),
          TabData(iconData: Icons.add, title: AppLocalizations.of(context).translate('NewOrder')),
        ],
        onTabChangedListener: (position) {
          _onTabTapped(position);
        },
      );
    else
      return BottomNavigationBar(
        onTap: _onTabTapped,
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
              icon: Icon(Icons.casino_outlined),
              // ignore: deprecated_member_use
              title: Text("${AppLocalizations.of(context).translate('Barcode')}")),
          BottomNavigationBarItem(
              icon: Icon(Icons.add),
              // ignore: deprecated_member_use
              title: Text("${AppLocalizations.of(context).translate('NewOrder')}")),
        ],
        type: BottomNavigationBarType.fixed,
        currentIndex: _currentIndex,
      );
  }

  _onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  Widget _buildAppBar() {
    final parentKey = GlobalKey();
    return  AppBar(
      iconTheme: IconThemeData(color:Colors.white),
      actions: <Widget>[
        Stack(
          children: [
            IconButton(
              icon: Icon(Icons.shopping_cart, color: Colors.white),
              onPressed: () {
                Navigator.of(context).push(MorpheusPageRoute(
                      builder: (context) => CartList(),
                      parentKey: parentKey,
                    ));
                // Navigator.pushNamed(context, "/cart", arguments: true);
              },
            ),
            Visibility(
              visible: _visabile,
              child: Container(
                width: 45,
                height: 30,
                alignment: Alignment.topRight,
                margin: EdgeInsets.only(top: 2),
                child: Container(
                  width: 17,
                  height: 17,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Color(0xffc32c37),
                    // border: Border.all(color: Colors.white, width: 1)
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(0.0),
                    child: Padding(
                      padding: const EdgeInsets.only(left:2.0),
                      child: Center(
                        child: Text(
                          "0",
                          style: TextStyle(fontSize: 10 , color: Colors.white , fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
      title: Stack(
          children : <Widget>[
            Container(
              height: 35.0,
              width: double.infinity,
              padding: EdgeInsets.only(right:20.0 , left: 20.0),
              child:
              Material(
                elevation: 5.0,
                borderRadius: BorderRadius.all(Radius.circular(5)),
                child: TextField(
                  controller: searchValue ,
                  cursorColor: Colors.green.shade600,
                  //style: dropdownMenuItem,
                  decoration: InputDecoration(
                      hintText: "${AppLocalizations.of(context).translate('Search')}",
                      hintStyle: TextStyle(
                          color: Colors.black38, fontSize: 16),
                      prefixIcon: Material(
                        elevation: 0.0,
                        borderRadius:
                        BorderRadius.all(Radius.circular(30)),
                        child: IconButton(
                          icon: Icon(Icons.search),
                          onPressed: (){
                            if(searchValue != null) {
                              print(" searchedValue = ${searchValue.text}");
                              //Navigator.pop(context);
                              Navigator.pushNamed(context, "/searchPage",
                                  arguments: searchValue.text);
                            }
                          },
                        ),
                      ),
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.symmetric(
                          horizontal: 15)),
                ),
              ),
            ),
          ]
      ),
    );
  }

}

