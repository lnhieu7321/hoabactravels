import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:hoabactravel/controllers/DetailItemController.dart';
import 'package:hoabactravel/models/DetailItem.dart';
import 'package:hoabactravel/screens/booking_screen.dart';


import '../controllers/AddFavoriteController.dart';
import '../models/AddFavoriteModel.dart';
import '../utils/LoginProvider.dart';

class DetailItemScreen extends StatefulWidget {
  final String id;
  final String userId;


  const DetailItemScreen({Key? key, required this.id, required this.userId}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _DetailItemScreenState createState() => _DetailItemScreenState();
}

class _DetailItemScreenState extends State<DetailItemScreen> {
  late Future<DetailService> _serviceFuture;
  bool isExpanded = false;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _serviceFuture =
        DetailServiceController().fetchDetailService(widget.id.toString());
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: SafeArea(child: FutureBuilder<DetailService>(
        future: _serviceFuture,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return SingleChildScrollView(
              child: Column(

                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  //appbar
                  Padding(
                    padding: EdgeInsets.only(left: 15, right: 15, top: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        InkWell(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: Container(
                            padding: EdgeInsets.all(3),
                            decoration: BoxDecoration(
                              color: Color(0xFFF5F9FD),
                              borderRadius: BorderRadius.circular(10),
                              boxShadow: [
                                BoxShadow(
                                  color: Color(0xFF475269),
                                  blurRadius: 5,
                                  spreadRadius: 1,
                                ),
                              ],
                            ),
                            child: Icon(
                              Icons.arrow_back,
                              size: 30,
                              color: Color(0xFF475269),
                            ),
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.all(3),
                          decoration: BoxDecoration(
                            color: Color(0xFFF5F9FD),
                            borderRadius: BorderRadius.circular(10),
                            boxShadow: [
                              BoxShadow(
                                color: Color(0xFF475269),
                                blurRadius: 5,
                                spreadRadius: 1,
                              ),
                            ],
                          ),

                          child: InkWell(
                            onTap: _isLoading ? null : () async {
                              setState(() => _isLoading = true);
                              final favoriteService = FavoriteService(
                                users_id: int.parse(widget.userId.toString()),
                                services_id: int.parse(widget.id.toString()),

                              );

                              await FavoriteServiceController()
                                  .addToFavorite(favoriteService)
                                  .catchError((error) {
                                final favoriteService = FavoriteService(
                                  users_id: int.parse(widget.userId.toString()),
                                  services_id: int.parse(widget.id.toString()),
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
                            child: Icon(
                              Icons.add,
                              size: 30,
                              color: Color(0xFF93D334),
                            ),
                          ),

                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 15,),
                  Padding(
                      padding: EdgeInsets.symmetric(vertical: 5,horizontal: 20),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(15),
                        child: Image.network(snapshot.data!.url),
                      )
                  ),
                  Container(
                    //height: MediaQuery.of(context).size.height * 0.4,
                    width: double.infinity,
                    padding: EdgeInsets.symmetric(vertical: 30, horizontal: 20),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              snapshot.data!.serviceName,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 25,
                                color: Color(0xFF475269),
                              ),
                            ),
                            Text(
                              '${snapshot.data!.price.toString()} VNĐ/đêm',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                                color: Colors.redAccent,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 15,
                        ),

                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              snapshot.data!.city,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 17,
                                color: Color(0xFF475269),
                              ),
                            ),
                            Row(
                              children: [
                                Container(
                                  child: RatingBarIndicator(
                                    rating: snapshot.data!.avgRate,
                                    itemCount: 5,
                                    itemSize: 16,
                                    itemBuilder: (context, _) =>
                                    const Icon(Icons.star, color: Colors.amber),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Row(
                          children: [
                            CircleAvatar(
                              backgroundImage: NetworkImage(snapshot.data!.logo),
                            ),
                            SizedBox(width: 10,),
                            Text('Doanh nghiệp: ${snapshot.data!.businessName}', style: TextStyle(
                              color: Color(0xFF475269),
                              fontSize: 18,
                              fontWeight: FontWeight.w500,
                            ),
                              textAlign: TextAlign.left,
                            ),
                          ],
                        ),
                        
                        const SizedBox(height: 20),
                        SingleChildScrollView(
                          child: Container(

                            child: Column(
                              children: [
                                // Gán giá trị cho maxLines trong khi tạo Text
                                Text(
                                  snapshot.data!.description,
                                  style: TextStyle(
                                    color: Color(0xFF475269),
                                    fontSize: 17,
                                  ),
                                  textAlign: TextAlign.justify,
                                  maxLines: isExpanded ? null : 10, // Cho phép hiển thị tất cả các dòng nếu isExpanded là true
                                  overflow: TextOverflow.clip,
                                ),
                                SizedBox(height: 10),
                                // Nút Xem tất cả
                                TextButton(
                                  onPressed: () {
                                    isExpanded = !isExpanded;
                                    setState(() {});
                                  },
                                  child: Text(isExpanded ? "Thu gọn" : "Xem tất cả"),
                                ),
                                // Nút Thu gọn

                                // ...
                              ],
                            ),
                          ),
                        ),
                        
                        SizedBox(
                          height: 20,
                        ),
                        Row(
                          children: [
                            Container(
                              child: Icon(
                                Icons.place_outlined,
                                color: Color(0xFF028512),
                                size: 20,
                              ),
                            ),
                            SizedBox(width: 10,),
                            Text(
                              snapshot.data!.address + ' - ' + snapshot.data!.ward + ' - ' + snapshot.data!.district + ' - ' + snapshot.data!.city,
                              style: TextStyle(
                                color: Color(0xFF475269),
                                fontSize: 15,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 20,),
                        Row(
                          children: [
                            Container(
                              child: Icon(
                                Icons.alarm,
                                color: Color(0xFF028512),
                                size: 20,
                              ),
                            ),
                            SizedBox(width: 10,),
                            Text(
                              "Mở cửa | 07:00 AM",
                              style: TextStyle(
                                color: Color(0xFF475269),
                                fontSize: 15,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            SizedBox(height: 10,),

                          ],
                        ),

                      ],
                    ),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      GestureDetector(
                        onTap: () {
                          // Navigate to the booking page
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => BookingScreen(serviceId: widget.id.toString(), userId: widget.userId.toString(),),
                            ),
                          );
                        },
                        child: Container(
                          padding: EdgeInsets.symmetric(vertical: 15, horizontal: 30),
                          decoration: BoxDecoration(
                            color: Color(0xFF028512),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Row(
                            children: [
                              Text(
                                "Đặt ngay",
                                style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 23,
                                  color: Colors.white,
                                ),
                              ),
                              SizedBox(width: 10),
                              Icon(
                                CupertinoIcons.arrow_right_circle,
                                color: Colors.white,
                                size: 32,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                ],
              ),
            );
          } else if (snapshot.hasError) {
            return Text(snapshot.error.toString());
          }
          return Center(
            child: CircularProgressIndicator(),
          );

        },
      ),),

      //bottomNavigationBar: ItemBottomNavBar(),
    );
  }
}
