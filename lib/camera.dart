import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:tflite/tflite.dart';
import 'dart:math' as math;
import 'models.dart';

typedef void Callback(List<dynamic> list, int h, int w);

class Camera extends StatefulWidget {
  final List<CameraDescription> cameras;
  final Callback setRecognitions;
  final String model;

  Camera(this.cameras, this.model, this.setRecognitions);

  @override
  _CameraState createState() => new _CameraState();
}

class _CameraState extends State<Camera> {
  CameraController controller;
  bool isDetecting = false;

  @override
  void initState() {
    super.initState();

    if (widget.cameras == null || widget.cameras.length < 1) {
      print('No camera is found');
    } else {
      controller = new CameraController(
        widget.cameras[0],
        ResolutionPreset.medium,
      );
      controller.initialize().then((_) {
        if (!mounted) {
          return;
        }
        setState(() {});

        controller.startImageStream((CameraImage img) {
          if (!isDetecting) {
            isDetecting = true;

            int startTime = new DateTime.now().millisecondsSinceEpoch;

            // widget.model == ssd;
            // if( widget.model == ssd){
            //   try{
                Tflite.detectObjectOnFrame(
                  bytesList: img.planes.map((plane) {
                    return plane.bytes;
                  }).toList(),
                  model: "SSDMobileNet",
                  imageHeight: img.height,
                  imageWidth: img.width,
                  imageMean: 127.5,
                  imageStd: 127.5,
                  // rotation: 90,
                  numResultsPerClass: 1,
                  threshold:  0.5,
                ).then((recognitions) {
                  if (recognitions == null || recognitions.length < 1){
                    print ("MODEL COULD NOT RECOGNIZE ANYTHING..................!!!!!!!!!!!!!!!!!!!");
                  }else{
                    int endTime = new DateTime.now().millisecondsSinceEpoch;
                    print("Detection took ${endTime - startTime}");

                    widget.setRecognitions(recognitions, img.height, img.width);
                  }


                  isDetecting = false;
                });
              }
              // catch (e){
              //
              // }
            // }

          // }
        });
      });
    }
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (controller == null || !controller.value.isInitialized) {
      return Container();
    }

    var tmp = MediaQuery.of(context).size;
    var screenH = math.max(tmp.height, tmp.width);
    var screenW = math.min(tmp.height, tmp.width);
    tmp = controller.value.previewSize;
    var previewH = math.max(tmp.height, tmp.width);
    var previewW = math.min(tmp.height, tmp.width);
    var screenRatio = screenH / screenW;
    var previewRatio = previewH / previewW;


    return OverflowBox(
      maxHeight:
      screenRatio > previewRatio ? screenH : screenW / previewW * previewH,
      maxWidth:
      screenRatio > previewRatio ? screenH / previewH * previewW : screenW,
      child: CameraPreview(controller),
    );
  }
}
