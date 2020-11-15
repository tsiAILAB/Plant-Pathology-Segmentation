import 'package:flutter/material.dart';
import 'package:tflite_obj_det/main.dart';
import 'package:tflite/tflite.dart';
import 'home.dart';

class LandingPage extends StatefulWidget {
  @override
  _LandingPageState createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {

  String _modelName = "";


  @override
  void initState() {
    super.initState();
  }

  void goToObjectDetectionUi(model) {

    setModel(model);

    Navigator.of(context).push(MaterialPageRoute(
      builder: (context) => HomePage(cameras, _modelName),
    ));
    // Navigator.push(
    //   context,
    //   MaterialPageRoute(
    //       builder: (context) => HomePage(cameras, plantModel)),
    // );
  }

  setModel(model) {
    setState(() {
      _modelName = model;
    });
    loadModel();
  }

  loadModel() async {

    Tflite.close();
    String res;

    switch (_modelName) {
      case "TOMATO":
        res = await Tflite.loadModel(
          // test model
          model: "assets/tomato_ssd_mobilenet_v2_new_final_100.tflite",

          // released model
          // model: "assets/tomato_ssd_mobilenet_v2_new.tflite",

          // previous model
          // model: "assets/tomato_ssd_mobilenet_v2_1.tflite",
          labels: "assets/tomato_ssd_mobilenet_v2_1.txt",
        );
        print("TOMATO MODEL LOADED..............................................!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!");
        break;

      case "POTATO":
        res = await Tflite.loadModel(

          // test_models
            // model: "assets/potato_ssd_mobilenet_v2_new.tflite",
            model: "assets/potato_ssd_mobilenet_v2_new_final_100.tflite",

            // Released Model
            // model: "assets/potato_ssd_mobilenet_v2_1.tflite",
            labels: "assets/potato_ssd_mobilenet_v2.txt"
        );
        print("POTATO MODEL LOADED..............................................!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!");
        break;

      case "MAIZE":
        res = await Tflite.loadModel(

          // test model
            model: "assets/maize_ssd_mobilenet_v2_new_final_100.tflite",

          // Released Model
          //   model: "assets/maize_ssd_mobilenet_v2_new.tflite",
          //   previous model
            // model: "assets/maize_ssd_mobilenet_v2_1.tflite",
            labels: "assets/maize_ssd_mobilenet_v2_1.txt"
        );
        print("MAIZE MODEL LOADED..............................................!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!");
        break;
    }
    print(res);
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("PlantPathology Segmentation"),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: 20),
              Container(
                child: Column(
                  children: <Widget>[
                    FlatButton(
                      onPressed: () {
                        print("I'm Tomato");
                        goToObjectDetectionUi("TOMATO");
                      },
                      child: CircleAvatar(
                        backgroundImage: AssetImage('assets/tomato.jpg'),
                        radius: 60,
                      ),
                    ),
                    Text(
                      "Tomato",
                      style: TextStyle(
                          fontSize: 15.0,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 1.0),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20),
              Container(
                child: Column(
                  children: <Widget>[
                    FlatButton(
                      onPressed: () {
                        print("I'm Potato");
                        goToObjectDetectionUi("POTATO");
                      },
                      child: CircleAvatar(
                        backgroundImage: AssetImage('assets/potato.jpg'),
                        radius: 60,
                      ),
                    ),
                    Text(
                      "Potato",
                      style: TextStyle(
                          fontSize: 15.0,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 1.0),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20),
              Container(
                child: Column(
                  children: <Widget>[
                    FlatButton(
                      onPressed: () {
                        print("I'm Maize");
                        goToObjectDetectionUi("MAIZE");
                      },
                      child: CircleAvatar(
                        backgroundImage: AssetImage('assets/maze.jpg'),
                        radius: 60,
                      ),
                    ),
                    Text(
                      "Maize",
                      style: TextStyle(
                          fontSize: 15.0,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 1.0),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
