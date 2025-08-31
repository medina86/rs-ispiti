import 'package:ecommerce_desktop/model/StatusAktivnosti.dart';
import 'package:ecommerce_desktop/model/user.dart';
import 'package:json_annotation/json_annotation.dart';
part 'todo.g.dart';

@JsonSerializable()
class ToDo {
  int id;
  String naziv;
  String opis;
  String rok;
  StatusAktivnosti status;
  int? userId;
  User? user;


  ToDo(
      {required this.id,
      this.naziv = "",
      this.opis = "",
      this.rok = "",
      this.status = StatusAktivnosti.UToku,
      this.userId});

  factory ToDo.fromJson(Map<String, dynamic> json) => _$ToDoFromJson(json);
  Map<String, dynamic> toJson() => _$ToDoToJson(this);
}
