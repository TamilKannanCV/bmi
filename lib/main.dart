import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import './title.dart';

int colorPrimary = 0xFF2ac301;

void main() {
  runApp(MaterialApp(
    theme: ThemeData(primaryColor: Color(colorPrimary)),
    home: MyApp(),
    debugShowCheckedModeBanner: false,
  ));
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    final channel = MethodChannel("android/bmi");
    channel.invokeMethod<bool>("checkUpdate").then((value) {
      if (value == true) {
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text("New version available"),
            content: Text("Latest features are available, Update now"),
            actions: [
              FilledButton(
                onPressed: () {
                  channel.invokeMethod("performImmediateUpdate");
                },
                child: Text("Update now"),
              ),
            ],
          ),
        );
      }
    });
  }

  String condition;
  double _weight = 75;
  double _height = 175;
  int _bmi = 0;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              width: double.infinity,
              height: size.height * 0.4,
              decoration: BoxDecoration(color: Color(colorPrimary)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TitleWidget(),
                  SizedBox(
                    width: double.infinity,
                    child: Container(
                      padding: EdgeInsets.only(right: 10),
                      child: Text(
                        "$_bmi",
                        style: TextStyle(color: Colors.white, fontSize: 45, fontWeight: FontWeight.bold),
                        textAlign: TextAlign.end,
                      ),
                    ),
                  ),
                  SizedBox(
                    width: double.infinity,
                    child: Container(
                        padding: EdgeInsets.only(left: 10),
                        margin: EdgeInsets.only(top: 20),
                        child: Column(
                          children: [
                            ConditionWidget(),
                            RichText(
                              text: TextSpan(
                                text: "$condition",
                                style: TextStyle(fontFamily: 'Poppins', fontSize: 25, fontWeight: FontWeight.bold),
                              ),
                            ),
                          ],
                        )),
                  )
                ],
              ),
            ),
            Container(
              width: double.infinity,
              height: size.height * 0.5,
              decoration: BoxDecoration(color: Colors.white),
              child: Column(
                children: [
                  Container(
                    margin: EdgeInsets.only(top: 15, bottom: 20),
                    child: Text(
                      "Choose data",
                      style: TextStyle(color: Color(colorPrimary), fontSize: 25, fontWeight: FontWeight.bold, fontFamily: 'Poppins'),
                    ),
                  ),
                  Container(
                    child: RichText(
                        text: TextSpan(
                            text: "Weight: ",
                            style: TextStyle(color: Colors.black, fontFamily: 'Poppins', fontWeight: FontWeight.bold, fontSize: 15),
                            children: [TextSpan(text: "$_weight kg", style: TextStyle(fontWeight: FontWeight.normal))])),
                  ),
                  Container(
                    margin: EdgeInsets.only(bottom: 20, top: 10),
                    child: Slider(
                      value: _weight,
                      min: 0.0,
                      max: 300.0,
                      activeColor: Color(colorPrimary),
                      inactiveColor: Colors.grey[50],
                      onChanged: (value) {
                        setState(() {
                          _weight = value.roundToDouble();
                        });
                      },
                    ),
                  ),
                  Container(
                    child: RichText(
                      text: TextSpan(
                        text: "Height: ",
                        style: TextStyle(color: Colors.black, fontFamily: 'Poppins', fontWeight: FontWeight.bold, fontSize: 15),
                        children: [TextSpan(text: "$_height cm", style: TextStyle(fontWeight: FontWeight.normal))],
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(bottom: 0, top: 10),
                    child: Slider(
                      value: _height,
                      min: 5.0,
                      max: 200.0,
                      activeColor: Color(colorPrimary),
                      inactiveColor: Colors.grey[50],
                      onChanged: (value) {
                        setState(() {
                          _height = value.roundToDouble();
                        });
                      },
                    ),
                  )
                ],
              ),
            ),
            Container(
              width: size.width * 0.8,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(50.0),
                child: FilledButton(
                  style: FilledButton.styleFrom(
                    padding: EdgeInsets.all(15),
                    backgroundColor: Color(colorPrimary),
                  ),
                  onPressed: () {
                    setState(() {
                      _bmi = (_weight / ((_height / 100) * (_height / 100))).round().toInt();
                      if (_bmi >= 18.5 && _bmi <= 25) {
                        condition = "Normal";
                      } else if (_bmi > 25 && _bmi <= 30) {
                        condition = "Overweight";
                      } else if (_bmi > 30) {
                        condition = "Obesity";
                      } else {
                        condition = "Underweight";
                      }
                    });
                  },
                  child: Text(
                    "Calculate",
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 20,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class ConditionWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Text(
      "Condition: ",
      style: TextStyle(color: Colors.white, fontSize: 20, fontFamily: 'Poppins'),
    );
  }
}
