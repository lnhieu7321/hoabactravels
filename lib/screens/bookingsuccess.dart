import 'package:flutter/material.dart';
import 'package:hoabactravel/controllers/BookingController.dart';
import 'package:hoabactravel/models/BookingModel.dart';
import 'package:intl/intl.dart';

class BookingConfirmationScreen extends StatefulWidget {



  @override
  _BookingConfirmationScreenState createState() =>
      _BookingConfirmationScreenState();
}

class _BookingConfirmationScreenState
    extends State<BookingConfirmationScreen> {
  final _formKey = GlobalKey<FormState>();

  late Future<void> _saveBookingFuture;

  @override
  void initState() {
    super.initState();
    _saveBookingFuture = BookingController() as Future<void>;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Xác nhận đặt vé'),
      ),
      body: FutureBuilder<void>(
        future: _saveBookingFuture,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.check_circle_outline, color: Colors.green, size: 50),
                  Text(
                    'Đặt vé thành công!',
                    style: TextStyle(fontSize: 20),
                  ),
                  SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () => Navigator.pop(context),
                    child: Text('Quay lại'),
                  ),
                ],
              ),
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.error_outline, color: Colors.red, size: 50),
                  Text(
                    'Đặt vé thất bại!',
                    style: TextStyle(fontSize: 20),
                  ),
                  Text(snapshot.error.toString()),
                  SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () => Navigator.pop(context),
                    child: Text('Thử lại'),
                  ),
                ],
              ),
            );
          }
          return Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}
