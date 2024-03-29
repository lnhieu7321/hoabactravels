import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hoabactravel/controllers/AddFavoriteController.dart';
import 'package:hoabactravel/controllers/ItemController.dart';
import 'package:hoabactravel/models/AddFavoriteModel.dart';
import 'package:hoabactravel/models/Item.dart';
import 'package:hoabactravel/screens/DetailItemScreen.dart';
import 'package:provider/provider.dart';

import '../utils/LoginProvider.dart';

class AllItemWidget extends StatefulWidget {


  const AllItemWidget({super.key});
  @override
  _AllItemWidgetState createState() => _AllItemWidgetState();
}

class _AllItemWidgetState extends State<AllItemWidget> {
  late Future<List<Service>> _services;
  bool _isLoading = false;



  @override
  void initState() {
    super.initState();

    _services = ApiService.getServices();
  }

  @override
  Widget build(BuildContext context) {
    String? userId = context.watch<LoginProvider>().userId;
    return Scaffold(
      backgroundColor: Color(0xFFF2F5FA),
      body: StreamBuilder<List<Service>>(
        stream: ApiService.getServices().asStream(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 0.68,
              ),
              itemCount: snapshot.data?.length,
              itemBuilder: (context, index) {
                return Container(
                  padding: EdgeInsets.only(left: 15, right: 15, top: 10),
                  margin: EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Color(0xFFFFFFFF),
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                        color: Color(0xFF475269).withOpacity(0.3),
                        blurRadius: 5,
                        spreadRadius: 1,
                      ),
                    ],
                  ),
                  child: Column(
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
                        child: Padding(
                          padding: EdgeInsets.symmetric(vertical: 10),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: Image.network(
                              snapshot.data?[index].url ?? '',
                              fit: BoxFit.fitHeight,
                              height: 130,
                              width: 150,
                            ),
                          )

                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(bottom: 8),
                        child: Container(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            snapshot.data?[index].serviceName ?? '',
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF475269),
                            ),
                          ),
                        ),
                      ),
                      Container(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          snapshot.data?[index].address ?? '',
                          style: TextStyle(
                            fontSize: 12,
                            color: Color(0xFF475269).withOpacity(0.7),
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "${snapshot.data?[index].price.toString() ?? ''} đ/đêm",
                              style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.redAccent),
                            ),
                            Container(
                              width: 30,
                              height: 30,
                              padding: EdgeInsets.fromLTRB(1, 1, 3, 3),
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

