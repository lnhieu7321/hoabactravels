import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hoabactravel/models/BookTicket.dart';

import '../controllers/BookTicketController.dart';
import '../utils/LoginProvider.dart';
import 'book_ticket_screen.dart';
import 'package:provider/provider.dart';

class HistoryScreen extends StatefulWidget {
  @override
  _HistoryScreenState createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  late Future<List<BookTicket>> _services;
  List<BookTicket>? _bookTickets;

  @override
  void didChangeDependencies() async {
    super.didChangeDependencies();
    final userId = context.read<LoginProvider>().userId;
    _services = ApiBookTicket.getBookTicket(userId);
    _bookTickets = await _services;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final userId = context.read<LoginProvider>().userId;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text(
          "Quản lý đặt chỗ",
          style: TextStyle(color: Color(0xFF475269)),
        ),
      ),
      body: _bookTickets == null
          ? Center(child: CircularProgressIndicator())
          : ListView.builder(
        itemCount: _bookTickets?.length,
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
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => BookTicketScreen(id: _bookTickets![index].id.toString(), userId: userId!.toString(),),
                          ),
                        );
                      },
                      child: Column(
                        children: [
                          Row(
                            children: [

                              Text(
                                _bookTickets?[index].service_name ?? '',
                                style: TextStyle(color: Color(0xFF475269),fontSize: 20),
                              ),
                            ],
                          ),
                          SizedBox(height: 10,),
                          Row(
                            children: [
                              Text(
                                _bookTickets?[index].start_date ?? '',
                                style: TextStyle(color: Color(0xFF475269),fontSize: 15),
                              ),
                              SizedBox(width: 20,),
                              Text(
                                "Giá: ${_bookTickets?[index].total_cost ?? ''}đ",
                                style: TextStyle(color: Color(0xFF475269),fontSize: 15),
                              ),
                            ],
                          ),
                          SizedBox(height: 5,),

                          Row(
                            children: [
                              SizedBox(width: 5,),
                              Text(
                                "Buổi: ${_bookTickets?[index].type_of_day ?? ''}",
                                style: TextStyle(color: Color(0xFF475269),fontSize: 15),
                              ),
                              SizedBox(width: 20,),
                              Text(
                                "${_bookTickets?[index].status_book ?? ''}",
                                style: TextStyle(color: Color(0xFF475269),fontSize: 15),
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
