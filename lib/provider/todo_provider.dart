import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider_package_example/model/todo_model.dart';

class TodoProvider extends ChangeNotifier{

  final List<TODOModel> _todoList = []; // main todo list

    List<TODOModel> get allTODOList => _todoList;

    void addTodoList(TODOModel todoModel){
      _todoList.add(todoModel);
      notifyListeners();
    }
    void todoStatusChange(TODOModel todoModel){
      final index = _todoList.indexOf(todoModel);
      _todoList[index].toggleCompleted();
      notifyListeners();
    }

    void removeTodoList(TODOModel todoModel){
      final index = _todoList.indexOf(todoModel);
      _todoList.removeAt(index);
      notifyListeners();
    }



}

