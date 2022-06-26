// PARA GENERAR ESTE CODIGO : statefulW
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_application_1/Screens/home_screen.dart';
import 'package:flutter_application_1/Services/auth_services.dart';
import 'package:flutter_application_1/Services/globals.dart';
import 'package:flutter_application_1/rounded_button.dart';  //IMPORTAR MATERIAL

import 'package:http/http.dart' as http;

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key:key);
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  String _email = '';
  String _password = '';

  loginPressed() async{

    if (_email.isNotEmpty && _password.isNotEmpty) {
      http.Response response = await AuthServices.login(_email, _password);
      Map responseMap = jsonDecode(response.body);
      if(response.statusCode == 200){
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (BuildContext context) => const HomeScreen(),
          )
        );
      }else{
        errorSnackBar(context, responseMap.values.first);
      }
    }else{
        errorSnackBar(context, 'enter all required fields');
    }

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
      backgroundColor: Colors.blue,
      centerTitle: true,
        title: const Text(
        'Login',
          style: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [

            const SizedBox(
              height: 20,
            ),
            TextField(
              decoration: const InputDecoration(
                hintText: 'Ingrese su código rude',
              ),
              onChanged: (value){
                _email = value;
              },
            ),

            const SizedBox(
              height: 30,
            ),
            TextField(
              decoration: const InputDecoration(
                hintText: 'Ingrese su contraseña',
              ),
              onChanged: (value){
                _password = value;
              },
            ),

            const SizedBox(
              height: 30,
            ),
            
            RoundedButton(btnText: 'Ingresar', onBtnPressed: ()=>loginPressed(),)

          ],
        ),
      )
    );
  }
}