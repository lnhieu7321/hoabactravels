import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hoabactravel/controllers/ItemPopularController.dart';
import 'package:hoabactravel/models/ItemPopularModel.dart';

import '../controllers/AddFavoriteController.dart';
import '../models/AddFavoriteModel.dart';
import '../screens/DetailItemScreen.dart';
import 'package:provider/provider.dart';

import '../utils/LoginProvider.dart';
import 'dart:ui';

class RowItemWidget extends StatefulWidget {
  const RowItemWidget({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _RowItemWidgetState createState() => _RowItemWidgetState();
}

class _RowItemWidgetState extends State<RowItemWidget> {
  late Future<List<ServicePopular>> _service;
  bool _isLoading = false;

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
                                          builder: (context) => DetailItemScreen(id: snapshot.data![index].id.toString(), userId: userId.toString(),),
                                        ),
                                      );
                                    },
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(10),
                                      child: Image.network(
                                        snapshot.data?[index].url ?? '',

                                        width: 100,
                                      ),
                                    ),

                                  ),

                                ],
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              Padding(
                                padding: EdgeInsets.symmetric(vertical: 10),
                                child: Row(

                                      children: [
                                        SizedBox(width: 10,),
                                        Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
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
                                            Container(

                                              child: Text(

                                                snapshot.data?[index].address ?? '',
                                                style: TextStyle(
                                                  color: Color(0xFF475269).withOpacity(0.8),
                                                  fontSize: 12,
                                                ),

                                              ),
                                            ),

                                            SizedBox(
                                              height: 5,
                                            ),
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
                                            SizedBox(
                                              height: 5,
                                            ),
                                            Text(
                                              "${snapshot.data?[index].price.toString() ?? ''} đ/đêm",
                                              style: TextStyle(
                                                color: Colors.redAccent,
                                                fontSize: 13,
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                          ],
                                        ),

                                        SizedBox(
                                          width: 10,
                                        ),
                                        Container(
                                          width: 30,
                                          height: 30,
                                          padding: EdgeInsets.fromLTRB(0, 0, 5, 5),
                                          decoration: BoxDecoration(
                                            color: Color(0xFF93D334),
                                            borderRadius: BorderRadius.circular(10),
                                          ),
                                          child: IconButton(
                                            alignment: Alignment.center,
                                            color: Colors.white,
                                            onPressed: _isLoading ? null : () async {
                                              setState(() => _isLoading = true);
                                              final favoriteService = FavoriteService(
                                                users_id: int.parse(userId.toString()),
                                                services_id: int.parse((snapshot.data?[index].id).toString()),

                                              );

                                              await FavoriteServiceController()
                                                  .addToFavorite(favoriteService)
                                                  .catchError((error) {
                                                final favoriteService = FavoriteService(
                                                    users_id: int.parse(userId.toString()),
                                                    services_id: int.parse((snapshot.data?[index].id).toString())
                                                );
                                                return favoriteService;
                                              });
                                              _isLoading = false;

                                              setState(() {
                                                ScaffoldMessenger.of(context).showSnackBar(
                                                  SnackBar(content: Text('Đã thêm vào danh sách yêu thích')),
                                                );
                                              });
                                            },
                                            icon: Icon(CupertinoIcons.add, size: 15,),
                                          ),
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
