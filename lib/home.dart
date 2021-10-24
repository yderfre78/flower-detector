import 'package:flutter/material.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:tflite/tflite.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final picker = ImagePicker();

  File? _image;
  bool _loading = false;
  List? _output;

  picImage() async {
    var image = await picker.pickImage(source: ImageSource.camera);
    if (image == null) return null;
    setState(() {
      _image = File(image.path);
    });
    classifyImage(_image!);
  }

  picGaleryImage() async {
    var image = await picker.pickImage(source: ImageSource.gallery);
    if (image == null) return null;
    setState(() {
      _image = File(image.path);
    });
    classifyImage(_image!);
  }

  @override
  void initState() {
    super.initState();
    _loading = true;
    loadModel().then((value) {
      // setState(() {});
    });
  }

  @override
  void dispose() {
    Tflite.close();
    super.dispose();
  }

  classifyImage(File image) async {
    var output = await Tflite.runModelOnImage(
      path: image.path,
      numResults: 2,
      threshold: 0.5,
      imageMean: 127.5,
      imageStd: 127.5,
    );
    setState(() {
      _loading = false;
      _output = output;
    });
  }

  loadModel() async {
    await Tflite.loadModel(
      model: 'assets/model_unquant.tflite',
      labels: ('assets/labels.txt'),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF010101),
      body: Container(
        padding: EdgeInsets.symmetric(
          horizontal: 24,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 100,
            ),
            Text(
              'Teachablemachine CNN',
              style: TextStyle(color: Colors.white, fontSize: 15),
            ),
            SizedBox(
              height: 6,
            ),
            Text(
              'Detectar Perro o Gato',
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 25,
                  fontWeight: FontWeight.w500),
            ),
            SizedBox(
              height: 50,
            ),
            Center(
                child: _loading
                    ? Container(
                        width: 300,
                        child: Column(
                          children: [
                            Image(
                              image: AssetImage('assets/cat.png'),
                            ),
                            SizedBox(
                              height: 50,
                            )
                          ],
                        ),
                      )
                    : Container(
                        child: Column(
                          children: [
                            Container(
                              height: 250,
                              child: Image.file(_image!),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            _output != null
                                ? Text(
                                    '${_output?[0]['label']}',
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 20),
                                  )
                                : Container(
                                    child: Text(
                                      'no hay nada',
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  ),
                            SizedBox(height: 10),
                          ],
                        ),
                      )),
            Container(
              width: MediaQuery.of(context).size.width,
              child: Column(
                children: [
                  GestureDetector(
                    onTap: picImage,
                    child: Container(
                      width: MediaQuery.of(context).size.width - 10,
                      alignment: Alignment.center,
                      padding: EdgeInsets.symmetric(
                        horizontal: 24,
                        vertical: 17,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.grey,
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Text(
                        'Toma una Foto',
                        style: TextStyle(color: Colors.black),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  GestureDetector(
                    onTap: picGaleryImage,
                    child: Container(
                      width: MediaQuery.of(context).size.width - 20,
                      alignment: Alignment.center,
                      padding: EdgeInsets.symmetric(
                        horizontal: 24,
                        vertical: 17,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.grey,
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Text(
                        'Escoge una foto de tu Galería',
                        style: TextStyle(color: Colors.black),
                      ),
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
