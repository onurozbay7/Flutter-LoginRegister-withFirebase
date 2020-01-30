import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Hosgeldin extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return HosgeldinFonksiyon();
  }
}

class HosgeldinFonksiyon extends State<Hosgeldin> {

  final Firestore firestore = Firestore.instance;


  String girilenMetin="";
  void yaziDegis(yeni){
    setState(() {
      girilenMetin = yeni;
    });
  }


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: Text("Anasayfa"),
          backgroundColor: Colors.pink,
        ),

        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              children: <Widget>[

                RaisedButton(

                  child: Text("Veri Ekleme"),
                  onPressed: (){
                    Map<String, dynamic> veriEkle = Map();
                    veriEkle["isim"] = "onur";
                    veriEkle["yas"] = "22";

                    firestore.collection("users").document("ogrenci").setData(veriEkle);
                  },

                ),

                RaisedButton(
                  child: Text("Veri Silme"),
                   onPressed: (){

                   firestore.document("users/ogrenci").delete();
                   firestore.document("users/ogretmen").updateData({"isim" : FieldValue.delete()});
                   },

                ),

                RaisedButton(
                  child: Text("Veri güncelleme"),
                  onPressed: (){

                    firestore.document("users/ogrenci").updateData({
                      "isim": "onur"
                    });
                  },

                ),

                RaisedButton(
                  child: Text("Veri Okuma"),
                  onPressed: (){
                    veriOkuma();

                  },

                ),

              ],
            ),
          ),
        ),
      ),
    );
  }

  Future veriOkuma() async{

      DocumentSnapshot documentSnapshot = await firestore.document("users/ogrenci").get();
      debugPrint("Ogrenci ismi:" + documentSnapshot.data["isim"].toString());

      debugPrint("Ogrenci yaşı:" + documentSnapshot.data["yas"].toString());




  }
}