import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:hoabactravel/controllers/ListRatingController.dart';
import 'package:hoabactravel/models/BookTicket.dart';
import 'package:hoabactravel/models/ListRating.dart';

import '../controllers/BookTicketController.dart';
import '../utils/LoginProvider.dart';
import 'book_ticket_screen.dart';
import 'package:provider/provider.dart';

class ListRatingScreen extends StatefulWidget {
  final String? userId;

  const ListRatingScreen({super.key, this.userId});

  @override
  _ListRatingScreenState createState() => _ListRatingScreenState();
}

class _ListRatingScreenState extends State<ListRatingScreen> {
  late Future<List<ListRating>> _ListRatings;
  List<ListRating>? _listRating;

  @override
  void didChangeDependencies() async {
    super.didChangeDependencies();
    _ListRatings = ListRatingController.getListRating(widget.userId);
    _listRating = await _ListRatings;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text(
          "Các dịch vụ đã đánh giá",
          style: TextStyle(color: Color(0xFF475269)),
        ),
      ),
      body: _listRating == null
          ? Center(child: CircularProgressIndicator())
          : ListView.builder(
        itemCount: _listRating?.length,
        itemBuilder: (context, index) {
          return Column(
            children: [
              SizedBox(
                height: 10,
              ),
              Container(
                margin: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                decoration: BoxDecoration(
                  color: Color(0xFFF1F1F1),
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      color: Color(0xFFD9D9D9),
                      blurRadius: 5,
                      offset: Offset(0, 5),
                      spreadRadius: 1,
                    ),
                  ],
                ),
                child: Padding(
                  padding: EdgeInsets.all(15),
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 5),
                    child: TextButton(
                      onPressed: () {},
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Text(
                                'Dịch vụ: ',
                                style: TextStyle(
                                    color: Color(0xFF475269), fontSize: 20),
                              ),
                              Text(
                                _listRating?[index].service_name ?? '',
                                style: TextStyle(
                                    color: Color(0xFF000000), fontSize: 20),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Row(
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: Image.network(
                                  _listRating?[index].url ?? '',
                                  width: 150,
                                ),
                              ),
                              SizedBox(
                                width: 20,
                              ),
                              Column(
                                children: [
                                  Container(
                                    width: 140,
                                    child: Text(
                                      'Ngày sử dụng dịch vụ:',
                                      style: TextStyle(color: Colors.black),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Container(
                                    width: 140,
                                    child: Text(
                                      _listRating?[index].start_date ?? '',
                                      style: TextStyle(color: Colors.black),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Container(
                                    width: 140,
                                    child: RatingBarIndicator(
                                      rating: double.parse(_listRating![index].rate.toString()),
                                      itemCount: 5,
                                      itemSize: 16,
                                      itemBuilder: (context, _) => const Icon(
                                          Icons.star,
                                          color: Colors.amber),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Container(
                                    width: 140,
                                    child: Text(
                                      _listRating?[index].comment ?? '',
                                      style: TextStyle(color: Colors.black),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                      // Tên
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      ),

    );
  }
}
