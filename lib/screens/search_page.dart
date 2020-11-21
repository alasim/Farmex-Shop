import 'package:farmex_shop/models/constants.dart';
import 'package:farmex_shop/models/datas.dart';
import 'package:farmex_shop/models/product.dart';
import 'package:farmex_shop/ui/search_item_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

class Searchpage extends StatefulWidget {
  Searchpage();
  @override
  _SearchpageState createState() => _SearchpageState();
}

class _SearchpageState extends State<Searchpage> {
  List<Product> searchResult;
  TextEditingController _controller;
  String inputText;
  RichText titleWithStyle;
  @override
  void initState() {
    super.initState();
    searchResult = List.from(preProducts);
    _controller = TextEditingController();
    inputText = ''; //start page null safe
  }

  void onSearch(String inputs) {
    print(inputs);

    setState(() {
      searchResult.clear();
      preProducts.forEach((element) {
        String pName = element.name.toLowerCase();
        inputText = inputs.toLowerCase();
        if (pName.startsWith(inputText)) {
          if (!searchResult.contains(element)) {
            searchResult.add(element);
          }
        }
      });

      print('preProducts: ${preProducts.length}');
      print('searchResult: ${searchResult.length}');
    });
  }

  RichText titleStyle(String fullTile) {
    return RichText(
      text: TextSpan(
        children: [
          TextSpan(
            text: inputText,
            style: TextStyle(
              fontSize: 20,
              color: Colors.black87,
              fontWeight: FontWeight.bold,
            ),
          ),
          TextSpan(
            text: fullTile.substring(inputText.length),
            style: TextStyle(
              fontSize: 17,
              color: Colors.grey,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    print('preProducts: ${preProducts.length}');
    return Scaffold(
      appBar: AppBar(
        title: Container(
          height: 45,
          width: Get.width,
          child: TextField(
            controller: _controller,
            autofocus: true,
            onChanged: (inputs) {
              onSearch(inputs);
            },
            decoration: InputDecoration(
              fillColor: Colors.white,
              filled: true,
              hintText: 'Type item name..',
              alignLabelWithHint: true,
              hintStyle: TextStyle(
                color: Colors.grey.withOpacity(.5),
              ),
              suffixIcon: IconButton(
                onPressed: () {
                  _controller.clear();
                },
                icon: Icon(Icons.close),
              ),
              // suffixIcon: Icon(
              //   Icons.close,
              //   color: kDeepGeen,
              // ),
              contentPadding: EdgeInsets.only(top: 5),
              border: OutlineInputBorder(
                borderSide: BorderSide.none,
                borderRadius: BorderRadius.circular(5),
              ),
            ),
          ),
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            //SizedBox(height: 10),
            Row(
              children: [
                // IconButton(
                //   onPressed: () {
                //     Navigator.pop(context);
                //   },
                //   icon: Icon(
                //     Icons.keyboard_arrow_left_outlined,
                //     size: 35,
                //     color: Colors.grey,
                //   ),
                // ),
                // Expanded(
                //   flex: 3,
                //   child: Container(
                //     height: 50,
                //     child: TextField(
                //       controller: _controller,
                //       autofocus: true,
                //       onChanged: (inputs) {
                //         onSearch(inputs);
                //       },
                //       decoration: InputDecoration(
                //         fillColor: Colors.white,
                //         filled: true,
                //         hintText: 'Type item name..',
                //         alignLabelWithHint: true,
                //         hintStyle: TextStyle(
                //           color: Colors.grey.withOpacity(.5),
                //         ),
                //         prefixIcon: Icon(
                //           Icons.search,
                //           color: kDeepGeen,
                //         ),
                //         contentPadding: EdgeInsets.only(top: 5),
                //         border: OutlineInputBorder(
                //           borderSide: BorderSide.none,
                //           borderRadius: BorderRadius.circular(5),
                //         ),
                //       ),
                //     ),
                //   ),
                // ),
              ],
            ),
            //SizedBox(height: 20),
            Expanded(
              child: Stack(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(5),
                    child: ListView(
                      physics: BouncingScrollPhysics(),
                      children: [
                        for (var item in searchResult)
                          SearchItemCard(
                              p: item, titleStyle: titleStyle(item.name)),
                        //SizedBox(height: MediaQuery.of(context).size.height - 450),
                      ],
                    ),
                  ),
                  (searchResult.isEmpty && inputText == null)
                      ? Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                FontAwesomeIcons.boxOpen,
                                size: 100,
                                color: kDeepGeen,
                              ),
                              SizedBox(height: 30),
                              Text(
                                'Type to search...',
                                style: TextStyle(fontSize: 25),
                              ),
                            ],
                          ),
                        )
                      : searchResult.isEmpty
                          ? Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    FontAwesomeIcons.boxOpen,
                                    size: 100,
                                    color: kDeepGeen,
                                  ),
                                  SizedBox(height: 30),
                                  Text(
                                    'No item found',
                                    style: TextStyle(fontSize: 25),
                                  ),
                                ],
                              ),
                            )
                          : Text('')
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
