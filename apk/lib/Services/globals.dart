
// import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
// import 'package:flutter/rendering.dart';

const String baseURL = 'http://192.168.0.18/login-flutter/api/public/api/'; //LOCAL HOST WINDOWS

// 10.0.2.2
const Map<String,String> headers = {"Content-Type":"application/json"};
    
errorSnackBar(BuildContext context, String text){
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      backgroundColor: Colors.red,
      content: Text(text),
      duration: const Duration(seconds: 1),
    )
  );
}