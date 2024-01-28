import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hoabactravel/controllers/SearchController.dart';
import 'package:hoabactravel/models/SearchModel.dart';
import 'package:provider/provider.dart';

import '../design_home_app_theme.dart';
import '../utils/LoginProvider.dart';
import 'DetailItemScreen.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController _searchController = TextEditingController();
  final searchController = SearchController();
  late Future<List<SearchModel>> _searchModel;
  final _isLoading = false;

  void initState() {
    super.initState();

  }

  @override
  Widget build(BuildContext context) {
    final userId = context.read<LoginProvider>().userId;
    return Scaffold(
      backgroundColor: Color(0xFFF2F5FA),
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 8.0, left: 18),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.85,
                    height: 54,
                    child: Padding(
                      padding:
                          const EdgeInsets.only(top: 8, bottom: 8, left: 15),
                      child: Container(
                        decoration: const BoxDecoration(
                          color: Color(0xFFF2F5FA),
                          borderRadius: BorderRadius.only(
                            bottomRight: Radius.circular(13.0),
                            bottomLeft: Radius.circular(13.0),
                            topLeft: Radius.circular(13.0),
                            topRight: Radius.circular(13.0),
                          ),
                        ),
                        child: Row(
                          children: <Widget>[
                            Expanded(
                              child: Container(
                                color: Color(0xFFFFFFFF),
                                child: TextFormField(
                                  controller: _searchController,
                                  style: const TextStyle(
                                    fontFamily: 'WorkSans',
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                    color: DesignHomeAppTheme.nearlyBlue,
                                  ),
                                  keyboardType: TextInputType.text,
                                  decoration: const InputDecoration(
                                    labelText: 'Tìm kiếm địa điểm',
                                    border: OutlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.black),
                                    ),
                                    labelStyle: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 20,
                                      letterSpacing: 0.2,
                                      color: Color(0xFFA2A1A1),
                                    ),
                                  ),
                                  onEditingComplete: () {},
                                ),
                              ),
                            ),

                          ],
                        ),
                      ),
                    ),
                  ),
                  const Expanded(
                    child: SizedBox(),
                  )
                ],
              ),
            ),
            SizedBox(height: 10,),

            Text("Kết quả tìm kiếm", style: TextStyle(fontSize: 18),),
            SizedBox(height: 10,),
            Flexible(
              child: StreamBuilder<List<SearchModel>?>(
                stream: SearchServiceController.getSearch(_searchController.text).asStream(),
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
                                    padding: EdgeInsets.all(10),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(10),
                                      child: Image.network(
                                        snapshot.data?[index].url ?? '',
                                        fit: BoxFit.fitHeight,
                                        height: 130,
                                        width: 130,
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
            ),

            // Results list

          ],
        ),
      ),
    );
  }
}
