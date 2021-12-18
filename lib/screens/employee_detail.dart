import 'package:employee_directory/models/employee_model.dart';
import 'package:flutter/material.dart';

class EmployeeDetail extends StatelessWidget {
  const EmployeeDetail({Key? key, required this.employee}) : super(key: key);
  final Employee employee;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Employee Detail'),
      ),
      body: _buildEmployeeDetails(context),
    );
  }

  _buildEmployeeDetails(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          ClipRRect(
            borderRadius: BorderRadius.circular(50),
            child: Container(
              height: 80,
              width: 80,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
              ),
              child: Image.network(
                employee.profileImage ?? '',
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Icon(
                    Icons.error,
                    color: Colors.red,
                  );
                },
              ),
            ),
          ),
          Text(employee.name ?? ''),
          Text(employee.email ?? ''),
          Text(employee.phone ?? ''),
          Text(employee.address!.city ?? ''),
          Text(employee.address!.street ?? ''),
          Text(employee.address!.suite ?? ''),
          Text(employee.address!.zipcode ?? ''),
          Text(employee.company!.name ?? ''),
        ],
      ),
    );
  }
}
