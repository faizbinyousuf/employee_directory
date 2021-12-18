import 'package:employee_directory/models/employee_model.dart';
import 'package:employee_directory/screens/employee_detail.dart';
import 'package:employee_directory/widgets/employee_card.dart';
import 'package:flutter/material.dart';

class SearchFunction extends SearchDelegate<String> {
  SearchFunction({required this.employeeList});
  List<Employee?> employeeList;

  List<Employee?> _searchResults = [];

  @override
  List<Widget> buildActions(BuildContext context) => [
        IconButton(
          icon: Icon(Icons.clear),
          onPressed: () {
            query = '';
          },
        )
      ];

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: AnimatedIcon(
        icon: AnimatedIcons.menu_arrow,
        progress: transitionAnimation,
      ),
      onPressed: () {
        close(context, '');
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    if (query.isEmpty) {
      return Container();
    }
    _searchResults.clear();

    for (var i = 0; i < employeeList.length; i++) {
      if (employeeList[i]!.name!.toLowerCase().contains(query.toLowerCase())) {
        _searchResults.add(employeeList[i]!);
      }
    }
    if (_searchResults.isEmpty) {
      return Container(
        margin: EdgeInsets.only(top: 100),
        child: Center(
          child: Text(
            'No results Matching your search.',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.w500,
            ),
            textAlign: TextAlign.center,
          ),
        ),
      );
    }
    return ListView.builder(
        itemBuilder: (context, index) {
          return EmployeeCard(
            employee: _searchResults[index]!,
          );
        },
        itemCount: _searchResults.length);
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    List<Employee?> suggestionList = query.isEmpty
        ? []
        : employeeList
            .where((item) =>
                item!.name!.toLowerCase().contains(query.toLowerCase()))
            .toList();

    _searchResults = suggestionList;
    return ListView.builder(
      itemBuilder: (context, index) {
        return ListTile(
          onTap: () {
            var route = MaterialPageRoute(
                builder: (context) => EmployeeDetail(
                      employee: suggestionList[index]!,

                      // cartUpdate: () => cart.cartUpdate(),
                    ));
            Navigator.push(context, route);
          },
          // leading: Container(),
          title: RichText(
            text: TextSpan(
              text: suggestionList[index]!.name!.substring(0, query.length),
              style: TextStyle(color: Colors.grey),
              children: [
                TextSpan(
                    text: suggestionList[index]!
                        // .typesList[index]
                        .name!
                        .substring(query.length),
                    style: TextStyle(color: Colors.grey)),
              ],
            ),
          ),
        );
      },
      itemCount: suggestionList.length,
    );
  }
}
