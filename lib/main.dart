import 'package:flutter/material.dart';
import 'package:hava_durumu_2/screens/main_screens.dart';
import 'package:hava_durumu_2/screens/yukleme_ekrani.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData.dark(),
      home: yuklemeEkrani(),
    );
  }
}
