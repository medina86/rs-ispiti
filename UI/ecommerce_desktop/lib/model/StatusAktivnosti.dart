import 'package:json_annotation/json_annotation.dart';

enum StatusAktivnosti {
  @JsonValue(0)
  UToku,
  @JsonValue(1)
  Realizovana,
  @JsonValue(2)
  Istekla,
  
}