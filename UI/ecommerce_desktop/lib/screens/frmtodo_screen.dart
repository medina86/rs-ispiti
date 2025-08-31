import 'dart:io';

import 'package:ecommerce_desktop/layouts/master_screen.dart';
import 'package:ecommerce_desktop/model/StatusAktivnosti.dart';
import 'package:ecommerce_desktop/model/search_result.dart';
import 'package:ecommerce_desktop/model/todo.dart';
import 'package:ecommerce_desktop/model/user.dart';
import 'package:ecommerce_desktop/providers/todo_provider.dart';
import 'package:ecommerce_desktop/providers/user_provider.dart';
import 'package:ecommerce_desktop/screens/product_details_screen.dart';
import 'package:ecommerce_desktop/screens/todonew_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

class ToDoAll extends StatefulWidget {
  const ToDoAll({super.key});

  @override
  State<ToDoAll> createState() => _ToDoAllState();
}

class _ToDoAllState extends State<ToDoAll> {
  SearchResult<ToDo>? todos;
  TodoProvider? provider;
  UserProvider? userProvider;
  Map<String, dynamic> filter = {"retrieveAll": true, "totalCount": 20};
  bool isLoading = true;
  List<User>? users;
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (provider == null) {
      provider = Provider.of<TodoProvider>(context, listen: false);
      _loadData();
    }
  }

  _loadData() async {
    todos = await provider!.get(filter: filter);
    users ??=
        await Provider.of<UserProvider>(context, listen: false).getUsers({});
    setState(() {
      isLoading = false;
    });
    print(todos);
  }

  @override
  Widget build(BuildContext context) {
    return MasterScreen(
        title: "To do List",
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Center(
            child: Column(
              spacing: 20,
              children: [_buildNew(), _buildForm(), _buildResultView()],
            ),
          ),
        ));
  }

  _buildNew() {
    return Align(
      alignment: Alignment.topRight,
      child: ElevatedButton(
          onPressed: () async {
            var result = await Navigator.of(context)
                .push(MaterialPageRoute(builder: (context) => ToDoNew()));
            if (result == true) {
              _loadData();
            }
          },
          child: Text("Dodaj novu aktivnost")),
    );
  }

  _buildForm() {
    return FormBuilder(
      child: Column(
        children: [
          FormBuilderDropdown(
            name: "status",
            items: [
              DropdownMenuItem(value: null, child: Text("All")),
              ...StatusAktivnosti.values
                  .map((status) => DropdownMenuItem(
                        value: status,
                        child: Text(status.name),
                      ))
                  .toList()
            ],
            onChanged: (value) {
              filter["status"] = value?.index;
              _loadData();
            },
          ),
          FormBuilderDateTimePicker(
            name: "rok",
            decoration: InputDecoration(labelText: "Datum realizacije"),
            onChanged: (value) => {filter["rok"] = value, _loadData()},
          ),
          FormBuilderDropdown(
            name: "userId",
            items: users
                    ?.map((u) => DropdownMenuItem(
                          value: u.id,
                          child: Text("${u.firstName} ${u.lastName}"),
                        ))
                    .toList() ??[ ],
            onChanged: (value) {
              filter["userId"] = value;
              _loadData();
            },
          )
        ],
      ),
    );
  }

  Widget _buildResultView() {
    return Expanded(
      child: Container(
        width: double.infinity,
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: DataTable(
            columns: const [
              DataColumn(label: Text("Naziv")),
              DataColumn(label: Text("Opis")),
              DataColumn(label: Text("Rok")),
              DataColumn(label: Text("Status")),
              DataColumn(label: Text("User")),
            ],
            rows: todos?.items
                    ?.map((e) => DataRow(
                          cells: [
                            DataCell(Text(e.naziv)),
                            DataCell(Text(e.opis)),
                            DataCell(Text(e.rok)),
                            DataCell(Text(e.status.name)),
                            DataCell(Text(e.user?.firstName ?? "N/A")),
                          ],
                        ))
                    .toList() ??
                [],
          ),
        ),
      ),
    );
  }
}
