import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'model/todo_model.dart';
import 'provider/todo_provider.dart';
import 'package:msh_checkbox/msh_checkbox.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final _textController = TextEditingController();


  Future<void> _dialogBuilder(BuildContext context) {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Add todo list'),
          content: TextField(
            controller: _textController,
            decoration: const InputDecoration(hintText: 'Write your task'),

          ),
          actions: [
            TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text('Cancel'),),
            TextButton(
              onPressed: () {

                if(_textController.text.isEmpty){
                  return;
                }else{
                  context.read<TodoProvider>().addTodoList(TODOModel(title: _textController.text, isCompleted: false));
                }
                _textController.clear();
                Navigator.pop(context);
              },
              child: const Text('Add'),),
          ],
        );
      },
      barrierLabel: 'for a decision to be made.',
    );
  }

  @override
  Widget build(BuildContext context) {
    // we passes the class name of the provider into the of
    final provider = Provider.of<TodoProvider>(context);
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _dialogBuilder(context);
         // print(_textController);
        },
        backgroundColor: Colors.indigo,
        child: const Icon(
          Icons.add,
        ),
      ),
      appBar: AppBar(
        title: const Text('Todo App'),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Column(
          // crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: Container(
                decoration: const BoxDecoration(
                  color: Colors.white,
                ),
                child: Container(
                  width: double.infinity,
                  alignment: Alignment.center,
                  decoration: const BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage('images/pic.jpg'),
                        fit: BoxFit.cover,
                      ),
                      color: Colors.indigo,
                      borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(30.0),
                          bottomRight: Radius.circular(30.0))),
                  child: const Text(
                    'TODO List',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 35.0,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ),
            ),


            Expanded(
              flex: 4,
              child: Container(
                decoration: const BoxDecoration(
                  color: Colors.white,
                ),
                child: ListView.builder(
                  padding: const EdgeInsets.all(20.0),
                  itemBuilder: (context, itemIndex) {
                    return ListTile(
                      leading: MSHCheckbox(
                        size: 40,
                        value: provider.allTODOList[itemIndex].isCompleted,
                        colorConfig: MSHColorConfig.fromCheckedUncheckedDisabled(
                          checkedColor: Colors.indigoAccent,
                        ),
                        style: MSHCheckboxStyle.fillScaleColor,
                        onChanged: (bool selected) {
                          provider.todoStatusChange(provider.allTODOList[itemIndex]);
                        },

                      ),
                      title: GestureDetector(
                        onTap: (){
                          provider.todoStatusChange(provider.allTODOList[itemIndex]);
                        },
                        child: Text(
                          provider.allTODOList[itemIndex].title,
                          style: const TextStyle(
                           // color: Colors.white,
                            fontWeight: FontWeight.w500,
                            fontSize: 25,
                           // decoration:  provider.allTODOList[itemIndex] == true ? TextDecoration.lineThrough : null,

                          ),
                        ),
                      ),
                      trailing: IconButton(
                        onPressed: (){
                          provider.removeTodoList(provider.allTODOList[itemIndex]);
                        },
                        icon: const Icon(Icons.delete_forever,
                        size: 35,),
                      ),

                    ); // ListTile helps to make check box and text
                  },
                  itemCount: provider.allTODOList.length,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // bool checkBool(int itemIndex) {
  //  bool value = context.read<TodoProvider>().allTODOList[itemIndex].isCompleted;
  //  return value;
  //
  // }
}
