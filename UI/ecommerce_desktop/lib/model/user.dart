import 'package:json_annotation/json_annotation.dart';

part 'user.g.dart';

@JsonSerializable()
class User{
  int id;
  String userName;
  String firstName;
  String lastName;

  User({required this.id, this.userName="", this.firstName="", this.lastName=""});
  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
  Map<String, dynamic> toJson() => _$UserToJson(this);
}