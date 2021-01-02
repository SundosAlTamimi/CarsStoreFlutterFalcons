import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:stores_app/Controller/FetchData.dart';
import 'package:stores_app/Module/MyOrdersModule.dart';
import 'package:stores_app/View/MyOrdersDetails.dart';
import '../app_localizations.dart';

class MyOrders extends StatefulWidget {
  @override
  _MyOrdersState createState() => _MyOrdersState();
}
var run = true;

class _MyOrdersState extends State<MyOrders> {
  var orders = new List<MyOrdersModule>();
  DateTime selectedDateFrom = DateTime.now();
  DateTime selectedDateTo = DateTime.now();
  var listOrdersStoreItems = new Map<String, MyOrdersModule>();
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  _selectDateFrom(BuildContext context) async {
    final DateTime picked = await showDatePicker(
      context: context,
      initialDate: selectedDateFrom, // Refer step 1
      firstDate: DateTime(2000),
      lastDate: DateTime(2025),
    );
    if (picked != null && picked != selectedDateFrom)
      setState(() {
        selectedDateFrom = picked;
      });
  }

  _selectDateTo(BuildContext context) async {
    final DateTime picked = await showDatePicker(
      context: context,
      initialDate: selectedDateTo, // Refer step 1
      firstDate: DateTime(2000),
      lastDate: DateTime(2025),
    );
    if (picked != null && picked != selectedDateTo)
      setState(() {
        selectedDateTo = picked;
      });
  }

  getMyOrderStoreDetails(dataFrom , dataTo) async{
    await API.getMyOrders(dataFrom , dataTo).then((response) {
      setState(() {
        orders = response;
        orders.forEach((customer) => listOrdersStoreItems[customer.vOHNO] = customer);
        print(listOrdersStoreItems);
        orders.clear();
        listOrdersStoreItems.forEach((k, v) => orders.add(v));
        print(" userStore = $orders");
      });
    });
  }

  @override
  void initState() {
    DateTime today = new DateTime.now();
    String dateSlug ="${today.day.toString().padLeft(2,'0')}/${today.month.toString().padLeft(2,'0')}/${today.year.toString()}";
    print(dateSlug);
    getMyOrderStoreDetails(dateSlug, dateSlug);
    super.initState();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context).translate('MyOrder'),),
      ),
      body: DefaultTabController(
        length: 500,
        child: Scaffold(
          key: scaffoldKey,
          body:Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [Colors.white, Colors.lightGreen[200]]
              ),
            ),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left:8.0 , right: 8.0),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment:MainAxisAlignment.spaceBetween ,
                        children: [
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              Text(
                                "${AppLocalizations.of(context).translate('From')} :",
                                style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                              ),
                              Text(
                                "${selectedDateFrom.toLocal()}".split(' ')[0],
                                style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                              ),
                              IconButton(
                                onPressed: () => _selectDateFrom(context), // Refer step 3
                                icon:Icon(Icons.date_range , color: Colors.lightGreen, )
                              ),
                            ],
                          ),
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              Text(
                                "${AppLocalizations.of(context).translate('To')} :",
                                style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                              ),
                              Text(
                                "${selectedDateTo.toLocal()}".split(' ')[0],
                                style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                              ),
                              IconButton(
                                  onPressed: () => _selectDateTo(context), // Refer step 3
                                  icon:Icon(Icons.date_range , color: Colors.lightGreen, )
                              ),
                            ],
                          ),
                        ],
                      ),
                      RaisedButton(
                        onPressed: () {
                          String from = "${selectedDateFrom.toLocal()}".split(' ')[0];
                          String to = "${selectedDateTo.toLocal()}".split(' ')[0];
                          String dateFrom = DateFormat("dd/MM/yyyy").format(DateTime.parse(from));
                          String dateTo = DateFormat("dd/MM/yyyy").format(DateTime.parse(to));
                          getMyOrderStoreDetails(dateFrom,dateTo);
                        }, // Refer step 3
                        child: Text(
                          "${AppLocalizations.of(context).translate('FilterDate')}",
                          style:
                          TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
                        ),
                        color: Colors.lightGreen,
                      ),
                    ],
                  ),
                ),
                getSnapshot(orders),
              ],
            ),
          )
        ),
      ),
    );
  }

  Widget getSnapshot(List<MyOrdersModule> myOrders) {
    return Container(
      height: MediaQuery.of(context).size.height /1.4,
      margin: EdgeInsets.symmetric(horizontal: 28.0 , vertical: 5.0 ),
      child: ListView.builder(
        physics: const AlwaysScrollableScrollPhysics(),
        itemCount: myOrders?.length ?? 0,
        // itemExtent: 100.0,
        itemBuilder: (context, index) {
          return buildOrders(myOrders[index],context);
        },
      ),
    );
  }

  Widget buildOrders(MyOrdersModule order, BuildContext context) {
    TextStyle priceTextStyle = TextStyle(
        color: Colors.lightGreen, fontSize: 15, fontWeight: FontWeight.bold);
    return Builder(
        builder: (BuildContext context) {
          return Container(
            width: 400.0,
            height: 130.0,
            child: Padding(
              padding: const EdgeInsets.symmetric(
                  horizontal: 8.0, vertical: 4.0),
              child: Container(
                decoration:BoxDecoration(
                  //border: Border.all(color: Color(0xff940D5A)),
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(7.0),
                  boxShadow: <BoxShadow>[
                    BoxShadow(
                      color: Colors.grey,
                      offset: Offset(1.0, 15.0),
                      blurRadius: 20.0,
                    ),
                  ],
                ),
                child: MaterialButton(
                  padding: const EdgeInsets.all(0),
                  elevation: 0.5,
                  color: Colors.white,
                  clipBehavior: Clip.antiAlias,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  onPressed: () {
                  Navigator.push(
                      context,MaterialPageRoute(builder: (context) => MyOrdersDetails(vouchNo: order.vOHNO)));
                  },
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Padding(
                            padding: const EdgeInsets.only(left:10.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisSize: MainAxisSize.max,
                              children: <Widget>[
                                Row(
                                  children: <Widget>[
                                    Text("${AppLocalizations.of(context).translate('Orderby')} : ",
                                      style: TextStyle(fontSize: 17.0 , fontWeight: FontWeight.bold),),
                                    Text(order.vOHDATE,
                                      style: TextStyle(fontSize: 12.0),),
                                  ],
                                ),
                                new Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Text("${AppLocalizations.of(context).translate('TOTAL')} : " + order.vOHTOTAL,
                                        style: priceTextStyle),
                                    Icon(Icons.arrow_forward_ios, color: Colors.grey, size: 12.0,)
                                  ],),
                                Text("${AppLocalizations.of(context).translate('OrderState')}: ${order.oRDERSTATE}",
                                  style: TextStyle(fontSize: 12.0),),

                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        }
    );
  }

}
