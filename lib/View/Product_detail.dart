import 'dart:convert';
import 'dart:developer';
import 'dart:ffi';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:stores_app/Controller/ProductService.dart';
import 'package:stores_app/Module/UsersStores.dart';

import '../app_localizations.dart';
// ignore: must_be_immutable
class ProductDetails extends StatefulWidget {
  ProductDetails.c();
  ProductDetails(this.index , this.usersStores);
  int index;
  UsersStores usersStores;
  _Products createState() =>
      _Products(index,usersStores);
}

class _Products extends State<ProductDetails> {
  UsersStores usersStores;
  int index;
  int qty ;
  _Products(this.index, this.usersStores);


  @override
  void initState() {
    print("usersStores.itemNameE = ${usersStores.itemNameE}");
    print("usersStores.qTY = ${usersStores.qTY}");
    qty =  int.parse(usersStores.qTY);
    print(qty);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print(usersStores.itemNameE);
    log("indix in detailes $index" );


    void add() {
      setState(() {
        qty++;
      });
    }

    void minus() {
      setState(() {
        if(qty > 0)
          qty--;
      });
    }

    void addItemToList(){
      setState(() {
        if(!ProductService.listCartItems.containsKey(usersStores.itemOCode)){
          usersStores.qTY = qty.toString();
          print("product.qTY 2 = ${usersStores.qTY}");
          ProductService.listCartItems.putIfAbsent(usersStores.itemOCode , () => usersStores);
        }
        else{
          ProductService.listCartItems.remove(usersStores.itemOCode);
          usersStores.qTY = qty.toString();
          ProductService.listCartItems.putIfAbsent(usersStores.itemOCode , () => usersStores);
        }
        ProductService.listCartItems.forEach((k,v) => print('$k: $v , ${v.qTY}'));
      });

    }

    return Scaffold(
        appBar: AppBar(
          iconTheme: IconThemeData(color:Colors.white),
          title: Text("${AppLocalizations.of(context).translate('ProductDetail')}", style: TextStyle(color: Colors.white)),
        ),
        body: Builder(
          builder: (context) =>
              SafeArea(
                top: false,
                left: false,
                right: false,
                child: Column(
                  children: <Widget>[
                    Flexible(
                      flex:2,
                      child: SizedBox(
                        width: double.infinity,
                        height:  MediaQuery.of(context).size.height/3,
                        child: GestureDetector(
                          onTap: () {
                            log("indix in detailes $index" );
                            Navigator.pop(context,true);
                          },
                          child: Hero(
                            tag: 'imageHero$index',
                            child:  new Image.asset('assets/images/car.jpg', width:double.infinity,),
                              // child: new Image.memory(bytes)
                          ),
                        ),
                      ),
                    ),
                    Flexible(
                      flex:3,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 15, right: 15),
                        child: SizedBox(
                          width: double.infinity,
                          height:  MediaQuery.of(context).size.height,
                          child: Column(
                            children: <Widget>[
                              Container(
                                alignment: buildAlignmentDescription(),
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      top: 15, bottom: 15),
                                  child: Text(
                                    "${usersStores.itemNameE}",
                                    style: TextStyle(color: Colors.black,
                                        fontSize: 24,
                                        fontWeight: FontWeight.w600),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(bottom: 25),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment
                                      .spaceBetween,
                                  children: <Widget>[
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                                      children: <Widget>[
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              right: 10.0),
                                          child: Text(
                                            '\$ "${usersStores.salePrice}"',
                                            style: TextStyle(
                                              color: Theme
                                                  .of(context)
                                                  .primaryColor,
                                              fontSize: 20,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                        ),
                                        Text(
                                          '\$ "${usersStores.salePrice}"',
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 16,
                                            decoration: TextDecoration
                                                .lineThrough,
                                          ),
                                        ),
                                      ],
                                    ),
//                                   Row(
//                                     children: <Widget>[
//                                       SmoothStarRating(
//                                           allowHalfRating: false,
//                                           starCount: 5,
// //                                  rating: product['rating'],
//                                           size: 20.0,
//                                           color: Colors.amber,
//                                           borderColor: Colors.amber,
//                                           spacing: -0.8
//                                       ),
//                                       Padding(
//                                         padding: const EdgeInsets.only(
//                                             left: 10.0),
//                                         child: Text(
//                                             '(18.5)',
//                                             style: TextStyle(
//                                               color: Colors.black,
//                                               fontSize: 16,
//                                             )
//                                         ),
//                                       ),
//                                     ],
//                                   ),
                                  ],
                                ),
                              ),
                              // Padding(
                              //   padding: const EdgeInsets.only(bottom:8),
                              //   child: Text(
                              //     'You have in your cart $qty item',
                              //     style: TextStyle(color: colorQty,
                              //         fontSize: 17,
                              //         fontWeight: FontWeight.w600),
                              //   ),
                              // ),
                              Column(
                                children: <Widget>[
                                  Container(
                                      alignment: buildAlignmentDescription(),
                                      child: Padding(
                                        padding: const EdgeInsets.only(
                                            bottom: 10.0),
                                        child: Text(
                                         " ${AppLocalizations.of(context).translate('Description')}",
                                          style: TextStyle(color: Colors.black,
                                              fontSize: 20,
                                              fontWeight: FontWeight.w600),
                                        ),
                                      )
                                  ),
                                  Container(
                                      // alignment: Alignment(-1.0, -1.0),
                                      child: Text(
                                        "You can use various test drive services conveniently at Hyundai Motors Test Drive Centers that are spread across the country, We are doing our best to make your test drive experience as convenient.",
                                        style: TextStyle(
                                            color: Colors.black, fontSize: 16),
                                      )
                                  )
                                ],
                              ),

                            ],
                          ),
                        ),
                      ),
                    ),
                    Flexible(
                      flex: 1,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: <Widget>[
                          Container(
                            width: 60.0,
                            height: 54.0,
                            padding: EdgeInsets.only(right: 5),
                            child: Center(
                              child: ButtonTheme(
                                minWidth: 25.0,
                                height: 30.0,
                                child: Center(
                                  child: FlatButton(
                                    child: Center(
                                      child: IconButton(
                                        icon: Icon(Icons.favorite , color: Colors.red,),
                                        padding: EdgeInsets.only(
                                            right: 7),
                                        color: Colors.redAccent,
                                        onPressed: () {
                                        },
                                      ),
                                    ),
                                    textColor: Colors.white,
                                    shape: RoundedRectangleBorder(
                                        side: BorderSide(
                                            color: Colors.redAccent,
                                            width: 1,
                                            style: BorderStyle.solid
                                        ),
                                        borderRadius: BorderRadius
                                            .circular(12.0)),
                                    onPressed: () {
                                      print("add to faverits");
                                    },
                                  ),
                                ),
                              ),
                            ),
                          ),

                          Container(
                            height: 45.0,
                            width: 110.0,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12.0),
                              color: Colors.grey.shade300,
                              boxShadow: [
                                BoxShadow(color: Colors.grey.shade300,
                                    spreadRadius: 3),
                              ],
                            ),
                            child: Row(
                              children: <Widget>[
                                Expanded(
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                        right: 0.0),
                                    child: IconButton(
                                      icon: Icon(Icons.remove),
                                      color: Colors.red,
                                      padding: EdgeInsets.only(
                                          bottom: 1),
                                      onPressed: (){
                                        minus();
                                      },
                                    ),
                                  ),
                                ),
                                buildContainerCheckLang(),
                                Text(
                                    "$qty",
                                    style: TextStyle(
                                      color: Colors.black,
                                      //backgroundColor: Colors.grey,
                                      fontSize: 20,
                                    )
                                ),
                                buildContainerCheckLang2(),
                                Expanded(
                                  child: IconButton(
                                    icon: Icon(Icons.add),
                                    color: Colors.green,
                                    padding: EdgeInsets.only(bottom: 1),
                                    onPressed: (){
                                      add();
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ),

                          Container(
                            //margin: EdgeInsets.only(right: 15),
                            width: 150.0,
                            child: ButtonTheme(
                              minWidth: 50.0,
                              height: 50.0,
                              child: RaisedButton(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(
                                      12.0),
                                ),
                                color: Colors.lightGreen,
                                child: Text( "${AppLocalizations.of(context).translate('ADDTOCART')}",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                onPressed: () {
                                  if(qty > 0){
                                    addItemToList();
                                    Scaffold.of(context).showSnackBar(
                                      SnackBar(
                                        content: Text(
                                            "${AppLocalizations.of(context).translate('addedtocart')}"),
                                      ),
                                    );
                                  }
                                  else {
                                    Scaffold.of(context).showSnackBar(
                                      SnackBar(
                                        content: Text(
                                            "${AppLocalizations.of(context).translate('notaddedtocart')}"),
                                      ),
                                    );
                                  }
                                },
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
        ),
      );
    }

  Alignment buildAlignmentDescription(){
    if(ProductService.language == "en")
      return Alignment(-1.0, -1.0);
    else
      return Alignment(1.0, 1.0);
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
