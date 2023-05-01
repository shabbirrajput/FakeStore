import 'dart:convert';

import 'package:fake_store/apiProvider/api_provider.dart';
import 'package:fake_store/model/product_model.dart';
import 'package:flutter/material.dart';

class ApiPractice extends StatefulWidget {
  const ApiPractice({Key? key}) : super(key: key);

  @override
  State<ApiPractice> createState() => _ApiPracticeState();
}

class _ApiPracticeState extends State<ApiPractice> {
  List<ProductModel> mProductModel = [];

  @override
  void initState() {
    initData();
    super.initState();
  }

  void initData() async {
    var response = await ApiProvider()
        .getApiMethod('https://fakestoreapi.com/products/category/jewelery');
    mProductModel = List<ProductModel>.from(
        jsonDecode(response).map((model) => ProductModel.fromJson(model)));
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: ListView.builder(
        itemBuilder: (context, index) {
          ProductModel item = mProductModel[index];
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Image.network(
                  item.image!,
                  height: 100,
                  width: 100,
                ),
                const SizedBox(
                  width: 10,
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    /* mainAxisAlignment: MainAxisAlignment.start,*/
                    children: [
                      Text(
                        item.title!,
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            item.description!,
                            textAlign: TextAlign.start,
                          ))
                    ],
                  ),
                )
              ],
            ),
          );
        },
        itemCount: mProductModel.length,
      ),
    );
  }
}
