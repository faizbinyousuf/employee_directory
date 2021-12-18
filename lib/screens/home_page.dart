import 'dart:convert';
import 'dart:developer';

import 'package:employee_directory/models/employee_model.dart';
import 'package:employee_directory/services/api_service.dart';
import 'package:employee_directory/utils/search_util.dart';

import 'package:employee_directory/widgets/employee_card.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<Employee?> _employeeList = [];
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();

    readEmployeesFromShredPreferences();
  }

  getEmployeeList() async {
    _employeeList = await ApiService().getEmployees();
  }

  readEmployeesFromShredPreferences() async {
    setState(() {
      _isLoading = true;
    });
    try {
      SharedPreferences sharedPref = await SharedPreferences.getInstance();
      List<Employee> employees = [];
      String? response = await sharedPref.getString('res');
      if (response == null) {
        await getEmployeeList();
        log('loading from  API');
      } else {
        _employeeList = (json.decode(response) as List)
            .map((i) => Employee.fromJson(i))
            .toList();
        log('loading from  SharedPref');
      }
    } catch (e) {
      print(e);
    }

    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
        actions: [
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
              log('dbd');
              showSearch(
                  context: context,
                  delegate: SearchFunction(employeeList: _employeeList));
            },
          ),
        ],
        elevation: 0,
      ),
      body: _isLoading
          ? Center(child: CircularProgressIndicator())
          : Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                _buildEmployeesList(),
              ],
            ),
    );
  }

  _buildEmployeesList() {
    return Expanded(
      child: ListView.builder(
        itemCount: _employeeList.length,
        itemBuilder: (context, index) {
          return EmployeeCard(employee: _employeeList[index]!);
        },
      ),
    );
  }
}
