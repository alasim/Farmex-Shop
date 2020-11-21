import 'dart:io';

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class AdminProductUpload extends StatefulWidget {
  @override
  _AdminProductUploadState createState() => _AdminProductUploadState();
}

class _AdminProductUploadState extends State<AdminProductUpload> {
  var _index = 0;
  var _producName = '';
  var _producUnit = '';
  var _producPrice = '';
  var _producDescription = '';
  var _producType = '';
  var _producTheme = '';

  File _image;
  final picker = ImagePicker();
  TextEditingController _productNameController = TextEditingController();
  TextEditingController _productDetailsController = TextEditingController();
  TextEditingController _productPriceController = TextEditingController();

  Future getImage() async {
    print('picker');
    final pickedFile = await picker.getImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      } else {
        print('No image selected.');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add new product'),
      ),
      body: Stepper(
        steps: [
          Step(
            title: Text(
              'Adding image',
              style: TextStyle(color: Colors.green, fontSize: 22),
            ),
            subtitle: Text('Only one image should be selected'),
            content: Container(
              color: Colors.white,
              child: DottedBorder(
                padding: EdgeInsets.all(10),
                dashPattern: [6, 2],
                strokeWidth: 2.5,
                color: Colors.amber,
                child: _image == null
                    ? GestureDetector(
                        onTap: getImage,
                        child: Icon(Icons.add_photo_alternate,
                            size: 60, color: Colors.black38),
                      )
                    : Stack(
                        children: [
                          Image.file(
                            _image,
                            width: 250,
                          ),
                          Positioned(
                            bottom: 0,
                            right: 0,
                            child: GestureDetector(
                              onTap: getImage,
                              child: Icon(Icons.add_a_photo,
                                  size: 30, color: Colors.black38),
                            ),
                          )
                        ],
                      ),
              ),
            ),
          ),
          Step(
            title: Text(
              'Add product name',
              style: TextStyle(color: Colors.green, fontSize: 20),
            ),
            subtitle: Text('Product name should not be more than 5 words.'),
            content: field('Give a product name', _productNameController),
          ),
          Step(
            title: Text(
              'Set product price',
              style: TextStyle(color: Colors.green, fontSize: 20),
            ),
            subtitle: Text('Please select unit and price per unit'),
            content: Column(
              children: [
                DropdownButton(
                  hint: Text(
                    "Please select product unit",
                    style: TextStyle(
                      color: Colors.black54,
                    ),
                  ),
                  items: [
                    DropdownMenuItem(
                      child: label('1kg', Colors.green),
                      value: 'kg',
                    ),
                    DropdownMenuItem(
                      child: label('500 gram', Colors.green),
                      value: '500g',
                    ),
                    DropdownMenuItem(
                      child: label('100 gram', Colors.green),
                      value: '100g',
                    ),
                    DropdownMenuItem(
                      child: label('1 piece', Colors.orange),
                      value: '1p',
                    ),
                    DropdownMenuItem(
                      child: label('12 piece', Colors.orange),
                      value: '12p',
                    ),
                  ],
                  onChanged: (value) {
                    setState(() {
                      _producUnit = value;
                    });
                  },
                ),
                field('Type product price', _productPriceController, 150),
              ],
            ),
          ),
          Step(
            title: Text(
              'Add product descriptions',
              style: TextStyle(color: Colors.green, fontSize: 20),
            ),
            subtitle:
                Text('Product description should not be more than 50 words.'),
            content: field('Tell about the product..', _productNameController),
          ),
          Step(
            isActive: true,
            title: Text(
              'Select product type',
              style: TextStyle(color: Colors.green, fontSize: 20),
            ),
            subtitle: Text('Select product type for better service.'),
            content: Container(
              child: DropdownButton(
                isExpanded: true,
                hint: Text(
                  "Please select product type",
                  style: TextStyle(
                    color: Colors.black54,
                  ),
                ),
                items: [
                  DropdownMenuItem(
                    child: label('Vegetable', Colors.green),
                    value: 'green',
                  ),
                  DropdownMenuItem(
                    child: label('Fruit', Colors.orange),
                    value: 'orrange',
                  ),
                  DropdownMenuItem(
                    child: label('Mortar', Colors.brown),
                    value: 'brown',
                  ),
                ],
                onChanged: (value) {
                  setState(() {
                    _producType = value;
                  });
                },
              ),
            ),
          ),
          Step(
            title: Text(
              'Select product theme',
              style: TextStyle(color: Colors.green, fontSize: 20),
            ),
            subtitle: Text('Select a theme for the product.'),
            content: Container(
              child: DropdownButton(
                isExpanded: true,
                hint: Text(
                  "Please select product theme",
                  style: TextStyle(
                    color: Colors.black54,
                  ),
                ),
                items: [
                  DropdownMenuItem(
                    child: label('Green Theme', Colors.green),
                    value: 'green',
                  ),
                  DropdownMenuItem(
                    child: label('Orrange Theme', Colors.orange),
                    value: 'orrange',
                  ),
                ],
                onChanged: (value) {
                  setState(() {
                    _producTheme = value;
                  });
                },
              ),
            ),
          ),
          Step(
            title: Text(
              'Confirm to upload',
              style: TextStyle(color: Colors.green, fontSize: 20),
            ),
            subtitle: Text('Please check all a once.'),
            content: Container(
              color: Colors.white,
              child: DottedBorder(
                  padding: EdgeInsets.all(10),
                  dashPattern: [6, 2],
                  strokeWidth: 2.5,
                  color: Colors.amber,
                  child: Column(children: [Text('Okay')])),
            ),
          ),
        ],
        currentStep: _index,
        onStepTapped: (index) {
          setState(() {
            _index = index;
          });
        },
        onStepCancel: () {
          print("You are clicking the cancel button.");
        },
        onStepContinue: () {
          print("You are clicking the continue button.");
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: getImage,
        tooltip: 'Pick Image',
        child: Icon(Icons.add_a_photo),
      ),
    );
  }
}

Widget field(hinText, controller, [width = 300]) {
  return Container(
    width: width.toDouble(),
    padding: EdgeInsets.all(10),
    child: TextField(
      controller: controller,
      decoration: InputDecoration(
        hintText: hinText,
        hintStyle: TextStyle(color: Colors.grey),
        filled: true,
        fillColor: Colors.white70,
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(12.0)),
          borderSide: BorderSide(color: Colors.amber, width: 2),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(10.0)),
          borderSide: BorderSide(color: Colors.amber, width: 2),
        ),
      ),
    ),
  );
}

Widget label(String text, Color color) {
  return Container(
    padding: EdgeInsets.all(5),
    decoration: BoxDecoration(
      color: color,
      borderRadius: BorderRadius.circular(5),
    ),
    child: Text(
      text,
      style: TextStyle(
        color: Colors.white,
        fontWeight: FontWeight.w300,
        fontSize: 16,
      ),
    ),
  );
}
