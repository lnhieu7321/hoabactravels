import 'package:date_field/date_field.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hoabactravel/controllers/BookingController.dart';
import 'package:hoabactravel/models/BookingModel.dart';
import 'package:intl/intl.dart';

class BookingScreen extends StatefulWidget {
  final String? serviceId;

  const BookingScreen({Key? key, required this.serviceId}) : super(key: key);


  @override
  // ignore: library_private_types_in_public_api
  _BookingScreenState createState() => _BookingScreenState();
}

class _BookingScreenState extends State<BookingScreen> {
  late Future<BookingService> _serviceBookingFuture;
  final BookingController _bookingController = BookingController();




  int _serviceId = 1;
  final int _customerId = 1;
  final String _statusBook = "chờ duyệt";
  @override
  void initState() {
    super.initState();

    _serviceBookingFuture =
        BookingController().fetchServicebooking(widget.serviceId.toString());
    _serviceId = int.parse(widget.serviceId.toString());
  }
  final List<double> prices = [
    100000,
    100000,
    350000,
    500000,
    600000,
    8500000,
  ];

  // Giá vé hiện tại được chọn


  // Tên của các lựa chọn
  final List<String> names = [
    'Sáng',
    'Chiều',
    'Tối(tự mang thức ăn)',
    'Tối(kèm suất ăn)',
    'Cả ngày',
    'Bao khu(ngày)',
  ];
  String _selectedName = "Sáng";

  int _number = 1;
  double total_cost = 0;



  // Ngày đến
  DateTime _selectedArrivalDate = DateTime.now();

  // Ngày đi
  DateTime _selectedDepartureDate = DateTime.now();

  final DateFormat _formatter = DateFormat('dd-MM-yyyy');

  bool validateDateRange(DateTime arrivalDate, DateTime departureDate) {
    if (departureDate.isAfter(arrivalDate)) {
      return true;
    } else {
      return false;
    }
  }

  int getNumberOfDays() {
    // Lấy ngày đi và ngày đến
    DateTime arrivalDate = _selectedArrivalDate;
    DateTime departureDate = _selectedDepartureDate;

    // Tính số ngày
    int soNgay = departureDate.difference(arrivalDate).inDays;

    // Kiểm tra ngày đi và ngày đến
    if (departureDate.isAfter(arrivalDate)) {
      soNgay += 2;
    } else {
      soNgay++;
    }

    return soNgay;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Đặt vé"),
      ),
      body: SafeArea(
        child: FutureBuilder<BookingService>(
          future: _serviceBookingFuture,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return SingleChildScrollView(
                child: Column(
                  children: [
                    // Thông tin dịch vụ
                    Container(
                      height: 100,
                      decoration: BoxDecoration(
                        color: Color(0xFFF1F1F1),
                        boxShadow: [
                          BoxShadow(
                            color: Color(0xFFD9D9D9),
                            blurRadius: 15,
                            spreadRadius: 5,
                          ),
                        ],
                      ),
                      child: Padding(
                        padding: EdgeInsets.symmetric(vertical: 5, horizontal: 15),
                        child: Row(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(15),
                              child: Image.network(
                                snapshot.data!.url,
                                height: 60,
                                width: 90,
                              ),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Text(
                              snapshot.data!.serviceName,
                              style: TextStyle(
                                color: Color(0xFF475269),
                                fontWeight: FontWeight.w500,
                                fontSize: 20,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),

                    SizedBox(
                      height: 15,
                    ),

                    //ô check chọn vé
                    SizedBox(
                      height: 15,
                    ),
                    Text(
                      "Lựa chọn các mục dưới đây theo nhu cầu của bạn",
                      style: TextStyle(fontWeight: FontWeight.w500, fontSize: 15),
                    ),
                    //Chọn loại vé
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
                        padding: EdgeInsets.all(5),
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Text(
                                'Chọn loại vé:',
                                style: TextStyle(
                                    fontSize: 17.0, color: Color(0xFF475269)),
                              ),
                            ),
                            // RadioListTile widget
                            ...names
                                .map((name) => RadioListTile(
                              value: name,
                              groupValue: _selectedName,
                              onChanged: (value) {
                                setState(() {
                                  _selectedName = value!;
                                });
                              },
                              title: Text(
                                'Loại vé: ${name}',
                                style: TextStyle(
                                    fontSize: 16.0,
                                    color: Color(0xFF475269)),
                              ),
                              subtitle: Text(
                                '${prices[names.indexOf(name)]}đ',
                                style: TextStyle(fontSize: 16.0),
                              ),
                            ))
                                .toList(),
                            // Text widget
                          ],
                        ),
                      ),
                    ),
                    //Chọn số người
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
                        child: Column(
                          children: [
                            Text(
                              'Người lớn',
                              style:
                              TextStyle(color: Color(0xFF475269), fontSize: 17),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  '(Từ 12 tuổi trở lên'
                                      'và cao trên 140 cm)',
                                  style: TextStyle(
                                      color: Color(0xFF8D8D8D), fontSize: 13),
                                ),

                                Row(
                                  children: [
                                    // IconButton
                                    IconButton(
                                      icon: Icon(Icons.remove),
                                      color: _number > 1 ? Colors.black : Colors.grey.withOpacity(0.5),
                                      onPressed: _number > 1 ? () {
                                        setState(() {
                                          _number--;
                                        });
                                      }
                                          : null,
                                    ),
                                    // Text
                                    Text(
                                      '$_number',
                                      style: TextStyle(fontSize: 16.0),
                                    ),
                                    // IconButton
                                    IconButton(
                                      icon: Icon(Icons.add),
                                      onPressed: () {
                                        // Increment the number
                                        setState(() {
                                          _number++;
                                        });
                                      },
                                    ),
                                  ],
                                ),

                                // Text widget
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),

                    // chọn ngày đi và ngày đến
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
                        child: Column(
                          children: [
                            Text(
                              'Chọn ngày đến và ngày đi phù hợp nhu cầu của bạn\n'
                                  '(Vui lòng chọn lại ngày đến để tải lại số ngày)',
                              style: TextStyle(color: Color(0xFF475269)),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text("Ngày đến"),
                                Padding(
                                  padding: EdgeInsets.all(15),
                                  child: Container(
                                    height: 40,
                                    width: 180,
                                    child: DateTimeField(
                                      mode: DateTimeFieldPickerMode.date,
                                      initialDate: _selectedArrivalDate,
                                      decoration: InputDecoration(
                                        border: OutlineInputBorder(),
                                        suffixIcon: Icon(Icons.calendar_today),
                                        hintText:
                                        _formatter.format(_selectedArrivalDate),
                                        contentPadding: EdgeInsets.only(
                                            top: 10, bottom: 0, left: 10),
                                      ),
                                      onDateSelected: (DateTime arrivalDate) {
                                        setState(() {
                                          _selectedArrivalDate = arrivalDate;
                                          _selectedDepartureDate =
                                              _selectedArrivalDate;
                                        });
                                      },
                                      selectedDate: null,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text("Ngày đi"),
                                Padding(
                                  padding: EdgeInsets.all(15),
                                  child: Container(
                                    height: 40,
                                    width: 180,
                                    child: DateTimeField(
                                      mode: DateTimeFieldPickerMode.date,
                                      initialDate: _selectedDepartureDate,
                                      // Khởi tạo ngày đi khác
                                      decoration: InputDecoration(
                                        border: OutlineInputBorder(),
                                        suffixIcon: Icon(Icons.calendar_today),
                                        hintText: _formatter
                                            .format(_selectedDepartureDate),
                                        contentPadding: EdgeInsets.only(
                                            top: 10, bottom: 0, left: 10),
                                      ),
                                      onDateSelected: (DateTime departureDate) {
                                        setState(() {
                                          _selectedDepartureDate = departureDate;
                                          if (validateDateRange(
                                              _selectedArrivalDate,
                                              departureDate)) {
                                            _selectedDepartureDate = departureDate;
                                          } else {
                                            _selectedDepartureDate =
                                                _selectedArrivalDate;
                                            Fluttertoast.showToast(
                                                msg:
                                                "Ngày đi chỉ có thể lớn hơn hoặc trùng ngày đến ngày đến!",
                                                toastLength: Toast.LENGTH_SHORT,
                                                gravity: ToastGravity.CENTER,
                                                timeInSecForIosWeb: 1,
                                                backgroundColor: Colors.red,
                                                textColor: Colors.white,
                                                fontSize: 16.0);
                                          }
                                        });
                                      },
                                      selectedDate: null,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),

                    // chọn phương thức thanh toán
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
                        padding: EdgeInsets.all(20),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Chọn phương thức thanh toán',
                                  style: TextStyle(
                                      color: Color(0xFF475269), fontSize: 17),
                                ),
                                SizedBox(),
                              ],
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                SizedBox(),
                                TextButton(
                                  onPressed: () {},
                                  child: Row(
                                    children: [
                                      Text(
                                        'Thanh toán tại quầy',
                                        style: TextStyle(color: Color(0xFF475269)),
                                      ),
                                      Icon(
                                        CupertinoIcons.right_chevron,
                                        size: 15,
                                        color: Color(0xFF475269),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                    // Thành tiền
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
                        padding: EdgeInsets.all(20),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    Text(
                                      'Loại vé đã chọn: ',
                                      style: TextStyle(
                                        color: Color(0xFF475269),
                                      ),
                                    ),
                                    Text(
                                      '${_selectedName}',
                                      style: TextStyle(
                                          color: Color(0xFF069608), fontSize: 16),
                                    ),
                                  ],
                                ),
                                Text(
                                  'đ${prices[names.indexOf(_selectedName)]}',
                                  style: TextStyle(
                                    color: Color(0xFF475269),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Số người',
                                  style: TextStyle(
                                    color: Color(0xFF475269),
                                  ),
                                ),
                                Text(
                                  '$_number',
                                  style: TextStyle(
                                    color: Color(0xFF475269),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Số ngày',
                                  style: TextStyle(
                                    color: Color(0xFF475269),
                                  ),
                                ),
                                Text(
                                  '${getNumberOfDays()}',
                                  style: TextStyle(
                                    color: Color(0xFF475269),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Tổng thanh toán',
                                  style: TextStyle(
                                      color: Color(0xFF475269), fontSize: 18),
                                ),
                                Text(
                                  '${getSum()}',
                                  style: TextStyle(
                                      color: Color(0xFF475269), fontSize: 18),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 15,
                            ),
                            Text(
                              'Giá bao khu không tính số người',
                              style:
                              TextStyle(color: Color(0xFF78839B), fontSize: 15),
                            ),
                          ],
                        ),
                      ),
                    ),

                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      height: 80,
                      decoration: BoxDecoration(
                        color: Color(0xFFF1F1F1),
                        boxShadow: [
                          BoxShadow(
                            color: Color(0xFFD9D9D9),
                            blurRadius: 15,
                            spreadRadius: 5,
                          ),
                        ],
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            flex: 7,
                            child: Container(
                              alignment: Alignment.centerRight,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text('Tổng thanh toán',
                                    style: TextStyle(
                                        color: Color(0xFF475269), fontSize: 18),),
                                  SizedBox(height: 5,),
                                  Text('đ${getSum()}',
                                    style: TextStyle(
                                        color: Color(0xFF475269), fontSize: 18),
                                  ),
                                ],
                              ),
                            ),

                          ),
                          SizedBox(width: 10,),
                          // Child 2: TextButton chiếm 3 phần width
                          Expanded(
                            flex: 3,
                            child: Container(
                              height: 80,
                              color: Color(0xFF93D334),
                              child: TextButton(
                                onPressed: () {
                                  BookingModel bookingModel = BookingModel(
                                    type_of_day: _selectedName,
                                    number_of_adults: _number,
                                    start_date: _selectedArrivalDate,
                                    end_date: _selectedDepartureDate,
                                    total_cost: total_cost,
                                    customers_id: _customerId,
                                    services_id: _serviceId,
                                    status_book: _statusBook,
                                  );

                                  _bookingController.createBooking(bookingModel).then((result) {

                                  }).catchError((error) {
                                    /*print(
                                        'Value: $_selectedName, Type: ${_selectedName.runtimeType}');
                                    print(
                                        'Value: $_number, Type: ${_number.runtimeType}');
                                    print(
                                        'Value: $_selectedArrivalDate, Type: ${_selectedArrivalDate.runtimeType}');
                                    print(
                                        'Value: $_selectedDepartureDate, Type: ${_selectedDepartureDate.runtimeType}');
                                    print(
                                        'Value: $total_cost, Type: ${total_cost.runtimeType}');
                                    print(
                                        'Value: $_serviceId, Type: ${_serviceId.runtimeType}');
                                    print(
                                        'Value: $_customerId, Type: ${_customerId.runtimeType}');
                                    print(
                                        'Value: $_statusBook, Type: ${_statusBook.runtimeType}');*/
                                      throw Exception(error);
                                  });
                                },
                                child: Text("Đặt chỗ",style: TextStyle(color: Colors.white, fontSize: 18),),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
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
    );
  }

  double getSum() {
    if (_selectedName == 'Bao khu(ngày)') {
      double prive_style = prices[names.indexOf(_selectedName)] as double;
      total_cost = prive_style * getNumberOfDays();
      return total_cost;
    } else {
      double prive_style = prices[names.indexOf(_selectedName)] as double;
      total_cost = prive_style * _number * getNumberOfDays();
      return total_cost;
    }
  }
}