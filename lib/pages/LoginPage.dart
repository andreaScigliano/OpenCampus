import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'HomePage.dart';

/**
 * Author : Andrea scigliano
 * version : 7/4/2020
 * pagina di login
 */
class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool _isLoading = false;
  final _formKey = GlobalKey<FormState>();


  @override
  Widget build(BuildContext context) {
    double altezza = MediaQuery.of(context).size.height;
    double larghezza = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Scaffold(
        body: Container(
          height: altezza,
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.centerRight,
                  colors: [
                Color.fromRGBO(100, 179, 244, 1),
                Color.fromRGBO(24, 90, 157, 1),
              ])),
          child: SingleChildScrollView(
              child: _isLoading ? _loadingPage(altezza) : _contentLogin(altezza,larghezza)),
        ),
      ),
    );
  }
  /**
   * componente pagina login
   */
  Widget _contentLogin(double altezza,double larghezza) {
    return Center(
      child: Column(
        children: <Widget>[
          SizedBox(height: 50),
          Container(
            child: Image.asset('assets/open.png'),
          ),
          _inputContainter(altezza,larghezza),
        ],
      ),
    );
  }
/**
 * componente caricamento circolare
 */
  Widget _loadingPage(double altezza) {
    return Padding(
      padding: EdgeInsets.only(top: altezza * .40),
      child: Center(
        child: CircularProgressIndicator(backgroundColor: Colors.white70),
      ),
    );
  }
/**
 * componente container caselle di testo
 */
  Widget _inputContainter(double altezza,double larghezza) {
    return Container(
        height: altezza * .6,
        width: larghezza * .9,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: Color.fromRGBO(255, 255, 255, .65)),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(left: 35.0, top: 10),
                child: Text(
                  "Accedi",
                  style: TextStyle(
                      height: 2, fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(height: 20),
              inputselection("Email", Icons.email),
              SizedBox(height: 40),
              inputselection("Password", Icons.lock),
              SizedBox(height: 10),
              _loginButton(),
            ],
          ),
        ));
  }

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

/**
 * componente casella di testo
 */
  Widget inputselection(String title, IconData icon) {
    bool nameField = title == "Password";
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: TextFormField(
        controller: nameField ? passwordController : emailController,
        obscureText: nameField,
        validator: (String value) {
          String placeHolder;
          /*
          controllo sul input se il valore dei campi è vuotp
          */
          if (value.isEmpty) {
            placeHolder='riempire il campo';
          }
          return placeHolder;
        },
        
        style: TextStyle(color: Colors.white70),
        decoration: InputDecoration(
          labelText: title,
            hintStyle: TextStyle(color: Colors.black),
            icon: Icon(icon)),
      ),
    );
  }

  /*
  logica per l accesso non ancora implementata
  */
  Future accesso(String email, String password) async {
    /*
    http.Response response = await http.get("http://10.0.2.2:5000/books");
    String content = response.body;
    print(content);
    */
    
    Map data = {'email': email, 'password': password};
    var jsonData = null;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var response = await http.post("http://10.0.2.2:5000/login", body: data);
    print(data);
    if (response.statusCode == 200) {
      List jsonData = json.decode(response.body);
      print(jsonData);
      
      setState(() {
        _isLoading = false;
        //prefs.setString("token", jsonData['token']);
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (BuildContext context) => HomePage()),
            (Route<dynamic> route) => false);
      });
      
    } else {
      print(response.body);
    }
    
  }

/**
 * componente bottone login
 */
  Widget _loginButton() {
    return Container(
      child: Center(
        child: RawMaterialButton(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          padding: EdgeInsets.symmetric(horizontal: 90, vertical: 18),
          onPressed: () {
              setState(() {
                if (!_formKey.currentState.validate()) {
                  return;
                }
                  _isLoading = true;
              });
              Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (BuildContext context) => HomePage()),
            (Route<dynamic> route) => false);
              //accesso(emailController.text, passwordController.text);
          },
          fillColor: Color.fromRGBO(51, 166, 226, 32),
          child: Text("ACCEDI",
              style: TextStyle(
                  color: Colors.white70,
                  fontSize: 15,
                  fontWeight: FontWeight.bold)),
        ),
      ),
    );
  }
}

