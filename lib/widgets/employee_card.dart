import 'package:employee_directory/models/employee_model.dart';
import 'package:employee_directory/screens/employee_detail.dart';
import 'package:flutter/material.dart';

class EmployeeCard extends StatelessWidget {
  const EmployeeCard({Key? key, required this.employee}) : super(key: key);
  final Employee employee;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: <Widget>[
          ListTile(
            onTap: () {
              var route = MaterialPageRoute(
                builder: (context) => EmployeeDetail(employee: employee),
              );
              Navigator.push(context, route);
            },
            leading: CircleAvatar(
              radius: 30.0,
              backgroundImage: NetworkImage(
                  employee.profileImage ?? 'https://i.imgur.com/7lkJW9H.png'),
              backgroundColor: Colors.transparent,
            ),
            title: Text(employee.name ?? ''),
            subtitle: Text(employee.email ?? ''),
          ),
        ],
      ),
    );
  }
}
