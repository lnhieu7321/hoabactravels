import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:hoabactravel/controllers/DetailItemController.dart';
import 'package:hoabactravel/controllers/DetailUpdateController.dart';
import 'package:hoabactravel/models/DetailBook.dart';
import 'package:hoabactravel/screens/booking_screen.dart';
import 'package:hoabactravel/screens/rating_screen.dart';
import 'package:hoabactravel/screens/update_book_screen.dart';

import '../controllers/DetailBookController.dart';

class BookTicketScreen extends StatefulWidget {
  final String id;
  final String? userId;

  const BookTicketScreen({Key? key, required this.id, this.userId}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _BookTicketScreenState createState() => _BookTicketScreenState();
}

class _BookTicketScreenState extends State<BookTicketScreen> {
  late Future<DetailBook> _bookFuture;




  @override
  void initState() {
    super.initState();
    _bookFuture = DetailBookController().fetchDetailBook(widget.id.toString(), widget.userId.toString());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: FutureBuilder<DetailBook>(
        future: _bookFuture,
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

                      ],
                    ),
                  ),
                  SizedBox(height: 5,),

                  Container(
                    //height: MediaQuery.of(context).size.height * 0.4,
                    width: double.infinity,
                    padding: EdgeInsets.symmetric(vertical: 30, horizontal: 20),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Padding(
                                padding: EdgeInsets.symmetric(vertical: 5),
                                child: ClipRRect(

                                  borderRadius: BorderRadius.circular(15),
                                  child: Image.network(snapshot.data!.url, height: 150, width: 150,),
                                )
                            ),
                            Column(
                              children: [
                                Text(
                                  'Mã đơn đặt: HBCP_${snapshot.data!.id.toString()}',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 15,
                                    color: Color(0xFF475269),
                                  ),
                                ),
                                SizedBox(height: 10,),
                                Text(
                                  snapshot.data!.service_name,
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 25,
                                    color: Color(0xFF475269),
                                  ),
                                ),
                                SizedBox(height: 10,),
                                Text(
                                  "Trạng thái đơn đặt: ${snapshot.data!.status_book} ",
                                  style: TextStyle(
                                    color: Color(0xFF475269),
                                    fontSize: 15,
                                    fontWeight: FontWeight.w500,
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
                            Container(
                              child: Icon(
                                Icons.monetization_on_outlined,
                                color: Color(0xFF028512),
                                size: 20,
                              ),
                            ),
                            SizedBox(width: 15,),
                            Text(
                              'Giá vé đã đặt: ${snapshot.data!.total_cost.toString()} VNĐ',
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
                                CupertinoIcons.ticket,
                                color: Color(0xFF028512),
                                size: 20,
                              ),
                            ),
                            SizedBox(width: 15,),
                            Text(
                              "Buổi(loại vé): ${snapshot.data!.type_of_day}",
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
                                Icons.remove,
                                color: Color(0xFF028512),
                                size: 20,
                              ),
                            ),
                            SizedBox(width: 15,),
                            Text(
                              "Số người lớn: ${snapshot.data!.number_of_adults}",
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
                                Icons.arrow_forward_outlined,
                                color: Color(0xFF028512),
                                size: 20,
                              ),
                            ),
                            SizedBox(width: 15,),
                            Text(
                              "Từ ngày: ${snapshot.data!.start_date}",
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
                                Icons.arrow_back_outlined,
                                color: Color(0xFF028512),
                                size: 20,
                              ),
                            ),
                            SizedBox(width: 15,),
                            Text(
                              "Đến ngày: ${snapshot.data!.end_date}",
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
                                CupertinoIcons.location_solid,
                                color: Color(0xFF028512),
                                size: 20,
                              ),
                            ),
                            SizedBox(width: 15,),
                            Text(
                              "Địa chỉ: ${snapshot.data!.address} - ${snapshot.data!.ward}\n - ${snapshot.data!.district} - ${snapshot.data!.city}",
                              style: TextStyle(
                                color: Color(0xFF475269),
                                fontSize: 15,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 20,),




                      ],
                    ),
                  ),
                  const SizedBox(height: 8),
                  Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          GestureDetector(
                            onTap: () {
                              // Navigate to the booking page
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => UpdateBookingScreen(id: widget.id.toString(),),
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
                                    "Sửa",
                                    style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 20,
                                      color: Colors.white,
                                    ),
                                  ),
                                  SizedBox(width: 10),

                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              primary: Colors.blue,
                              onPrimary: Colors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                            ),
                            onPressed: () async{
                                DetailBookController().cancelBooking(widget.id);
                                setState(() {
                                  _bookFuture = DetailBookController().fetchDetailBook(widget.id, widget.userId);
                                });

                            },
                            child: const Padding(padding: EdgeInsets.symmetric(vertical: 15, horizontal: 15),
                              child: Text('Hủy', style: TextStyle(fontSize: 20),),)

                          ),


                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          GestureDetector(
                            onTap: () {
                              // Navigate to the booking page
                              Navigator.push(
                                context,
                                MaterialPageRoute(

                                  builder: (context) => RatingScreen(bookingId: widget.id,serviceId: snapshot.data!.serviceId,customerId: snapshot.data!.customerId,),
                                ),
                              );
                            },
                            child: Container(
                              padding: EdgeInsets.symmetric(vertical: 15, horizontal: 30),
                              decoration: BoxDecoration(
                                color: Color(0xFFB4501B),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Row(
                                children: [
                                  Text(
                                    "Đánh giá",
                                    style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 20,
                                      color: Colors.white,
                                    ),
                                  ),
                                  SizedBox(width: 10),

                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],),),
                  SizedBox(height: 10,),



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
