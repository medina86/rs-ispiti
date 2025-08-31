import 'package:ecommerce_desktop/model/StatusAktivnosti.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:provider/provider.dart';
import '../layouts/master_screen.dart';
import '../model/todo.dart';
import '../model/user.dart';
import '../providers/todo_provider.dart';
import '../providers/user_provider.dart';

class ToDoNew extends StatefulWidget {
  const ToDoNew({super.key});

  @override
  State<ToDoNew> createState() => _ToDoNewState();
}

class _ToDoNewState extends State<ToDoNew> {
  final _formKey = GlobalKey<FormBuilderState>();
  bool isLoading = true;
  List<User> users = [];

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _loadUsers();
  }

  _loadUsers() async {
    users = await Provider.of<UserProvider>(context, listen: false).getUsers({});
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) return const Center(child: CircularProgressIndicator());

    return MasterScreen(
      title: "Nova Aktivnost",
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            _buildForm(),
            const SizedBox(height: 20),
            _buildSaveButton(),
          ],
        ),
      ),
    );
  }

  Widget _buildForm() {
    return FormBuilder(
      key: _formKey,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      child: Column(
        children: [
          FormBuilderTextField(
            name: "title",
            decoration: const InputDecoration(labelText: "Naziv aktivnosti"),
            validator: (value) => (value == null || value.isEmpty) ? "Required" : null,
          ),
          FormBuilderTextField(
            name: "description",
            decoration: const InputDecoration(labelText: "Opis aktivnosti"),
            maxLines: 3,
          ),
          FormBuilderDateTimePicker(
            name: "realizationDate",
            decoration: const InputDecoration(labelText: "Datum realizacije"),
            initialDate: DateTime.now(),
            validator: (value) => value == null ? "Required" : null,
          ),
          FormBuilderDropdown(
            name: "userId",
            decoration: const InputDecoration(labelText: "Korisnik"),
            items: users
                .map((u) => DropdownMenuItem<int>(
                      value: u.id,
                      child: Text("${u.firstName} ${u.lastName}"),
                    ))
                .toList(),
            validator: (value) => value == null ? "Required" : null,
          ),
        ],
      ),
    );
  }

  Widget _buildSaveButton() {
    return ElevatedButton(
      onPressed: () async {
        if (_formKey.currentState?.saveAndValidate() ?? false) {
          final values = _formKey.currentState!.value;
          final provider = Provider.of<TodoProvider>(context, listen: false);

          final todoRequest = {
            "naziv": values["title"],
            "opis": values["description"],
            "rok": (values["realizationDate"] as DateTime).toIso8601String(),
            "userId": values["userId"],
            "status": StatusAktivnosti.UToku.index 
          };

          await provider.insert(todoRequest);

          if (mounted) Navigator.pop(context, true); 
        }
      },
      child: const Text("Spremi"),
    );
  }
}
