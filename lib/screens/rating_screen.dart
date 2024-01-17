import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:line_icons/line_icon.dart';

import '../controllers/RatingController.dart';
import '../models/RatingModel.dart';

class RatingScreen extends StatefulWidget {
  final String? bookingId;
  final String? serviceId;
  final String? customerId;

  const RatingScreen({super.key, this.serviceId, this.bookingId, this.customerId});

  @override
  // ignore: library_private_types_in_public_api
  _RatingScreenState createState() => _RatingScreenState();
}

class _RatingScreenState extends State<RatingScreen> {
  late final int _ratingController;
  final _commentController = TextEditingController();
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: const Text(
            "Đánh giá và nhận xét",
            style: TextStyle(color: Color(0xFF475269)),
          ),
        ),
        body: Padding(
          padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
          child: Column(
            children: [
              RatingBar.builder(
                initialRating: 0,
                minRating: 1,
                maxRating: 5,
                itemBuilder: (context, index) {
                  // Tạo biểu tượng sao
                  return Icon(
                    Icons.star,
                    color: Colors.yellow,
                    size: 10,
                  );
                },
                onRatingUpdate: (value) {
                  _ratingController = value.toInt();
                },
              ),
              SizedBox(
                height: 20,
              ),
              TextFormField(
                decoration: InputDecoration(
                  helperMaxLines: 50,
                  contentPadding:
                      EdgeInsets.only(top: 0.25, bottom: 0.25, left: 20),

                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  //labelText: "Tên",
                ),
                controller: _commentController,
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: Colors.green,
                    ),
                    onPressed: _isLoading
                        ? null
                        : () async {
                            setState(() => _isLoading = true);
                            final rating = Rating(
                              rate: _ratingController,
                              comment: _commentController.text,
                              customersId: int.parse(widget.customerId.toString()),
                              bookingsId:
                                  int.parse(widget.bookingId.toString()),
                              servicesId:
                                  int.parse(widget.serviceId.toString()),
                            );

                            await RatingController()
                                .createRating(rating)
                                .catchError((error) {
                              final rating = Rating(
                                rate: _ratingController,
                                comment: _commentController.text,
                                customersId: int.parse(widget.customerId.toString()),
                                bookingsId:
                                int.parse(widget.bookingId.toString()),
                                servicesId:
                                int.parse(widget.serviceId.toString()),
                              );

                              // Return the new Rating object
                              return rating;
                            });
                            setState(() {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text('Đánh giá thành công')),
                              );
                            });
                            Navigator.pop(context);

                          },
                    child: Text(
                      "Gửi",
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 23,
                        color: Colors.white,
                      ),
                    ),

                  ),
                ],
              ),
            ],
          ),
        ));
  }
}
