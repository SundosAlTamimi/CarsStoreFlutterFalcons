import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:stores_app/Controller/FetchData.dart';
import 'package:stores_app/Module/MyOrdersDetailsModule.dart';
import '../app_localizations.dart';

// ignore: must_be_immutable
class MyOrdersDetails extends StatefulWidget {
  String vouchNo;
  MyOrdersDetails({this.vouchNo});
  MyOrdersDetails.c();
  @override
  _MyOrdersDetailsState createState() => _MyOrdersDetailsState(vouchNo);
}
enum StatesOrder { approved , waiting , rejected , all}

class _MyOrdersDetailsState extends State<MyOrdersDetails> {
  var orders = new List<MyOrdersDetailsModule>();
  String vouchNo;
  StatesOrder active = StatesOrder.waiting;
  List<Color> colorStates = new List<Color>();
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  List<MyOrdersDetailsModule> userStore = new List<MyOrdersDetailsModule>() ;

  _MyOrdersDetailsState(this.vouchNo);

  getMyOrderDetails(String state) async{
    await API.getMyOrderDetails(vouchNo,state).then((response) {
      setState(() {
        userStore = response;
        for(int i=0 ; i< userStore.length ; i++)
          colorStates.add(Colors.white);
        print(" userStore = $userStore");
      });
    });
  }

  @override
  void initState() {
    getMyOrderDetails("-1");
    super.initState();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context).translate('OrderDetails'),),
      ),
      body: Scaffold(
        key: scaffoldKey,
        body: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            filterStates(),
            if(userStore.isNotEmpty)
            Center(
              child: getSnapshot(userStore)
            ),
          ],
        ),
      ),
    );
  }

  Widget filterStates() {
    return Padding(
      padding: const EdgeInsets.only(left:8.0 , right: 8.0),
      child: Column(
        children: [
          Row(
            mainAxisAlignment:MainAxisAlignment.spaceAround ,
            children: [
              Expanded(
                child: Row(
                    children: [
                      Radio(
                        activeColor:Colors.lightGreen ,
                        value: StatesOrder.all,
                        groupValue: active,
                        onChanged: (StatesOrder value) {
                          setState(() {
                            active = value;
                          });
                        },
                      ),
                      Text("${AppLocalizations.of(context).translate('All')}",  style: TextStyle(fontSize: 10)),
                    ]),
              ),
              Expanded(
                child: Row(
                    children: [
                      Radio(
                        activeColor:Colors.lightGreen ,
                        value: StatesOrder.approved,
                        groupValue: active,
                        onChanged: (StatesOrder value) {
                          setState(() {
                            active = value;
                          });
                        },
                      ),
                      Text("${AppLocalizations.of(context).translate('approved')}",  style: TextStyle(fontSize: 10)),
                ]),
              ),
            ],
          ),
          Row(
            mainAxisAlignment:MainAxisAlignment.spaceAround ,
            children: [
              Expanded(
                child: Row(
                    children: [
                      Radio(
                        activeColor:Colors.lightGreen ,
                        value: StatesOrder.waiting,
                        groupValue: active,
                        onChanged: (StatesOrder value) {
                          setState(() {
                            active = value;
                          });
                        },
                      ),
                      Text("${AppLocalizations.of(context).translate('waiting')}" , style: TextStyle(fontSize: 10),),
                    ]),
              ),
              Expanded(
                child: Row(
                    children: [
                      Radio(
                        activeColor:Colors.lightGreen ,
                        value: StatesOrder.rejected,
                        groupValue: active,
                        onChanged: (StatesOrder value) {
                          setState(() {
                            active = value;
                          });
                        },
                      ),
                      Text("${AppLocalizations.of(context).translate('rejected')}", style: TextStyle(fontSize: 10)),
                    ]),
              ),
            ],
          ),
          RaisedButton(
            onPressed: () {
              String i;
              if(active == StatesOrder.approved)
                i = "1";
              else if(active == StatesOrder.rejected)
                i = "2";
              else if(active == StatesOrder.waiting)
                i = "0";
              else if(active == StatesOrder.all)
                i = "-1";
              getMyOrderDetails(i);
            }, // Refer step 3
            child: Text(
             " ${AppLocalizations.of(context).translate('FilteStates')}",
              style:
              TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
            ),
            color: Colors.lightGreen,
          ),
        ],
      ),
    );
  }

  Widget getSnapshot(List<MyOrdersDetailsModule> myOrders) {
    return Container(
      height: MediaQuery.of(context).size.height /2,
      margin: EdgeInsets.symmetric(horizontal: 28.0 , vertical: 5.0 ),
      child: ListView.builder(
        // controller: _controller,
        physics: const AlwaysScrollableScrollPhysics(),
        itemCount: myOrders?.length ?? 0,
        // itemExtent: 170.0,
        shrinkWrap: true,
        itemBuilder: (context, index) {
          return buildItemOrder(myOrders[index],context,index);
        },
      ),
    );
  }

  Widget buildItemOrder(MyOrdersDetailsModule product , context , int index) {
    print(product.oRDERSTATE);
    if(product.oRDERSTATE == "1") {
      product.oRDERSTATE = "1";
      colorStates[index] = Colors.lightGreen;
    }
    else if(product.oRDERSTATE == "2") {
      product.oRDERSTATE = "2";
      colorStates[index] = Colors.red;
    }

    return Container(
      padding: const EdgeInsets.all(0),
      margin: EdgeInsets.all(10),
      // borderRadius: BorderRadius(c),
      decoration:BoxDecoration(
        // border: Border.all(color: Colors.lightGreen),
        color: Colors.white,
        borderRadius: BorderRadius.circular(7.0),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: colorStates[index],
            offset: Offset(1.0, 15.0),
            blurRadius: 20.0,
          ),
        ],
      ),
      height: 130,
      child: Row(
        children: <Widget>[
          Container(
            // decoration:BoxDecoration(
            //   color: Colors.white,
            //   borderRadius: BorderRadius.circular(7.0),
            // ),
            width: 120,
            height: 130,
            child: ClipRRect(
              borderRadius: BorderRadius.only(bottomLeft:Radius.circular(7.0), topLeft:Radius.circular(7.0) ),
              child: Ink(
                child:  new Image.asset('assets/images/car.jpg',  fit: BoxFit.cover , ),
                // child: new Image.memory(bytes[index], fit: BoxFit.cover),
              ),
            ),
          ),
          Flexible(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Column(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(top:12.0 , bottom: 8.0),
                    child: Text(
                      product.iTEMNAMEE,
                      textAlign: TextAlign.left,
                      style: TextStyle(
                          fontWeight: FontWeight.w600, fontSize: 15),
                    ),
                  ),
                  Row(
                    children: <Widget>[
                      Text("${AppLocalizations.of(context).translate('Price')}: "),
                      SizedBox(
                        width: 5,
                      ),
                      Text(
                        '\$ ${product.sALESPRICE}',
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
                      Text('\$ ${product.iTEMTOTAL}',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w300,
                            color: Colors.orange,
                          ))
                    ],
                  ),
                  Row(
                    children: <Widget>[
                      Text("${AppLocalizations.of(context).translate('States')}: "),
                      SizedBox(
                        width: 5,
                      ),
                      Text('${product.oRDERSTATE}',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w300,
                            color: Colors.black,
                          ))
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
