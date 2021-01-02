import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:stores_app/Controller/Constants.dart';
import 'package:stores_app/Controller/FetchData.dart';
import 'package:stores_app/Controller/ProductService.dart';
import 'package:stores_app/Module/UsersStores.dart';
import 'Product_detail.dart';
import 'loader/Loader.dart';
import 'loader/dot_type.dart';

class NewOrder extends StatefulWidget {
  @override
  _NewOrderState createState() => _NewOrderState();
}

class _NewOrderState extends State<NewOrder> {

  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  List<UsersStores> userStore;
  List<int> qty = new List<int>();
  // "${AppLocalizations.of(context).translate('Login')}"
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 500,
      child: Scaffold(
        key: scaffoldKey,
        body: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Colors.white, Colors.lightGreen[200]]
            ),
          ),
          child: Center(
            child: FutureBuilder<List<UsersStores>>(
              future: API.getUsersStores(),
              builder: (BuildContext context,
                  AsyncSnapshot<List<UsersStores>> snapshot) {
                if (snapshot.hasData) {
                  List<UsersStores> userStore = snapshot.data;
                  return getSnapshot(userStore);
                } else if (snapshot.hasError) {
                  print(" error = ${snapshot.error} ");
                  return Text("No Data");
                }
                return Container(
                  height: 50.0,
                  width: double.infinity,
                  child: Center(
                    child: ColorLoader(
                      dotOneColor: Colors.lightGreen,
                      dotTwoColor: Colors.lightGreen,
                      dotThreeColor: Colors.lightGreen,
                      dotIcon: Icon(Icons.adjust),
                      dotType: DotType.circle,
                      duration: Duration(seconds: 2),
                    ),
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }

  Widget getSnapshot( List<UsersStores> userStore) {
    return ListView.builder(
      physics: const AlwaysScrollableScrollPhysics(),
      itemCount: userStore?.length ?? 0,
      itemBuilder: (context, index) {
        for(int i=0;i<userStore.length;i++){
          qty.add(0);
        }
        return buildProduct(
            userStore[index], context, index);
      },
    );
  }

  Widget buildProduct(UsersStores product, BuildContext context, int index) {
    TextStyle priceTextStyle = TextStyle(
        color: Colors.blue, fontSize: 15, fontWeight: FontWeight.bold);
    if( product.qTY == null)
      product.qTY= qty[index].toString();
    else
      qty[index] = int.parse(product.qTY);

    void add() {
      setState(() {
        qty[index]++;
        if(!ProductService.listCartItems.containsKey(product.itemOCode)){
          product.qTY = qty[index].toString();
          print("product.qTY 2 = ${product.qTY}");
          ProductService.listCartItems.putIfAbsent(product.itemOCode , () => product);
        }
        else{
          ProductService.listCartItems.remove(product.itemOCode);
          product.qTY = qty[index].toString();
          ProductService.listCartItems.putIfAbsent(product.itemOCode , () => product);
        }
        ProductService.listCartItems.forEach((k,v) => print('$k: $v , ${v.qTY}'));
      });
    }

    void minus() {
      setState(() {
        if(qty[index] > 0)
          qty[index]--;
        if(ProductService.listCartItems.containsKey(product.itemOCode)) {
          ProductService.listCartItems.remove(product.itemOCode);
          if(qty[index] != 0){
            product.qTY = qty[index].toString();
            print("product.qTY 3 = ${product.qTY}");
            ProductService.listCartItems.putIfAbsent(product.itemOCode, () => product);
          }
        }
      });
    }

    // print("product.qTY 4 = ${product.qTY}");

    return Builder(
        builder: (BuildContext context) {
          return Container(
            width: 300.0,
            height: 100.0,
            child: Padding(
              padding: const EdgeInsets.symmetric(
                  horizontal: 8.0, vertical: 4.0),
              child: MaterialButton(
                padding: const EdgeInsets.all(0),
                elevation: 0.5,
                color: Colors.white,
                clipBehavior: Clip.antiAlias,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                onPressed: () {
                  print("indix in new $index");
                  print(product);
                  Navigator.push(context, MaterialPageRoute(builder: (_) {
                    return ProductDetails(index , product);
                  }));
                  // Navigator.of(context).push(MorpheusPageRoute(
                  //   builder: (context) => ProductDetails(),
                  //   parentKey: parentKey,
                  // ));
                  // Navigator.pushNamed(
                  //     context, '/productDetails',
                  //     arguments: product);
                },
                child: Row(
                  children: <Widget>[
                    Ink(
                      height: 100,
                      width: 100,
                      // child: new Image.memory(widget.bytes[index], fit: BoxFit.cover),
                      child: GestureDetector(
                        child: Hero(
                            tag: 'imageHero$index',
                            child: new Image.asset('assets/images/car.jpg')
                        ),
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: <Widget>[
                            Expanded(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisSize: MainAxisSize.min,
                                children: <Widget>[
                                  Text(product.itemNameE,
                                    style: TextStyle(fontSize: 17.0),),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Text(product.salePrice.toString(),
                                      style: priceTextStyle)
                                ],
                              ),
                            ),
                            Expanded(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisSize: MainAxisSize.min,
                                children: <Widget>[
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment
                                        .spaceBetween,
                                    mainAxisSize: MainAxisSize.min,
                                    children: <Widget>[
                                      Container(
                                        height: 25.0,
                                        width: 90.0,
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(
                                              50.0),
                                          color: Colors.white,
                                          boxShadow: [
                                            BoxShadow(
                                                color: Colors.grey.shade300,
                                                spreadRadius: 3),
                                          ],
                                        ),
                                        margin: EdgeInsets.only(left: 15),
                                        child: Row(
                                          // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          //mainAxisSize: MainAxisSize.min,
                                          children: <Widget>[
                                            Expanded(
                                              child: Padding(
                                                padding: const EdgeInsets
                                                    .only(right: 0.0),
                                                child: IconButton(
                                                  icon: Icon(Icons.remove),
                                                  color: Colors.red,
                                                  padding: EdgeInsets.only(
                                                      bottom: 1),
                                                  onPressed: () {
                                                    minus();
                                                  },
                                                  iconSize: 15,
                                                ),
                                              ),
                                            ),
                                            buildContainerCheckLang(),
                                            Text(
                                                qty[index].toString(),
                                                style: TextStyle(
                                                  color: Colors.black,
                                                  //backgroundColor: Colors.grey,
                                                  fontSize: 15,
                                                )
                                            ),
                                            buildContainerCheckLang2(),
                                            Expanded(
                                              child: IconButton(
                                                icon: Icon(Icons.add),
                                                color: Colors.green,
                                                padding: EdgeInsets.only(
                                                    bottom: 1),
                                                onPressed: () {
                                                  add();
                                                },
                                                iconSize: 15,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),

                                    ],
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        }
    );
  }

  Container buildContainerCheckLang2() {
    if(ProductService.language == "en")
      return Container(height: 40,
        width: 0,
        child: VerticalDivider(
            color: Colors.grey),
        margin: EdgeInsets.only(
            left: 10),
      );
    else
      return Container(height: 40,
        width: 0,
        child: VerticalDivider(
            color: Colors.grey),
        margin: EdgeInsets.only(
            right: 10),
      );
  }

  Container buildContainerCheckLang() {
    if(ProductService.language == "en")
      return Container(height: 40,
        width: 0,
        child: VerticalDivider(color: Colors.grey),
        margin: EdgeInsets.only(
            right: 10),
      );
    else
      return Container(height: 40,
        width: 0,
        child: VerticalDivider(color: Colors.grey),
        margin: EdgeInsets.only(
            left: 10),
      );
  }
}

    // return MaterialApp(
    //   home: Scaffold(
    //     body: SafeArea(
    //       child: CustomScrollView(
    //           slivers: <Widget>[
    //             SliverList(
    //               delegate: SliverChildBuilderDelegate(
    //                     (context, index) =>
    //                     Builder(builder: (BuildContext context){
    //                       return Container();
    //                     }
    //                     ),
    //               ),
    //             ),
    //           ]),
    //     ),
    //   ),
    // );
