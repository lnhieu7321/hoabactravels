import 'package:hoabactravel/constants.dart';
import 'package:http/http.dart' as http;

class DeleteRecordFavorite {
  Future<bool> deleteRecord(String id) async {
    // Tạo một biến để lưu trữ id của bản ghi cần xóa
   // var id = id;
    // Gọi hàm `delete_record()` từ API PHP
    var response = await http.post(
        Uri.parse('$baseURL/apidelfavorites.php?id=$id'));
    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }
}