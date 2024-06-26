import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:manzil_api/products/services/service_product.dart';
import 'package:manzil_api/utilities/rest_api_utilities.dart';

import '../models/model_manzil.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Future<List<ManzilModel>>? _futureList;

  @override
  void initState() {
    super.initState();
    _futureList = ServiceProduct.LoadManzil();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('APIs'),
        ),
        body: Container(
          padding: EdgeInsets.all(20),
          child: FutureBuilder(
            future: _futureList,
            builder: (BuildContext context, AsyncSnapshot<List<ManzilModel>> snapshot) {
              if (snapshot.hasError) {
                return Text("${snapshot.error}");
              } else {
                if (snapshot.hasData) {
                  List<ManzilModel> list = snapshot.data!;
                  if (list.isNotEmpty) {
                    return ListView.builder(
                      itemCount: snapshot.data!.length,
                      itemBuilder: (context, index) {
                        final manzilModel = snapshot.data![index];
                        final ayahs = manzilModel.data?.ayahs;
                        final surahs = manzilModel.data?.surahs;

                        return Card(
                          margin: EdgeInsets.symmetric(vertical: 8),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              if (surahs != null && surahs.isNotEmpty)
                                ...surahs.entries.map(
                                      (entry) => ListTile(
                                    title: Text('Surah ${entry.value.number}:'
                                        ' ${entry.value.name ?? ''}',
                                      style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                    subtitle: Column(
                                      crossAxisAlignment: CrossAxisAlignment.end,
                                      children: ayahs != null
                                          ? ayahs
                                          .where((ayah) => ayah.surah?.number == entry.value.number)
                                          .map(
                                            (ayah) => Padding(
                                          padding: const EdgeInsets.symmetric(vertical: 4),
                                          child: Text('\u2022 ${ayah.text ?? ''}'),
                                        ),
                                      )
                                          .toList()
                                          : [],
                                    ),
                                  ),
                                ),
                            ],
                          ),
                        );
                      },
                    );
                  } else {
                    return Text("Sorry, no record found");
                  }
                } else {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
              }
            },
          ),
        ),
      ),
    );
  }
}
