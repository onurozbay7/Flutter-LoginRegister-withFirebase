import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:login_ekrani_ornek/main.dart';

class Register extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return RegisterFonksiyon();
  }



}

class RegisterFonksiyon extends State<Register>{

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final emailController = TextEditingController();
  final parolaController = TextEditingController();
  final parolaEsitController = TextEditingController();


  final _scaffoldKey = GlobalKey<ScaffoldState>();

  final snackBar = SnackBar (
    content: Text("Lütfen parola tekrarını doğru girin"),
  );

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          title: Text("Kayıt ol"),
          backgroundColor: Colors.black,
        ),

        body: Container(

          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Center(
              child: Column(
                children: <Widget>[

                  Padding(
                    padding: const EdgeInsets.only(top: 15.0),
                    child: TextField(
                      keyboardType: TextInputType.emailAddress,
                      maxLines: 1,
                      decoration: InputDecoration(
                        prefixIcon: Icon(Icons.email, color: Colors.black,),
                        hintText: "Email",
                      ),
                      controller: emailController,

                    ),
                  ),

                  Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: TextField(
                      keyboardType: TextInputType.text,
                      maxLines: 1,
                      decoration: InputDecoration(
                        prefixIcon: Icon(Icons.vpn_key, color: Colors.black,),
                        hintText: "Parola",
                      ),
                      controller: parolaController,
                    ),
                  ),

                  Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: TextField(
                      keyboardType: TextInputType.text,
                      maxLines: 1,
                      decoration: InputDecoration(
                        prefixIcon: Icon(Icons.vpn_key, color: Colors.black,),
                        hintText: "Parola (Tekrar)",
                      ),
                      controller: parolaEsitController,

                    ),
                  ),

                  Padding(
                    padding: const EdgeInsets.only(top: 30.0),
                    child: RaisedButton(
                      color: Colors.black,

                      child: Text("Kayıt Ol", style: TextStyle(color: Colors.white),),

                      onPressed: () {

                        if(parolaController.text == parolaEsitController.text){

                          _auth.createUserWithEmailAndPassword(email: emailController.text, password: parolaController.text).catchError((hata) => debugPrint(hata.toString()));
                          Navigator.push(context,
                            MaterialPageRoute(
                                builder: (context) => HomePage()
                            ),
                          );
                        }
                        else {

                          _scaffoldKey.currentState.showSnackBar(SnackBar(
                            content: Text("Parolanızı düzgün girin"),
                            duration: Duration(seconds: 2),
                            action: SnackBarAction(
                              label: "Gizle",
                              onPressed: () {
                              },
                            ),
                          ));

                        }

                      },

                    ),
                  ),


                ],
              ),
            ),
          ),
        ),
      ),
    );
  }


}

