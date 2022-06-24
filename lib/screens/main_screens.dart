import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:hava_durumu_2/utils/hava.dart';

class MainScreen extends StatefulWidget {
  final HavaDurumuBilgisi hava_durumu_bilgisi;

  MainScreen({required this.hava_durumu_bilgisi});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  late int temperature;
  late Icon weatherDisplayIcon;
  late AssetImage backgroundImage;
  static const String _title = 'HAVA DURUMU';
  final formKey = GlobalKey<FormState>();
  late String sehirAdi;
  void updateDisplayData(HavaDurumuBilgisi havaDurumuBilgisi) {
    setState(() {
      sehirAdi = havaDurumuBilgisi.sehir;
      temperature = havaDurumuBilgisi.currentTemperature.round();
      WeatherDisplayData weatherDisplayData =
          havaDurumuBilgisi.getWeatherDisplayData();
      backgroundImage = weatherDisplayData.weatherImage;
      weatherDisplayIcon = weatherDisplayData.weatherIcon;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    updateDisplayData(widget.hava_durumu_bilgisi);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          _title,
          style: TextStyle(
            color: Colors.black,
          ),
        ),
      ),
      body: Form(
        key: formKey,
        child: Container(
          constraints: BoxConstraints.expand(),
          decoration: BoxDecoration(
              image: DecorationImage(
            image: backgroundImage,
            fit: BoxFit.cover,
          )),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(
                height: 20,
              ),
              Container(
                child: ListView(children: <Widget>[
                  TextFormField(
                    decoration: InputDecoration(
                        prefixIcon: Icon(FontAwesomeIcons.plus),
                        labelText: "Şehir İsmi Giriniz : ",
                        hintText: "Şehir",
                        labelStyle: TextStyle(
                            color: Colors.black, fontWeight: FontWeight.bold),
                        border: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.black))),
                    validator: (girilenDeger) {
                      if (girilenDeger!.isEmpty) return "Bu Kısım Boş Olamaz !";
                      return null;
                    },
                    onSaved: (girilenDeger) {
                      sehirAdi = girilenDeger!;
                    },
                  ),
                  Row(
                    children: <Widget>[
                      Expanded(
                          child: FlatButton(
                        onPressed: sehirHavaDurumu,
                        child: Text(
                          "Hava Durumu",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 18.0,
                              fontWeight: FontWeight.bold),
                        ),
                        color: Color.fromARGB(255, 12, 99, 170),
                      ))
                    ],
                  )
                ]),
                width: MediaQuery.of(context).size.width,
                height: 150.0,
              ),
              SizedBox(
                height: 40,
              ),
              Container(
                child: weatherDisplayIcon,
              ),
              SizedBox(
                height: 12,
              ),
              Center(
                child: Text(
                  '$sehirAdi '
                  '$temperature°C',
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 60.0,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 0),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  void sehirHavaDurumu() {
    if (formKey.currentState!.validate()) {
      formKey.currentState!.save();
      HavaDurumuBilgisi().sehir = sehirAdi;
    }
    ;
  }
}
