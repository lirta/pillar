import 'package:http/http.dart' as http;
import 'package:path/path.dart';
import 'package:pillar_app/model/Menu.dart';

class ApiHelper {
  // final String baseUrl = "http://127.0.0.1:8000/api";
  final String baseUrl = "http://10.0.2.2:8000/api";

  Future signIn(String username, String password) async {
    var response = await http.post(
      Uri.parse("$baseUrl/login_api"),
      body: <String, String>{
        "username": username,
        "password": password,
      },
    );
    print(response.body + " Data respons");
    return response;
  }

  Future getMenu() async {
    var response = await http.get(Uri.parse("$baseUrl/getmenu"));
    return response;
  }

  Future getCat() async {
    var response = await http.get(Uri.parse("$baseUrl/getket"));
    return response;
  }

  Future getOrderDay() async {
    var response = await http.get(Uri.parse("$baseUrl/getOrder"));
    return response;
  }

  Future getDetailMenu(String menuId) async {
    var response = await http.get(Uri.parse("$baseUrl/detail_menu/$menuId"));
    return response;
  }

  Future hapusMenu(String menuId) async {
    var response = await http.get(Uri.parse("$baseUrl/deleteMenu/$menuId"));
    return response;
  }

  Future addMenu(Menu menu) async {
    print(menu.toAddMenu());
    final String url = "$baseUrl/addMenu";
    var uri = Uri.parse(url);
    var request = http.MultipartRequest("POST", uri);
    if (menu.foto != null) {
      var stream = http.ByteStream(menu.foto.openRead());
      var multipartFile = http.MultipartFile(
          'file', stream.cast(), menu.picLength,
          filename: basename(menu.foto.path));
      request.files.add(multipartFile);
    }
    request.fields.addAll(menu.toAddMenu());
    var response = await request.send();
    return response;
  }
}
