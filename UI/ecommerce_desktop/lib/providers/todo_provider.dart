import 'package:ecommerce_desktop/model/todo.dart';
import 'package:ecommerce_desktop/providers/base_provider.dart';

class TodoProvider extends BaseProvider<ToDo> {
  TodoProvider() : super("todo");

  @override
  ToDo fromJson(json) {
    return ToDo.fromJson(json);
  }
}
