import 'dart:convert';

import "package:flutter/material.dart";
import 'package:stores_app/Controller/FetchData.dart';
import 'package:stores_app/Module/UserAuth.dart';

import '../app_localizations.dart';

class Auth extends StatelessWidget{

  BoxDecoration decoration = BoxDecoration(
      border: Border(
          bottom: BorderSide(
              color: Colors.lightGreen[700],
              width: 1.0
          )
      )
  );

  TextStyle CustomTextStyle(){
    return TextStyle(
        color: Colors.white,
        fontSize: 15.0
    );
  }

  Widget CustomSizeBox({double height}){
    return SizedBox(
      height:height,
    );
  }

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _autoValidate = false;

  FocusNode emailNode = FocusNode();
  FocusNode passawordNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return  GestureDetector(
      onTap:()=> FocusScope.of(context).requestFocus(new FocusNode()),
      child:Scaffold(
          backgroundColor: Colors.white,
          body: SingleChildScrollView(
              child: LoginPage()
          )
      ),
    );
  }
}

class LoginPage extends StatefulWidget{
  createState() => LoginState();
}

class LoginState extends State<LoginPage>{

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final userNo = TextEditingController();
  final key = TextEditingController();
  bool _autoValidate = false;
  bool loading = false;
  FocusNode emailNode;
  FocusNode passawordNode;
  List<UserAuth> _userAuth;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    passawordNode = FocusNode();
    emailNode = FocusNode();
    loading = false;

  }

  void checkAuth(userNo , key){
    API.setUserAuth(userNo, key).then((response) {
      setState(() {
        Iterable list = json.decode(response.body);
        _userAuth = list.map((model) => UserAuth.fromJson(model)).toList();
        if(_userAuth[0].uSERNO == userNo) {
          API.serialNo = _userAuth[0].sERIAL;
          API.userNo = _userAuth[0].uSERNO;
          print(_userAuth[0].uSERNO);
          print(_userAuth[0].sERIAL);
          print("valid ");
          Navigator.pushReplacementNamed(context,"/home");
        }
        else{
          print("unvalid ");
        }
      });
    });
  }

  BoxDecoration decoration = BoxDecoration(
      border: Border(
          bottom: BorderSide(
              color: Colors.lightGreen[700],
              width: 1.0
          )
      )
  );

  TextStyle CustomTextStyle(){
    return TextStyle(
        color: Colors.black,
        fontSize: 15.0
    );
  }

  InputDecoration CustomTextDecoration({String text,IconData icon}){
    return InputDecoration(
      labelStyle: TextStyle(
          color: Colors.black
      ),
      labelText: text,
      prefixIcon: Icon(icon,color: Colors.lightGreen[700]),
      enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(
              color: Colors.lightGreen[700]
          )
      ),
      focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(
              color: Colors.lightGreen[700]
          )
      ),
      errorBorder: UnderlineInputBorder(
          borderSide: BorderSide(
              color: Colors.lightGreen[700]
          )
      ),
    );
  }

  Widget CustomSizeBox({double height}){
    return SizedBox(
      height:height,
    );
  }

  // ignore: non_constant_identifier_names
  Widget LoginButton(BuildContext context){
    return new SizedBox(
      height: 45.0,
      width:  MediaQuery.of(context).size.height /6,
      child: new RaisedButton(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(18.0),
            side: BorderSide(color: Colors.lightGreen)
        ),
        color: Colors.lightGreen,
        child: Text("${AppLocalizations.of(context).translate('Login')}",style:TextStyle(color: Colors.white),),
        onPressed: (){
          FocusScope.of(context).requestFocus(new FocusNode());
          if(_formKey.currentState.validate()){
            setState(() {
              loading = true;
            });
            Future.delayed(Duration(seconds: 2),(){
              setState(() {
                loading = false;
              });
              checkAuth(userNo.text , key.text);
            });
          }else{
            setState(() {
              _autoValidate = true;
            });
          }
        },
      ),
    );
  }

  // ignore: non_constant_identifier_names
  Widget LoginUi(){
    return Form(
      key: _formKey,
      // ignore: deprecated_member_use
      autovalidate: _autoValidate,
      child: Column(
        children: <Widget>[
          CustomSizeBox(height: 80.0),
          Container(
            height: 200.0,
            child: Image.asset("assets/images/hello.gif"),
          ),
          CustomSizeBox(height: 20.0),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 40.0 , vertical: 20.0),
            margin: EdgeInsets.only(left: 40, top: 100, right: 40, bottom: 50),
            decoration:BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(10),
                  topRight: Radius.circular(10),
                  bottomLeft: Radius.circular(10),
                  bottomRight: Radius.circular(10)
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 5,
                  blurRadius: 7,
                  offset: Offset(0, 3), // changes position of shadow
                ),
              ],
            ),
            child:Column(
              children: <Widget>[
                // Container(
                //     // decoration: decoration
                // ),
                TextFormField(
                  controller: userNo,
                  enabled: true,
                  enableInteractiveSelection: true,
                  focusNode: emailNode,
                  style: CustomTextStyle(),
                  keyboardType: TextInputType.emailAddress,
                  textInputAction:TextInputAction.next,
                  decoration: CustomTextDecoration(icon: Icons.person,text:"${AppLocalizations.of(context).translate('Username')}"),
                  textCapitalization: TextCapitalization.none,
                  onFieldSubmitted: (term){
                    emailNode.unfocus();
                    FocusScope.of(context).requestFocus(passawordNode);
                  },
                  // ignore: missing_return
                  validator: (value){
                    if (value.isEmpty) {
                      return "${AppLocalizations.of(context).translate('UsernamePlease')}";
                    }
                    // else if(!new  RegExp(r"^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(value)){
                    //   return "Plase enter valid email";
                    // }
                  },
                ),
                TextFormField(
                  controller: key,
                  enabled: true,
                  enableInteractiveSelection: true,
                  obscureText: true,
                  textInputAction:TextInputAction.done,
                  style: CustomTextStyle(),
                  focusNode: passawordNode,
                //       : InputDecoration(
                // hintText: 'Enter Key',
                // labelText: 'Key',
                // ),
                  decoration: CustomTextDecoration(icon: Icons.lock,text: "${AppLocalizations.of(context).translate('Key')}"),
                  // ignore: missing_return
                  validator: (value){
                    if (value.isEmpty) {
                      return "${AppLocalizations.of(context).translate('KeyPlease')}";
                    }
                    // else if(value.length < 6){
                    //   return 'Password must be 6 digit';
                    // }
                  },
                ),
                CustomSizeBox(height: 20.0),
              ],
            ),
          ),
          LoginButton(context),
          CustomSizeBox(
              height: 30.0
          ),
        ],
      ),
    );
  }


  Widget LoadingIndicator(){
    return Positioned(
      child: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        color: Colors.white12,
        child: Center(
          child: SizedBox(
            height: 50.0,
            width: 50.0,
            child: CircularProgressIndicator(
                strokeWidth:0.7
            ),
          ),
        ),
      ),
    );
  }



  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Stack(
      children: <Widget>[
        LoginUi(),
        loading ? LoadingIndicator() : Container()
      ],
    );
  }
}



// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:rflutter_alert/rflutter_alert.dart';
// import 'package:loading_animations/loading_animations.dart';
//
// class Auth extends StatefulWidget {
//   @override
//   _AuthState createState() => _AuthState();
// }
//
// final _formKey = GlobalKey<FormState>();
//
// class _AuthState extends State<Auth> {
//
//   Widget login = Text('Sign In');
//   double widthButtonSign = double.infinity;
//   void notificationScssfully(context){
//     Alert(
//       context: context,
//       title: "Successfully",
//       desc: "Successfully Login.. Welcome",
//       // image: Image.asset("assets/images/success.png"),
//       buttons: [ DialogButton(
//         child: Text(
//           "OK",
//           style: TextStyle(color: Colors.white, fontSize: 20),
//         ),
//         onPressed: () {
//           Navigator.pop(context);
//         },
//         width: 120,
//       ),
//       ],
//     ).show();
//   }
//
//
//   @override
//   Widget build(BuildContext context) {
//
//     return Scaffold(
//       body: Center(
//         child: Form(
//           key: _formKey,
//           child: SingleChildScrollView(
//             child: Padding(
//               padding: const EdgeInsets.only(left: 15.0, right: 15.0),
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: <Widget>[
//                   Padding(
//                     padding: const EdgeInsets.only(bottom: 12.0),
//                     child: TextFormField(
//                       keyboardType: TextInputType.name,
//                       validator: (value) {
//                         if (value.isEmpty) {
//                           return 'Please Enter User Name';
//                         }
//                         return null;
//                       },
//                       onSaved: (value) {
//                         setState(() {
//
//                         });
//                       },
//                       decoration: InputDecoration(
//                         hintText: 'Enter UserName',
//                         labelText: 'UserName',
//                       ),
//                     ),
//                   ),
//                   TextFormField(
//                     validator: (value) {
//                       if (value.isEmpty) {
//                         return 'Please Enter Key';
//                       }
//                       return null;
//                     },
//                     onSaved: (value) {
//                       setState(() {
//
//                       });
//                     },
//                     decoration: InputDecoration(
//                       hintText: 'Enter Key',
//                       labelText: 'Key',
//                     ),
//                     obscureText: true,
//                   ),
//                   Padding(
//                     padding: const EdgeInsets.only(top: 25.0),
//                     child: SizedBox(
//                       width: widthButtonSign,
//                       height: 50,
//                       child:  RaisedButton(
//                             color: Theme.of(context).primaryColor,
//                             textColor: Colors.white,
//                             child: login ,
//                             onPressed: () {
//                               setState(() {
//                                 widthButtonSign = double.infinity/2;
//                                 login = LoadingBouncingGrid.square(
//                                   backgroundColor: Colors.white,
//                                   size: 40,
//                                 );
//                                 });
//                               Navigator.pop(context);
//                               // notificationScssfully(context);
//                             }
//                           ),
//                     ),
//                   )
//                 ],
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
