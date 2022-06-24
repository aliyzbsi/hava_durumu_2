import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:hava_durumu_2/screens/main_screens.dart';
import 'package:hava_durumu_2/utils/hava.dart';

class yuklemeEkrani extends StatefulWidget {
  @override
  State<yuklemeEkrani> createState() => _yuklemeEkraniState();
}

class _yuklemeEkraniState extends State<yuklemeEkrani> {
  static const String _title = 'Flutter Code Sample';
  void getHavaDurumuBilgisi() async {
    HavaDurumuBilgisi hava_durumu_bilgisi = HavaDurumuBilgisi();
    await hava_durumu_bilgisi.getCurrentTemperature();

    if (hava_durumu_bilgisi.currentTemperature == null ||
        hava_durumu_bilgisi.currentCondition == null) {
      print("Apiden değer gelmiyor 2 ");
    }
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
      return MainScreen(hava_durumu_bilgisi: hava_durumu_bilgisi);
    }));
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    getHavaDurumuBilgisi();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [Colors.red, Colors.white])),
        child: Center(
          child: SpinKitFoldingCube(
            color: Colors.white,
            size: 80.0,
            duration: Duration(milliseconds: 1200),
          ),
        ),
      ),
    );
  }
}
