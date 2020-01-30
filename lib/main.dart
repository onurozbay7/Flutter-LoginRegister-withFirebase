import 'package:flutter/material.dart';
import 'package:login_ekrani_ornek/hosgeldin.dart';
import 'package:login_ekrani_ornek/register.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return LoginEkrani();
  }
}

class LoginEkrani extends State<MyApp>{
  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}

class HomePage extends StatelessWidget{

  final FirebaseAuth _auth = FirebaseAuth.instance;
  
  final emailController = TextEditingController();
  final parolaController = TextEditingController();

  final snackBar = SnackBar (
    content: Text("Şifre veya Parola yanlış"),
  );
  
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: Text("Login"),
          backgroundColor: Colors.black,
        ),

        body: SingleChildScrollView(
          child: Center(
            child: Column(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: Container(
                    child: Image.network("http://zahidtekbas.com.tr/wp-content/uploads/2019/08/flutterlogo.png"),
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Text("Lütfen giriş yapın"),
                ),

                Padding(
                  padding: const EdgeInsets.only(left:12.0, right: 12.0),
                  child: TextField(
                    keyboardType: TextInputType.emailAddress,
                    maxLines: 1,
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.email, color: Colors.black,),
                      hintText: "E-mail giriniz",
                    ),
                    controller: emailController,
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.only(left:12.0, right: 12.0),
                  child: TextField(
                    keyboardType: TextInputType.text,
                    obscureText: true,
                    maxLines: 1,
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.vpn_key, color: Colors.black,),
                      hintText: "Parolanızı giriniz",
                    ),
                    controller: parolaController,
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.only(top: 35.0),
                  child: RaisedButton(
                    color: Colors.black,
                    child: Text("Login",style: TextStyle(color: Colors.white),),
                    onPressed: (){
                      _auth.signInWithEmailAndPassword(email: emailController.text, password: parolaController.text).then((oturumAcildi){
                        debugPrint("Giriş Başarılı");
                        //Scaffold.of(context).showSnackBar(snackBar);
                        Navigator.push(context,
                        MaterialPageRoute(
                          builder: (context) => Hosgeldin()
                        )
                        );
                      }).catchError((hata) => debugPrint(hata.toString()));

                    },
                  ),
                ),

                RaisedButton(
                    child: Text("Kayıt ol"),
                    color: Colors.red,
                    onPressed: () {
                      Navigator.push(context,
                      MaterialPageRoute(
                       builder: (context) => Register()
                      ),
                      );
                    },

                  ),


              ],
            ),
          ),
        ),
      ),
    );
  }
}