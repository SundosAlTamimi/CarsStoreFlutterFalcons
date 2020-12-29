import 'dart:convert';
import 'dart:developer';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:delayed_display/delayed_display.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:stores_app/Controller/FetchData.dart';
import 'package:stores_app/Module/ItemCode.dart';
import 'package:stores_app/Module/UsersStores.dart';

import '../app_localizations.dart';

class SaleInv extends StatefulWidget {
  @override
  SaleInvState createState() => SaleInvState.j();
}
final _formKey = GlobalKey<FormState>();

class SaleInvState extends State<SaleInv> {
  SaleInvState.j();
  SaleInvState(String barCode , BuildContext context){
    log("in SaleInvState const");
    getItemByBarcode(barCode, context );
  }

  static double voucherTotal = 0;
  final barCode = TextEditingController();
  bool resultScan = false;
  bool containValue = false;
  ItemCode itemCode = new ItemCode() ;
  List<TextEditingController> qty = new List<TextEditingController>();
  List<String> barCodeList = new List<String>();
  List<ItemCode> listItemsCode = new List<ItemCode>();
//AppLocalizations.of(context).translate('Barcode')
  static void notificationFail(context){
    Alert(
      context: context,
      title: AppLocalizations.of(context).translate('Sorry'),
      desc: AppLocalizations.of(context).translate('SorryDetails'),
      buttons: [ DialogButton(
        color: Colors.lightGreen,
        child: Text(
          "${AppLocalizations.of(context).translate('Cancel')}",
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

  static void notificationSuccessfully(context){
    Alert(
      context: context,
      image: Image.asset("assets/images/success.png" , width: 50 , height: 50,),
      title: AppLocalizations.of(context).translate('SuccessfullyAdded'),
      desc:  AppLocalizations.of(context).translate('SuccessfullyAddedDetails'),
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

  void getItemByBarcode(String barCode , BuildContext context){
    List<ItemCode> itemsCode ;
    API.getItemByBarcode(barCode).then((response) {
        if(response.body.isNotEmpty) {
          Iterable list = json.decode(response.body);
          itemsCode = list.map((model) => ItemCode.fromJson(model)).toList();
          if (itemsCode.length != 0) {
            itemCode = itemsCode[0];
            itemCode.vOHTYPE = "0";
            itemCode.uSERNO = API.userNo;
            itemCode.uSERNOSERIAL = API.serialNo;
            if (itemCode != null && ! barCodeList.contains(itemCode.itemOCode)) {
              notContainsItem();
            }
            else{
              containsItem();
            }
            log("valid");
          }
          else {
            notificationFail(context);
          }
        }
    });
  }

  void addVoucher (String jsonUserStore){
    // API.addVoucher(jsonUserStore).then((response) {
    //   if(response.statusCode == 200) {
    //       notificationSuccessfully(context);
    //       print("response.body = ${response.body.toString()}");
    //   }
    // });
  }

  void notContainsItem(){
    setState(() {
      listItemsCode.add(itemCode);
      barCodeList.add(itemCode.itemOCode);
      final qtyItem = TextEditingController();
      qtyItem.text = "1";
      qty.add(qtyItem);
      itemCode.qTY = "1";
      log("itemCode.qTY "+itemCode.qTY);
      itemCode.iTEMTOTAL = ItemTotal();
      containValue = true;
      log("containValue = true");
    });
  }

  void containsItem(){
    setState(() {
      log("containValue = false");
      containValue = false;
      print("listItemsCode = ${listItemsCode[0].itemOCode}");
      int index = barCodeList.indexOf(itemCode.itemOCode);
      log(qty[index].text);
      qty[index].text = parseIntQty(index) ;
      itemCode.qTY = qty[index].text;
      itemCode.iTEMTOTAL = ItemTotal();
      log("itemCode.qTY $index "+itemCode.qTY);
      log(qty[index].text);
      listItemsCode.removeAt(index);
      listItemsCode.insert(index, itemCode);
    });
  }

  void addVoucherTotal(){
    setState(() {
      for(int i = 0; i < listItemsCode.length ; i++){
        voucherTotal += double.parse(listItemsCode[i].iTEMTOTAL);
      }
      for(int i = 0; i < listItemsCode.length ; i++)
        listItemsCode[i].vOHTOTAL =  voucherTotal.toString();
    });
  }

  String ItemTotal(){
    int qty = int.parse(itemCode.qTY);
    log("itemCode.qTY "+itemCode.qTY);
    double salesPrice = double.parse(itemCode.salePrice);
    double total = qty * salesPrice;
    log(total.toString());
    return total.toString();
  }

  String parseIntQty(int index) {
    int value = int.parse(qty[index].text);
    value++;
    return value.toString();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Form(
            key: _formKey,
            child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.only(left: 15.0, right: 15.0),
                  child: Column(
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.only(top: 15.0, bottom: 15.0),
                          child: Flex(
                              direction: Axis.horizontal,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                SizedBox(
                                  width: 200,
                                  child: TextField(
                                    controller: barCode,
                                    decoration: InputDecoration(
                                      border: OutlineInputBorder(),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: FlatButton(
                                    child: Icon(Icons.casino_outlined, color: Colors.white),
                                    color: Colors.lightGreen,
                                    textColor: Colors.white,
                                    height: 40,
                                    minWidth: 25,
                                    onPressed: () {
                                      getItemByBarcode(barCode.text , context);
                                    },
                                  ),
                                ),
                              ]),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(30.0),
                          child: Column(
                              children: <Widget>[
                                Row(
                                    mainAxisAlignment: MainAxisAlignment
                                        .spaceBetween,
                                    children: <Widget>[
                                      Expanded(child: Center(child: Text(
                                        "${AppLocalizations.of(context).translate('Num')}" , textScaleFactor: 1.5,))),
                                      Expanded(child: Center(child: Text(
                                          "${AppLocalizations.of(context).translate('Name')}"  , textScaleFactor: 1.5))),
                                      Expanded(child: Center(child: Text(
                                          "${AppLocalizations.of(context).translate('Qty')}" , textScaleFactor: 1.5))),
                                      // Text("",textScaleFactor: 1.5),
                                      Expanded(child: Center(child: Text(
                                          "${AppLocalizations.of(context).translate('delete')}"  , textScaleFactor: 1.5))),
                                    ]
                                ),
                                Divider(
                                    color: Colors.black12
                                ),
                                listViewTable(),
                              ]),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                RaisedButton(
                                  onPressed: () {
                                    setState(() {
                                      qty.clear();
                                      barCodeList.clear();
                                      listItemsCode.clear();
                                    });
                                  },
                                  textColor: Colors.white,
                                  padding: const EdgeInsets.all(0.0),
                                  color: Colors.red,
                                  child: Text("${AppLocalizations.of(context).translate('ClearAll')}", style: TextStyle(
                                      fontSize: 15)),
                                ),
                                RaisedButton(
                                  color: Colors.lightGreen,
                                  onPressed: () {
                                    setState(() {
                                      addVoucherTotal();
                                      ListItemCode listUserStore = new ListItemCode(uSERSTORES: listItemsCode);
                                      String jsonUserStore = jsonEncode(listUserStore);
                                      print(jsonUserStore);
                                      addVoucher(jsonUserStore);
                                    });
                                  },
                                  textColor: Colors.white,
                                  // padding: const EdgeInsets.all(20),
                                  child: Text(
                                      "${AppLocalizations.of(context).translate('Save')}", style: TextStyle(fontSize: 15)),
                                ),
                              ]),
                        ),
                      ]),
                )
            ),
          )),
    );
  }

  Widget listViewTable(){
    var constraints = MediaQuery.of(context).size.height / 2.5;
    if(listItemsCode.isNotEmpty)
      // if(containValue == true)
     return Container(
        height: constraints,
        child: ListView.builder(
          itemCount: listItemsCode?.length ?? 0,
          itemBuilder: (context, index) {
            return createTable(listItemsCode[index],index);
          },
        ),
      );
    else
     return Container(
        height: constraints,
        child: Center(
          child: Text("${AppLocalizations.of(context).translate('NoItem')}"),
        ),
      );
  }

  Widget createTable(ItemCode itemCode,int i){
    log("i = $i");
    return DelayedDisplay(
      delay: Duration(seconds: 1),
      child: Column(
        children: [
          Row(
              mainAxisAlignment: MainAxisAlignment
                  .spaceBetween,
              children: <Widget>[
                Expanded(child: Center(child: Text(
                    itemCode.itemOCode, textScaleFactor: 1.1))),
                Expanded(child: Center(child: Text(
                    itemCode.itemNameE, textScaleFactor: 1.1))),
                Expanded(
                  child: Center(
                    child: SizedBox(
                      width: 60,
                      height: 60,
                      child: TextFormField(
                        // initialValue: qty[i].toString(),
                        // initialValue: "1",
                        style: TextStyle(fontSize: 15),
                        controller: qty[i],
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                        ),
                      ),
                    ),
                  ),
                ),
                Expanded(
                    child: Center(
                        child: IconButton(
                          icon : Icon(
                            Icons.delete_forever, color: Colors.red,
                            size: 28,
                          ),
                          onPressed: () {
                            setState(() {
                              qty.removeAt(i);
                              barCodeList.removeAt(i);
                              listItemsCode.removeAt(i);
                            });
                          },
                        ),
                    ),
                ),
              ]),
          Divider(
              color: Colors.black12
          ),
        ],
      ),
    );
  }


}