import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:hoabactravel/controllers/FavoriteController.dart';
import 'package:hoabactravel/models/FavoriteModel.dart';

import '../controllers/DeleteRecordFavorite.dart';
import '../utils/LoginProvider.dart';
import 'DetailItemScreen.dart';

class WalletScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final userId = context.read<LoginProvider>().userId;
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SafeArea(
        child: Scaffold(

          appBar: AppBar(
            backgroundColor: Colors.white,
            title: const Text(
              "Dịch vụ yêu thích",
              style: TextStyle(color: Color(0xFF475269)),
            ),
          ),
          body: StreamBuilder<List<FavoriteModel>>(
            stream: FavoriteController.getfavoriteModel(userId).asStream(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return Padding(padding: EdgeInsets.symmetric(horizontal: 20),child: GridView.builder(
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
                          Row(
                            children: [
                              Column(children: [
                                Container(
                                  width: 80,
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

                                    ],
                                  ),
                                ),
                              ],),
                              SizedBox(
                                width: 20,
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
                                  onPressed: () async {
                                    var success = await DeleteRecordFavorite().deleteRecord(snapshot.data![index].fav_id.toString());
                                    //print(snapshot.data![index].fav_id.toString());
                                    if (success) {
                                      ScaffoldMessenger.of(context).showSnackBar(
                                          SnackBar(content: Text('Xóa bản ghi thành công!')));
                                      Navigator.of(context)
                                          .pushReplacement(MaterialPageRoute(
                                          builder: (context) => WalletScreen()));
                                    } else {
                                      ScaffoldMessenger.of(context).showSnackBar(
                                          SnackBar(content: Text('Xóa bản ghi thất bại!')));
                                    }
                                  },
                                  icon: Icon(CupertinoIcons.clear, size: 15,),
                                ),
                              ),
                            ],
                          ),


                        ],
                      ),
                    );

                  },
                ),)
                  ;
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
        ),
      ),
    );
  }
}
