import 'dart:convert';
import 'dart:developer';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:intl/intl.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:stores_app/Controller/FetchData.dart';
import 'package:stores_app/Controller/ProductService.dart';
import 'package:stores_app/Module/ItemCode.dart';
import 'package:stores_app/Module/UsersStores.dart';

import '../app_localizations.dart';
import 'loader/Loader.dart';
import 'loader/dot_type.dart';
// ignore: must_be_immutable
class CartList extends StatefulWidget {
  @override
  _CartListState createState() => _CartListState();
}

var run = false;

class _CartListState extends State<CartList> {
  bool selected = false;
  List<UsersStores> listValue =  new List<UsersStores>();
  var listKey = [];
  static double voucherTotal = 0;

  void deleteCart() {
    setState(() {
      voucherTotal = 0;
      listValue.clear();
      ProductService.listCartItems.clear();
    });
  }

  void notificationSuccessfully(context){
    Alert(
      context: context,
      image: Image.asset("assets/images/success.png" , width: 50 , height: 50,),
      title: "${AppLocalizations.of(context).translate('SuccessfullyAdded')}",
      desc: "${AppLocalizations.of(context).translate('SuccessfullyAddedDetails')}",
      buttons: [ DialogButton(
        color: Colors.lightGreen,
        child: Text(
          "OK",
          style: TextStyle(color: Colors.white, fontSize: 20),
        ),
        onPressed: () {
          Navigator.pop(context);
        },
        width: 120,
      ),
      ],
    ).show();
  }

  void addVoucher (String jsonUserStore){
    API.addVoucher(jsonUserStore).then((response) {
      if(response.statusCode == 200) {
        notificationSuccessfully(context);
      }
    });
  }

  void addVoucherTotal(){
    print("voucherTotal 1= $voucherTotal");
    double vT = 0;
    for(int i = 0; i < listValue.length ; i++){
      vT += double.parse(listValue[i].salePrice) * double.parse(listValue[i].qTY);
      print("vT 2= $vT");
    }
    setState(() {
      voucherTotal = vT;
      print("voucherTotal 2= $voucherTotal");
      for(int i = 0; i < listValue.length ; i++)
        listValue[i].vOHTOTAL = voucherTotal.toString();

    });
  }

  // void addVoucherTotalInit(){
  //   print("addVoucherTotalInit");
  //   print("voucherTotal 1= $voucherTotal");
  //   double vT = 0;
  //   for(int i = 0; i < listValue.length/2 ; i++){
  //     vT += double.parse(listValue[i].iTEMTOTAL);
  //     print("vT 2= $vT");
  //   }
  //   setState(() {
  //     voucherTotal = vT;
  //     print("voucherTotal 2= $voucherTotal");
  //     for(int i = 0; i < listValue.length ; i++)
  //       listValue[i].vOHTOTAL = voucherTotal.toString();
  //
  //   });
  // }

  void checkOut(){
    addVoucherTotal();
    ListUsersStores listUserStore = new ListUsersStores(uSERSTORES:listValue);
    String jsonUserStore = jsonEncode(listUserStore);
    log(jsonUserStore);
    addVoucher(jsonUserStore);
  }
  @override
  void initState() {
    run = false;
    Future.delayed(Duration.zero, () {
      ProductService.listCartItems.forEach((k, v) =>
      {
        listValue.add(v),
        listKey.add(k)
      });
      addVoucherTotal();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if(run){
      addVoucherTotal();
      listValue.clear();
      listKey.clear();
      ProductService.listCartItems.forEach((k, v) =>
      {
        listValue.add(v),
        listKey.add(k)
      });
    }
    else
      run = true;

    if(listValue.isNotEmpty) {
      return Scaffold(
          appBar: AppBar(
            iconTheme: IconThemeData(color: Colors.white),
            leading: IconButton(
              icon: Icon(Icons.arrow_back, color: Colors.white),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            actions: <Widget>[
              Padding(
                padding: const EdgeInsets.only(right: 18.0),
                child: IconButton(
                  icon: Icon(Icons.delete, color: Colors.redAccent, size: 25),
                  onPressed: () {
                    deleteCart();
                  },
                ),
              ),
            ],
            title: Text(
              "${AppLocalizations.of(context).translate('MyCart')}",
              style: TextStyle(
                  color: Colors.white, fontWeight: FontWeight.bold),
            ),
          ),
          body: Column(
            children: <Widget>[
              Flexible(
                child: ListView.builder(
                  itemCount: listValue.length,
                  itemBuilder: (context, int index) {
                    print('My Cart 2');
                    return cartItems(index, listValue[index]);
                  },
                ),
              ),
              _checkoutSection()
            ],
          ));
    }
    else{
      return  Container(
        color: Colors.white,
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
    }
  }

  Widget cartItems(int index, UsersStores product) {

    product.vOHTYPE = "1";
    product.uSERNO = API.userNo;
    product.uSERNOSERIAL = API.serialNo;

    String getItemTotal(){
      int qty = int.parse(product.qTY);
      double salesPrice = double.parse(product.salePrice);
      double total = qty * salesPrice;
      var f = NumberFormat("###.0#", "en_US");
      print(f.format(total));
      product.iTEMTOTAL = total.toString();
      // addVoucherTotal();
      return f.format(total).toString();
    }

    String itemTotal = getItemTotal();

    void deleteItem() {
      setState(() {
        // listValue[index] =
        listValue.removeAt(index);
        ProductService.listCartItems.remove(listKey[index]);
      });
    }

    void add() {
      int qty = int.parse(product.qTY);
      setState(() {
        qty++;
        // deleteItem();
        product.qTY = qty.toString();
        ProductService.listCartItems.putIfAbsent(product.itemOCode , () => product);
        ProductService.listCartItems.forEach((k,v) => print('$k: $v , ${v.qTY}'));
        itemTotal = getItemTotal();
        addVoucherTotal();
      });
    }

    void minus() {
      int qty = int.parse(product.qTY);
      setState(() {
        if(qty > 0)
          qty--;
        if(ProductService.listCartItems.containsKey(product.itemOCode)) {
          // deleteItem();
          if(qty != 0){
            product.qTY = qty.toString();
            ProductService.listCartItems.putIfAbsent(product.itemOCode, () => product);
          }
        }
        itemTotal= getItemTotal();
        addVoucherTotal();
      });
    }

    return RoundedContainer(
      padding: const EdgeInsets.all(0),
      margin: EdgeInsets.all(10),
      height: 150,
      child: Row(
        children: <Widget>[
          Container(
            width: 130,
            child: Ink(
              child:  new Image.asset('assets/images/car.jpg'),
              // child: new Image.memory(bytes[index], fit: BoxFit.cover),
            ),
          ),
          Flexible(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Column(
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Flexible(
                        child: Text(
                          product.itemNameE,
                          overflow: TextOverflow.fade,
                          softWrap: true,
                          style: TextStyle(
                              fontWeight: FontWeight.w600, fontSize: 15),
                        ),
                      ),
                      Container(
                        width: 50,
                        child: IconButton(
                          onPressed: () {
                            deleteItem();
                          },
                          color: Colors.red,
                          icon: Icon(Icons.delete),
                          iconSize: 20,
                        ),
                      )
                    ],
                  ),
                  Row(
                    children: <Widget>[
                      Text("${AppLocalizations.of(context).translate('Price')}: "),
                      SizedBox(
                        width: 5,
                      ),
                      Text(
                        '\$ ${product.salePrice}',
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w300),
                      )
                    ],
                  ),
                  Row(
                    children: <Widget>[
                      Text("${AppLocalizations.of(context).translate('SubTotal')}: "),
                      SizedBox(
                        width: 5,
                      ),
                      Text('\$ $itemTotal',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w300,
                            color: Colors.orange,
                          ))
                    ],
                  ),
                  Row(
                    children: <Widget>[
                      Text(
                        "${AppLocalizations.of(context).translate('ShipsFree')}",
                        style: TextStyle(color: Colors.orange),
                      ),
                      Spacer(),
                      Row(
                        children: <Widget>[
                          InkWell(
                            onTap: () {
                              minus();
                            },
                            splashColor: Colors.redAccent.shade200,
                            child: Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(50)),
                              alignment: Alignment.center,
                              child: Padding(
                                padding: const EdgeInsets.all(6.0),
                                child: Icon(
                                  Icons.remove,
                                  color: Colors.redAccent,
                                  size: 20,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 4,
                          ),
                          Card(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(product.qTY),
                            ),
                          ),
                          SizedBox(
                            width: 4,
                          ),
                          InkWell(
                            onTap: () {
                              add();
                            },
                            splashColor: Colors.lightGreen,
                            child: Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(50)),
                              alignment: Alignment.center,
                              child: Padding(
                                padding: const EdgeInsets.all(6.0),
                                child: Icon(
                                  Icons.add,
                                  color: Colors.green,
                                  size: 20,
                                ),
                              ),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _checkoutSection() {
    return GestureDetector(
      onTap: () {
        setState(() {
          selected = !selected;
        });
      },
      child: AnimatedContainer(
        duration: Duration(seconds: 1),
        height: selected ?  MediaQuery.of(context).size.height-200 : 150.0,
        alignment: selected ? Alignment.center : AlignmentDirectional.center,
        curve: Curves.fastOutSlowIn,
        decoration: BoxDecoration(
          borderRadius:  BorderRadius.only(topRight:  Radius.circular(40),topLeft:  Radius.circular(40)),
          color: selected ? Colors.white : Colors.black12,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(left: 20.0, right: 20.0, top: 15.0),
              child: Column(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(bottom: 20.0),
                    child: Row(
                      children: <Widget>[
                        Expanded(
                          child: Text(
                            "${AppLocalizations.of(context).translate('TOTAL')}",
                            style: TextStyle(fontSize: 16, color: Colors.grey),
                          ),
                        ),
                        Text("\$ $voucherTotal",
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold)),
                      ],
                    ),
                  ),
                  Visibility(
                    visible: selected,

                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 15.0),
                      child: Row(
                        children: <Widget>[
                          Expanded(
                              child: Text("${AppLocalizations.of(context).translate('TaxAmount')}",
                                  style: TextStyle(fontSize: 14))),
                          Text("\$ 400",
                              style: TextStyle(fontSize: 14, color: Colors.grey)),
                        ],
                      ),
                    ),
                  ),
                  Visibility(
                    visible: selected,
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 15.0),
                      child: Row(
                        children: <Widget>[
                          Expanded(
                              child: Text("${AppLocalizations.of(context).translate('DiscountTotal')}",
                                  style: TextStyle(fontSize: 14))),
                          Text("\$ 3000",
                              style: TextStyle(fontSize: 14, color: Colors.grey)),
                        ],
                      ),
                    ),
                  ),
                  Visibility(
                    visible: selected,
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 15.0),
                      child: Row(
                        children: <Widget>[
                          Expanded(
                              child: Text("${AppLocalizations.of(context).translate('AfterDiscount')}",
                                  style: TextStyle(fontSize: 14))),
                          Text("\$ 20000",
                              style: TextStyle(fontSize: 14, color: Colors.grey)),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 10.0, bottom: 10.0),
                    child: Material(
                      color: Theme
                          .of(context)
                          .primaryColor,
                      elevation: 3.0,
                      child: InkWell(
                        splashColor: Theme
                            .of(context)
                            .primaryColor,
                        onTap: () {
                          checkOut();
                        },
                        child: Container(
                          width: double.infinity,
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Text(
                              "${AppLocalizations.of(context).translate('Checkout')}",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                  fontWeight: FontWeight.w700),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class RoundedContainer extends StatelessWidget {
  const RoundedContainer({
    Key key,
    @required this.child,
    this.height,
    this.width,
    this.color = Colors.white,
    this.padding = const EdgeInsets.all(16.0),
    this.margin,
    this.borderRadius,
    this.alignment,
    this.elevation,
  }) : super(key: key);
  final Widget child;
  final double width;
  final double height;
  final Color color;
  final EdgeInsets padding;
  final EdgeInsets margin;
  final BorderRadius borderRadius;
  final AlignmentGeometry alignment;
  final double elevation;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: margin ?? const EdgeInsets.all(0),
      color: color,
      elevation: elevation ?? 0,
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(
        borderRadius: borderRadius ?? BorderRadius.circular(20.0),
      ),
      child: Container(
        alignment: alignment,
        height: height,
        width: width,
        padding: padding,
        child: child,
      ),
    );
  }
}
