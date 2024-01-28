import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:hoabactravel/models/DetailBook.dart';
import 'package:hoabactravel/screens/rating_screen.dart';
import 'package:hoabactravel/screens/update_book_screen.dart';

import '../constants.dart';
import '../controllers/DetailBookController.dart';

class BookTicketScreen extends StatefulWidget {
  final String id;
  final String? userId;

  const BookTicketScreen({Key? key, required this.id, this.userId})
      : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _BookTicketScreenState createState() => _BookTicketScreenState();
}

class _BookTicketScreenState extends State<BookTicketScreen> {
  late Future<DetailBook> _bookFuture;
  late ElevatedButton btnSua;
  late ElevatedButton btnHuy;
  late ElevatedButton btnDanhgia;

  @override
  void initState() {
    super.initState();
    _bookFuture = DetailBookController()
        .fetchDetailBook(widget.id.toString(), widget.userId.toString());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: FutureBuilder<DetailBook>(
          future: _bookFuture,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              Widget _buildSuaButton() {
                return Visibility(
                  visible: snapshot.data!.status_book == "chờ duyệt",
                  child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: Color(0xFF028512),
                        onPrimary: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => UpdateBookingScreen(
                              id: widget.id.toString(),
                              userId: widget.userId.toString(),
                            ),
                          ),
                        );
                      },
                      child: const Padding(
                        padding:
                            EdgeInsets.symmetric(vertical: 15, horizontal: 15),
                        child: Text(
                          'Sửa',
                          style: TextStyle(fontSize: 20),
                        ),
                      )),
                );
              }

              Widget _buildHuyButton() {
                return Visibility(
                  visible: snapshot.data!.status_book == "chờ duyệt",
                  child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: Colors.blue,
                        onPrimary: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                      onPressed: () async {
                        final headers = {'Content-Type': 'application/json'};
                        final url = Uri.parse(
                            baseURL + '/cancelbook.php?id=${widget.id}');
                        final response = await http.put(url, headers: headers);

                        if (response.statusCode == 204) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text('Đã hủy dịch vụ thành công'),
                            ),
                          );
                          Navigator.of(context)
                              .pushReplacement(MaterialPageRoute(
                                  builder: (context) => BookTicketScreen(
                                        id: widget.id,
                                        userId: widget.userId,
                                      )));
                        } else if (response.statusCode == 400) {
                          // Handle the specific error condition
                          final json =
                              jsonDecode(response.body) as Map<String, dynamic>;
                          if (json['error'] == 'Không thể hủy dịch vụ') {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text('Không thể hủy dịch vụ'),
                              ),
                            );
                            //Get.snackbar('Lỗi', 'Không thể hủy dịch vụ');
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(
                                    'Lỗi không xác định, Vui lòng thử lại sau'),
                              ),
                            );
                          }
                        } else if (response.statusCode == 500) {
                          // Cancellation failed
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                  'Có lỗi xảy ra khi hủy dịch vụ, Vui lòng thử lại sau'),
                            ),
                          );
                          //Get.snackbar('Có lỗi xảy ra khi hủy dịch vụ', 'Vui lòng thử lại sau');
                        } else {
                          // Unexpected error
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                  'Lỗi không xác định, Vui lòng thử lại sau'),
                            ),
                          );
                          //Get.snackbar('Lỗi không xác định', 'Vui lòng liên hệ hỗ trợ');
                        }
                      },
                      child: const Padding(
                        padding:
                            EdgeInsets.symmetric(vertical: 15, horizontal: 15),
                        child: Text(
                          'Hủy',
                          style: TextStyle(fontSize: 20),
                        ),
                      )),
                );
              }

              Widget _buildDanhGiaButton() {
                return Visibility(
                  visible: snapshot.data!.status_book == "đã duyệt",
                  child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: Color(0xFFB4501B),
                        onPrimary: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => RatingScreen(
                              bookingId: widget.id,
                              serviceId: snapshot.data!.serviceId,
                              customerId: snapshot.data!.customerId,
                            ),
                          ),
                        );
                      },
                      child: const Padding(
                        padding:
                            EdgeInsets.symmetric(vertical: 15, horizontal: 15),
                        child: Text(
                          'Đánh giá',
                          style: TextStyle(fontSize: 20),
                        ),
                      )),
                );
              }

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
                    SizedBox(
                      height: 5,
                    ),

                    Container(
                      //height: MediaQuery.of(context).size.height * 0.4,
                      width: double.infinity,
                      padding:
                          EdgeInsets.symmetric(vertical: 30, horizontal: 20),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Padding(
                                  padding: EdgeInsets.symmetric(vertical: 5),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(15),
                                    child: Image.network(
                                      snapshot.data!.url,
                                      height: 150,
                                      width: 150,
                                    ),
                                  )),
                              Column(
                                children: [
                                  Text(
                                    snapshot.data!.service_name,
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 25,
                                      color: Color(0xFF475269),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Row(
                                    children: [
                                      Text(
                                        "Mã đơn đặt: ",
                                        style: TextStyle(
                                          color: Color(0xFF475269),
                                          fontSize: 15,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                      Container(
                                        width: 80,
                                        height: 20,
                                        //color: Color(0xFF3C943D),
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(5),
                                          color: Color(0xFF3C943D),
                                        ),
                                        child: Text(
                                          "HBCP_${snapshot.data!.id.toString()}",
                                          style: TextStyle(
                                            color: Color(0xFFFFFFFF),
                                            fontSize: 15,
                                            fontWeight: FontWeight.w500,
                                          ),
                                          textAlign: TextAlign.center,
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Row(
                                    children: [
                                      Text(
                                        "Trạng thái đơn đặt: ",
                                        style: TextStyle(
                                          color: Color(0xFF475269),
                                          fontSize: 15,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                      Container(
                                        width: 80,
                                        height: 20,
                                        //color: Color(0xFF3C943D),
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(5),
                                          color: Color(0xFF3C943D),
                                        ),
                                        child: Text(
                                          "${snapshot.data!.status_book} ",
                                          style: TextStyle(
                                            color: Color(0xFFFFFFFF),
                                            fontSize: 15,
                                            fontWeight: FontWeight.w500,
                                          ),
                                          textAlign: TextAlign.center,
                                        ),
                                      ),
                                    ],
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
                              SizedBox(
                                width: 15,
                              ),
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
                          SizedBox(
                            height: 20,
                          ),
                          Row(
                            children: [
                              Container(
                                child: Icon(
                                  CupertinoIcons.ticket,
                                  color: Color(0xFF028512),
                                  size: 20,
                                ),
                              ),
                              SizedBox(
                                width: 15,
                              ),
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
                          SizedBox(
                            height: 20,
                          ),
                          Row(
                            children: [
                              Container(
                                child: Icon(
                                  Icons.remove,
                                  color: Color(0xFF028512),
                                  size: 20,
                                ),
                              ),
                              SizedBox(
                                width: 15,
                              ),
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
                          SizedBox(
                            height: 20,
                          ),
                          Row(
                            children: [
                              Container(
                                child: Icon(
                                  Icons.arrow_forward_outlined,
                                  color: Color(0xFF028512),
                                  size: 20,
                                ),
                              ),
                              SizedBox(
                                width: 15,
                              ),
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
                          SizedBox(
                            height: 20,
                          ),
                          Row(
                            children: [
                              Container(
                                child: Icon(
                                  Icons.arrow_back_outlined,
                                  color: Color(0xFF028512),
                                  size: 20,
                                ),
                              ),
                              SizedBox(
                                width: 15,
                              ),
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
                          SizedBox(
                            height: 20,
                          ),
                          Row(
                            children: [
                              Container(
                                child: Icon(
                                  CupertinoIcons.location_solid,
                                  color: Color(0xFF028512),
                                  size: 20,
                                ),
                              ),
                              SizedBox(
                                width: 15,
                              ),
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
                          SizedBox(
                            height: 20,
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 8),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          _buildSuaButton(),
                          SizedBox(width: 10,),
                          _buildHuyButton(),
                          _buildDanhGiaButton(),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 10,
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
        ),
      ),

      //bottomNavigationBar: ItemBottomNavBar(),
    );
  }
}
