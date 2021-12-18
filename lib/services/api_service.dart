import 'dart:convert';
import 'dart:developer';

import 'package:employee_directory/models/employee_model.dart';
import 'package:employee_directory/utils/constants.dart';
import 'package:employee_directory/utils/shared_pref.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class ApiService {
  // get all employees from the API

  Future<List<Employee?>> getEmployees() async {
    List<Employee> _employees = [];
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();

      var response = await http.get(Uri.parse(Constants.API_URL));
      if (response.statusCode == 200) {
        prefs.setString('res', response.body);
        _employees = (json.decode(response.body) as List)
            .map((i) => Employee.fromJson(i))
            .toList();
        log(_employees.length.toString());
      }
    } catch (e) {
      print(e);
    }

    return _employees;
  }
}
