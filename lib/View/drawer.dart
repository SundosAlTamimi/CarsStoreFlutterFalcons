import 'package:flutter/material.dart';
import '../app_localizations.dart';

class AppDrawer extends StatefulWidget {
  @override
  AppDrawerState createState() => AppDrawerState();
}

class AppDrawerState extends State<AppDrawer> {
  String logText = '';
  IconData logIcon ;

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
                  'https://cdn.pixabay.com/photo/2018/08/28/12/41/avatar-3637425_960_720.png'),
            ),
            // accountEmail: Text(""),
            accountName: Text("Omar Amarnah"), accountEmail: null,
          ),
        Expanded(
          child: ListView(
            shrinkWrap: true,
            children: <Widget>[
              ListTile(
                leading: Icon(Icons.home, color: Theme
                    .of(context)
                    .accentColor),
                title: Text(AppLocalizations.of(context).translate('Home')),
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
                title: Text(AppLocalizations.of(context).translate('MyOrders')),
                onTap: () {
                  Navigator.pushNamed(context, '/myOrder');
                },
              ),
              ListTile(
                leading: Icon(Icons.article_outlined,
                    color: Theme
                        .of(context)
                        .accentColor),
                title: Text(AppLocalizations.of(context).translate('SalesInvoice')),
                onTap: () {
                  Navigator.pushNamed(context, '/orderSalesInvoice');
                },
              ),
              Divider(),
              ListTile(
                leading: Icon(Icons.g_translate,
                    color: Theme
                        .of(context)
                        .accentColor),
                title: Text(AppLocalizations.of(context).translate('Languages')),
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
