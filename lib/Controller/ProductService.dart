import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:stores_app/Module/UsersStores.dart';
import 'FetchData.dart';

class ProductService{
  static var listCartItems = new Map<String, UsersStores>();
  static var language;
}