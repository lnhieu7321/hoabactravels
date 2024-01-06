import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hoabactravel/controllers/ItemPopularController.dart';
import 'package:hoabactravel/models/ItemPopularModel.dart';

import '../screens/DetailItemScreen.dart';
import 'package:provider/provider.dart';

import '../utils/LoginProvider.dart';

class RowItemWidget extends StatefulWidget {
  const RowItemWidget({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _RowItemWidgetState createState() => _RowItemWidgetState();
}

class _RowItemWidgetState extends State<RowItemWidget> {
  late Future<List<ServicePopular>> _service;

  @override
  void initState() {
    super.initState();
    _service = ApiServicePopular.getServicesPopular();
  }

  @override
  Widget build(BuildContext context) {
    String? userId = context.watch<LoginProvider>().userId;
    return SizedBox(
      height: 200, // Chiều cao của FutureBuilder
      child: FutureBuilder<List<ServicePopular>>(
        future: _service,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: snapshot.data?.length,
              itemBuilder: (context, index) {
                return SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                        Container(
                          margin: EdgeInsets.only(top: 10, bottom: 10, left: 15 ,),
                          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                          height: 130,
                          decoration: BoxDecoration(
                            color: Color(0xFFF5F9FD),
                            borderRadius: BorderRadius.circular(10),
                            boxShadow: [
                              BoxShadow(
                                color: Color(0xFF475269).withOpacity(0.3),
                                blurRadius: 5,
                                spreadRadius: 1,
                              ),
                            ],
                          ),
                          child: Row(
                            children: [
                              Stack(
                                alignment: Alignment.center,
                                children: [
                                  InkWell(
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => DetailItemScreen(id: snapshot.data![index].id.toString()),
                                        ),
                                      );
                                    },
                                    child: Image.network(
                                      snapshot.data?[index].url ?? '',
                                      height: 100,
                                      width: 100,
                                    ),
                                  ),

                                ],
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              Padding(
                                padding: EdgeInsets.symmetric(vertical: 10),
                                child: Column(
                                  children: [
                                    Text(
                                      snapshot.data?[index].serviceName ?? '',
                                      style: TextStyle(
                                        color: Color(0xFF475269),
                                        fontSize: 15,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Text(
                                      snapshot.data?[index].address ?? '',
                                      style: TextStyle(
                                        color: Color(0xFF475269).withOpacity(0.8),
                                        fontSize: 12,
                                      ),
                                    ),
                                    Spacer(),
                                    Row(
                                      children: [
                                        Container(
                                          child: Icon(
                                            Icons.star,
                                            color: Colors.amber,
                                            size: 15,
                                          ),
                                        ),
                                        SizedBox(
                                          width: 5,
                                        ),
                                        Text("${snapshot.data?[index].avgRate ?? ''}"),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        SizedBox(width: 10,),
                                        Text(
                                          "${snapshot.data?[index].price.toString() ?? ''} đ/đêm",
                                          style: TextStyle(
                                            color: Colors.redAccent,
                                            fontSize: 13,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                        SizedBox(
                                          width: 50,
                                        ),
                                        Container(
                                          padding: EdgeInsets.all(10),
                                          decoration: BoxDecoration(
                                            color: Color(0xFF93D334),
                                            borderRadius: BorderRadius.circular(10),
                                          ),
                                          child: Icon(
                                            CupertinoIcons.add,
                                            color: Colors.white,
                                            size: 10,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                    ],
                  ),
                );
              },
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text(snapshot.error.toString()),
            );
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );

  }
}
