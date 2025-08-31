import 'dart:convert';

import 'package:ecommerce_desktop/model/user.dart';
import 'package:ecommerce_desktop/providers/base_provider.dart';
import 'package:http/http.dart' as http;

class UserProvider extends BaseProvider<User> {
  UserProvider() : super("Users");

  Future<List<User>> getUsers(dynamic filter) async {
    var url = "${BaseProvider.baseUrl}$endpoint";
    print(url);
    if (filter != null) {
      var qs = getQueryString(filter);
      url = "$url?$qs";
    }
    var response = await http.get(Uri.parse(url), headers: createHeaders());
    if (isValidResponse(response)) {
      var data = jsonDecode(response.body);
      return List<User>.from(data.map((e) => fromJson(e)));
    } else {
      print("Status: ${response.statusCode}, Body: ${response.body}");
      throw new Exception("unknown error");

    }
  }

  @override
  User fromJson(dynamic json) {
    return User.fromJson(json);
  }
}
