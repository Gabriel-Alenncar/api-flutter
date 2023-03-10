import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:http/http.dart' as http;
import 'package:todo/components/todo.dart';
import 'package:todo/components/dialog.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List todoList = [
    ["jogar", true],
    ["ver flutter", false],
  ];

  final controller = TextEditingController();

  void checkBoxChange(bool? val, int index) {
    setState(() {
      todoList[index][1] = !todoList[index][1];
    });
  }

  void saveTodo() {}

  void createNewTodo() {
    showDialog(
        context: context,
        builder: (context) {
          return DialogBox(
            controller: controller,
            onSave: () => {
              setState(() {
                todoList.add([controller.text, false]);
                controller.clear();
              }),
              Navigator.of(context).pop()
            },
            onCancel: () => Navigator.of(context).pop(),
          );
        });
  }

  void deleteTodo(int index) {
    setState(() {
      todoList.removeAt(index);
    });
  }

  void fetch() async {
    var id = 4;
    Response res = await http.post(
        Uri.http('localhost:5050', '/api/v1/update-task/$id'),
        body: jsonEncode({}),
        headers: {'content-type': 'application/json'});
  }

  void updateTodo(int index) {
    showDialog(
        context: context,
        builder: (context) {
          return DialogBox(
            controller: controller,
            onSave: () => {
              setState(() {
                todoList[index][0] = controller.text;
              }),
              Navigator.of(context).pop()
            },
            onCancel: () => Navigator.of(context).pop(),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        // backgroundColor: Colors.green.shade200,
        appBar: AppBar(
          title: const Text("To - Do"),
          elevation: 0,
          centerTitle: true,
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: createNewTodo,
          child: const Icon(Icons.add),
        ),
        body: Padding(
          padding: const EdgeInsets.only(top: 25),
          child: ListView.builder(
            itemCount: todoList.length,
            itemBuilder: (context, index) {
              return ToDo(
                taskName: todoList[index][0],
                completed: todoList[index][1],
                onChanged: (val) => checkBoxChange(val, index),
                deleteFn: (context) => deleteTodo(index),
                updateFn: (context) => updateTodo(index),
              );
            },
          ),
        ));
  }
}
