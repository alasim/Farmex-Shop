import 'dart:io';
import 'package:farmex_shop/services/database.dart';
import 'package:farmex_shop/ui/gallery_card.dart';
import 'package:farmex_shop/ui/item_main.dart';
import 'package:farmex_shop/ui/releted_item_card.dart';
import 'package:get/get.dart';
import 'dart:convert';
import '../models/constants.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:farmex_shop/models/product.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';
import 'package:farmex_shop/models/datas.dart';

enum types { vegetable, fruit, mortar }

class AdminProductUpload extends StatefulWidget {
  @override
  _AdminProductUploadState createState() => _AdminProductUploadState();
}

class _AdminProductUploadState extends State<AdminProductUpload> {
  var _index = 0;
  var _producName = '';
  var _productUnit = '';
  var _producPrice = '';
  var _producDescription = '';
  var _producType = '';
  var _productTheme = '';

  File _image;
  final picker = ImagePicker();
  TextEditingController _productNameController = TextEditingController();
  TextEditingController _productPriceController = TextEditingController();
  TextEditingController _productDetailsController = TextEditingController(
      text:
          'There are many variations of passages of Lorem Ipsum available, but the majority have suffered alteration in some form, by injected humour, or randomised words which don\'t look even slightly believable.');

  var reviewProduct = Product(
      type: types.vegetable,
      name: 'carrots ',
      image: 'carrots-vegetables.jpg',
      itemQuantity: '1kg',
      price: 7,
      theme: greenTheme);
  setProduct() {
    //vegetable, fruit, mortar
    List<Map> mapData;

    preProducts.forEach((e) {
      Map<String, String> map = {};
      map['producName'] = e.name;
      map['productUnit'] = e.itemQuantity;
      map['producPrice'] = e.price.toString();
      map['producType'] = e.type == types.vegetable
          ? 'vegetable'
          : e.type == types.fruit
              ? 'fruit'
              : 'mortar';
      map['producTheme'] = 'green';
      mapData.add(map);
    });
    reviewProduct = Product(
        type: _producType == 'vegetable'
            ? types.vegetable
            : _producType == 'fruit'
                ? types.fruit
                : types.mortar,
        name: _productNameController.text,
        image: 'carrots-vegetables.jpg',
        itemQuantity: _productUnit,
        price: int.parse(_productPriceController.text),
        theme: _productTheme == 'green' ? greenTheme : orangeTheme);
    setState(() {});
  }

  Future getImage() async {
    print('picker');
    final pickedFile = await picker.getImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      } else {
        print('No image selected.');
      }
      print(_image.path);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          title: Text('Add new product'),
        ),
        body: ListView(
          children: [
            Container(
              margin: EdgeInsets.all(5),
              color: Colors.white30,
              child: Stepper(
                physics: ClampingScrollPhysics(),
                steps: [
                  Step(
                    isActive: true,
                    title: Text(
                      'Adding image',
                      style: TextStyle(color: Colors.green, fontSize: 22),
                    ),
                    subtitle: Text('Only one image should be selected'),
                    content: Container(
                      color: Colors.white60,
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
                    subtitle:
                        Text('Product name should not be more than 5 words.'),
                    content: field(
                        hinText: 'Give a product name',
                        controller: _productNameController),
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
                          value: _productUnit,
                          items: [
                            DropdownMenuItem(
                              child: label(
                                  'Select a product unit', Colors.grey[400]),
                              value: '',
                            ),
                            DropdownMenuItem(
                              child: label('1kg', Colors.green),
                              value: '1kg',
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
                              _productUnit = value;
                            });
                          },
                        ),
                        field(
                            hinText: 'Type product price',
                            controller: _productPriceController,
                            width: 150),
                      ],
                    ),
                  ),
                  Step(
                    title: Text(
                      'Add product descriptions',
                      style: TextStyle(color: Colors.green, fontSize: 20),
                    ),
                    subtitle: Text(
                        'Product description should not be more than 50 words.'),
                    content: field(
                        hinText: 'Tell about the product..',
                        controller: _productDetailsController,
                        maxLine: 5),
                  ),
                  Step(
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
                        value: _producType,
                        items: [
                          DropdownMenuItem(
                            child: label(
                                'Select a product type', Colors.grey[400]),
                            value: '',
                          ),
                          DropdownMenuItem(
                            child: label('Vegetable', Colors.green),
                            value: 'vegetable',
                          ),
                          DropdownMenuItem(
                            child: label('Fruit', Colors.orange),
                            value: 'fruit',
                          ),
                          DropdownMenuItem(
                            child: label('Mortar', Colors.brown),
                            value: 'mortar',
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
                        value: _productTheme,
                        items: [
                          DropdownMenuItem(
                            child: label(
                                'Select a product theme', Colors.grey[400]),
                            value: '',
                          ),
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
                            _productTheme = value;
                          });
                        },
                      ),
                    ),
                  ),

                  // Step(
                  //   title: Text(
                  //     'Product in card view',
                  //     style: TextStyle(color: Colors.green, fontSize: 20),
                  //   ),
                  //   subtitle: Text('Please check all a once.'),
                  //   content: Container(
                  //     color: Colors.white60,
                  //     child: DottedBorder(
                  //       padding: EdgeInsets.all(10),
                  //       dashPattern: [6, 2],
                  //       strokeWidth: 2.5,
                  //       color: Colors.amber,
                  //       child: Stack(
                  //         children: [
                  //           ItemMain(
                  //             p: reviewProduct,
                  //             fileImahe: _image,
                  //           ),
                  //           Positioned(
                  //             top: 80,
                  //             left: 0,
                  //             right: 0,
                  //             child: ItemMain(p: reviewProduct),
                  //           ),
                  //         ],
                  //       ),
                  //     ),
                  //   ),
                  // ),
                  Step(
                    title: Text(
                      'Product in details view',
                      style: TextStyle(color: Colors.green, fontSize: 20),
                    ),
                    subtitle: Text('Please check all a once.'),
                    content: Container(
                      color: Colors.white60,
                      child: DottedBorder(
                        padding: EdgeInsets.all(10),
                        dashPattern: [6, 2],
                        strokeWidth: 2.5,
                        color: Colors.amber,
                        child: Container(
                          height: 450,
                          child: ListView(
                            children: [
                              Column(
                                children: [
                                  Stack(
                                    children: [
                                      CustomPaint(
                                        painter: reviewProduct.theme['detail'],
                                        child: Container(
                                          height: 120,
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(20),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.stretch,
                                          children: [
                                            Stack(children: [
                                              Center(
                                                child: Text(
                                                  'Details',
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 20,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                              ),
                                            ]),
                                            //SizedBox(height: 20),
                                            Container(
                                              height: 250,
                                              margin: EdgeInsets.only(
                                                  top: 20, bottom: 20),
                                              width: double.infinity,
                                              decoration: BoxDecoration(
                                                color: Colors.white,
                                                borderRadius:
                                                    BorderRadius.circular(15),
                                                boxShadow: [
                                                  BoxShadow(
                                                    color: Colors.grey
                                                        .withOpacity(0.05),
                                                    spreadRadius: 3,
                                                    blurRadius: 3,
                                                    offset: Offset(0,
                                                        -3), // changes position of shadow
                                                  ),
                                                ],
                                              ),
                                              child: Stack(
                                                children: [
                                                  Positioned(
                                                    top: 10,
                                                    right: 10,
                                                    child: Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              15),
                                                      child: Icon(
                                                        reviewProduct.loved
                                                            ? Icons.favorite
                                                            : Icons
                                                                .favorite_border,
                                                        size: 25,
                                                        color: reviewProduct
                                                                .loved
                                                            ? kDeepGeen
                                                            : Colors.grey
                                                                .withOpacity(
                                                                    .3),
                                                      ),
                                                    ),
                                                  ),
                                                  Positioned(
                                                    top: 40,
                                                    left: 30,
                                                    right: 30,
                                                    child: Container(
                                                      child: Image(
                                                        height: 120,
                                                        width: 170,
                                                        image: _image.isNull
                                                            ? AssetImage(
                                                                'assets/images/${reviewProduct.image}')
                                                            : FileImage(_image),
                                                      ),
                                                    ),
                                                  ),
                                                  Positioned(
                                                    child: Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              top: 160,
                                                              left: 20,
                                                              right: 20),
                                                      child: ListTile(
                                                        isThreeLine: true,
                                                        trailing: Text(
                                                          '\$${reviewProduct.price}',
                                                          style: TextStyle(
                                                            fontSize: 20,
                                                            color: Colors
                                                                .black87
                                                                .withOpacity(
                                                                    .5),
                                                          ),
                                                        ),
                                                        title: Text(
                                                          reviewProduct.name,
                                                          style: TextStyle(
                                                              fontSize: 20,
                                                              color: Colors
                                                                  .black87,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold),
                                                        ),
                                                        subtitle: Text(
                                                            reviewProduct
                                                                .itemQuantity),
                                                      ),
                                                    ),
                                                  )
                                                ],
                                              ),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 10, right: 10),
                                              child: Text(
                                                'There are many variations of passages of Lorem Ipsum available, but the majority have suffered alteration in some form, by injected humour, or randomised words which don\'t look even slightly believable.',
                                                textAlign: TextAlign.left,
                                                style: TextStyle(
                                                    color: Colors.grey,
                                                    fontSize: 12,
                                                    letterSpacing: 1),
                                                overflow: TextOverflow.clip,
                                                maxLines: 4,
                                              ),
                                            ),
                                            SizedBox(height: 30),
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 5, bottom: 5),
                                                  child: Text(
                                                    'Releted Items',
                                                    style: TextStyle(
                                                        fontSize: 15,
                                                        color: Colors.black87,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                ),
                                                Column(children: [
                                                  ReletedItemCard(
                                                    p: reviewProduct,
                                                  ),
                                                  ReletedItemCard(
                                                    p: reviewProduct,
                                                  )
                                                ]),
                                              ],
                                            ),
                                            SizedBox(height: 30),
                                            RichText(
                                              text: TextSpan(
                                                children: [
                                                  TextSpan(
                                                    text: 'This is how ',
                                                    style: TextStyle(
                                                      fontSize: 15,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Colors.black,
                                                    ),
                                                  ),
                                                  TextSpan(
                                                    text:
                                                        'Your ${reviewProduct.name} ',
                                                    style: TextStyle(
                                                      fontSize: 18,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: reviewProduct
                                                          .theme['deep'],
                                                    ),
                                                  ),
                                                  TextSpan(
                                                    text:
                                                        'prepared on Farmex garden!!',
                                                    style: TextStyle(
                                                      fontSize: 15,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Colors.black,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            SizedBox(height: 10),
                                            Container(
                                              height: 150,
                                              child: ListView(
                                                scrollDirection:
                                                    Axis.horizontal,
                                                children: [
                                                  galleryCard(
                                                      'assets/images/three.jpg'),
                                                  galleryCard(
                                                      'assets/images/one.jpg'),
                                                  galleryCard(
                                                      'assets/images/two.jpg'),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  Step(
                    title: Text(
                      'Upload product',
                      style: TextStyle(color: Colors.green, fontSize: 20),
                    ),
                    subtitle:
                        Text('Product name should not be more than 5 words.'),
                    content: Container(
                      child: Text(
                        'Ready to upload the product',
                        style: TextStyle(color: Colors.green, fontSize: 22),
                      ),
                    ),
                  ),
                ],
                currentStep: _index,
                onStepTapped: (index) {
                  _index = index;
                  print(_index);
                  setState(() {
                    if (_index > 5) {
                      if (_image == null) print('_image ${_image.toString()}');
                      if (_image == null) {
                        Get.defaultDialog(
                          title: 'Image not selected!!',
                          content: Text(
                            'Please select a product image at step 1.',
                          ),
                          onConfirm: () {
                            Get.back();
                            setState(() {
                              _index = 0;
                            });
                          },
                          confirmTextColor: Colors.white,
                        );
                      } else if (_productNameController.text == null) {
                        Get.defaultDialog(
                          title: 'No product name!!',
                          content: Text(
                            'Please select a product name at step 2.',
                          ),
                          onConfirm: () {
                            Get.back();
                            setState(() {
                              _index = 1;
                            });
                          },
                          confirmTextColor: Colors.white,
                        );
                      } else if (_productPriceController.text == null) {
                        Get.defaultDialog(
                          title: 'Didn\'t set price!!',
                          content: Text(
                            'Please give a product price at step 3.',
                          ),
                          onConfirm: () {
                            Get.back();
                            setState(() {
                              _index = 2;
                            });
                          },
                          confirmTextColor: Colors.white,
                        );
                      } else if (_productDetailsController.text == null) {
                        Get.defaultDialog(
                          title: 'No product Description!!',
                          content: Text(
                            'Please tell about the product details at step 4.',
                          ),
                          onConfirm: () {
                            Get.back();
                            setState(() {
                              _index = 3;
                            });
                          },
                          confirmTextColor: Colors.white,
                        );
                      } else if (_producType == '') {
                        Get.defaultDialog(
                          title: 'Product type not selected!!',
                          content: Text(
                            'Please select a product type at step 5.',
                          ),
                          onConfirm: () {
                            Get.back();
                            setState(() {
                              _index = 4;
                            });
                          },
                          confirmTextColor: Colors.white,
                        );
                      } else if (_productTheme == '') {
                        Get.defaultDialog(
                          title: 'Product theme not selected!!',
                          content: Text(
                            'Please select a product theme at step 6.',
                          ),
                          onConfirm: () {
                            Get.back();
                            setState(() {
                              _index = 5;
                            });
                          },
                          confirmTextColor: Colors.white,
                        );
                      }
                      setProduct();
                      setState(() {});
                    }
                  });
                },
                onStepContinue: () {
                  setState(() {
                    if (_index <= 7) {
                      ++_index;
                    }
                    if (_index > 5) {
                      if (_image == null) {
                        Get.defaultDialog(
                          title: 'Image not selected!!',
                          content: Text(
                            'Please select a product image at step 1.',
                          ),
                          onConfirm: () {
                            Get.back();
                            setState(() {
                              _index = 0;
                            });
                          },
                          confirmTextColor: Colors.white,
                        );
                      } else if (_productNameController.text == null) {
                        Get.defaultDialog(
                          title: 'No product name!!',
                          content: Text(
                            'Please select a product name at step 2.',
                          ),
                          onConfirm: () {
                            Get.back();
                            setState(() {
                              _index = 1;
                            });
                          },
                          confirmTextColor: Colors.white,
                        );
                      } else if (_productPriceController.text == null) {
                        Get.defaultDialog(
                          title: 'Didn\'t set price!!',
                          content: Text(
                            'Please give a product price at step 3.',
                          ),
                          onConfirm: () {
                            Get.back();
                            setState(() {
                              _index = 2;
                            });
                          },
                          confirmTextColor: Colors.white,
                        );
                      } else if (_productDetailsController.text == null) {
                        Get.defaultDialog(
                          title: 'No product Description!!',
                          content: Text(
                            'Please tell about the product details at step 4.',
                          ),
                          onConfirm: () {
                            Get.back();
                            setState(() {
                              _index = 3;
                            });
                          },
                          confirmTextColor: Colors.white,
                        );
                      } else if (_producType == '') {
                        Get.defaultDialog(
                          title: 'Product type not selected!!',
                          content: Text(
                            'Please select a product type at step 5.',
                          ),
                          onConfirm: () {
                            Get.back();
                            setState(() {
                              _index = 4;
                            });
                          },
                          confirmTextColor: Colors.white,
                        );
                      } else if (_productTheme == '') {
                        Get.defaultDialog(
                          title: 'Product theme not selected!!',
                          content: Text(
                            'Please select a product theme at step 6.',
                          ),
                          onConfirm: () {
                            Get.back();
                            setState(() {
                              _index = 5;
                            });
                          },
                          confirmTextColor: Colors.white,
                        );
                      }
                      setProduct();
                    }

                    setState(() {});
                  });
                },
                onStepCancel: () {
                  setState(() {
                    if (_index >= 1) --_index;
                  });
                },
              ),
            ),
            // Container(
            //   height: 500,
            //   width: double.infinity,
            //   color: Colors.white24,
            // )
          ],
        ),
        floatingActionButton: _index == 7
            ? FloatingActionButton(
                backgroundColor: Colors.amber,
                tooltip: 'Pick Image',
                child: Icon(
                  Icons.cloud_upload,
                  color: Colors.black87,
                ),
                onPressed: () async {
                  String fileName = basename(_image.path);
                  if (_image != null) {
                    print(
                        'uploading...........................$fileName....................');
                    String imageUrl =
                        await Database().upluadImage(_image, fileName, {
                      'producName': _productNameController.text,
                      'productUnit': _productUnit,
                      'producPrice': _productPriceController.text,
                      'producDescription': _productDetailsController.text,
                      'producType': _producType,
                      'producTheme': _productTheme,
                    });
                  } else {
                    print('there is a problem to upload data');
                  }
                },
              )
            : SizedBox());
  }
}

Widget field({hinText, controller, width = 300, maxLine = 1}) {
  return Container(
    width: width.toDouble(),
    padding: EdgeInsets.all(10),
    child: TextField(
      minLines: 1, //Normal textInputField will be displayed
      maxLines: maxLine, // when user presses enter it will adapt to it
      controller: controller,
      decoration: InputDecoration(
        hintText: hinText,
        hintStyle: TextStyle(color: Colors.grey),
        filled: true,
        fillColor: Colors.white60,
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
