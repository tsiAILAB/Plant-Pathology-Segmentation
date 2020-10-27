import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'dart:math' as math;

import 'camera.dart';
import 'bndbox.dart';
import 'models.dart';

class HomePage extends StatefulWidget {
  final List<CameraDescription> cameras;

  final modelName;
  HomePage(this.cameras, this.modelName);

  @override
  _HomePageState createState() => new _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<dynamic> _recognitions;
  int _imageHeight = 0;
  int _imageWidth = 0;
  String _model = ssd;




  @override
  void initState() {
    super.initState();
  }




  setRecognitions(recognitions, imageHeight, imageWidth) {
    setState(() {
      try{
        _recognitions = recognitions;
        _imageHeight = imageHeight;
        _imageWidth = imageWidth;

        if(_recognitions == null){
          print ("RECOGNITION IS NULLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLL...................!!!!!!!!!!!!!!!!!!!!");
        }
      } catch (e){
        print ("ERROR ISSSSSSSSSS IN Recognitions : "+e);
      }
    });
  }


  @override
  Widget build(BuildContext context) {
    Size screen = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.modelName+" Diseases Detecting"),
      ),
      body: Stack(
        children: [
          Camera(
            widget.cameras,
            _model,
            setRecognitions,
          ),
          BndBox(
              _recognitions == null ? [] : _recognitions,
              math.max(_imageHeight, _imageWidth),
              math.min(_imageHeight, _imageWidth),
              screen.height,
              screen.width,
              _model),
        ],
      ),
    );
  }
}
