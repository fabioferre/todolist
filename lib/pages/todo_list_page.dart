import 'package:curso/repositories/todo_repository.dart';
import 'package:flutter/material.dart';

import '../models/todo.dart';
import '../widgets/todo_list_item.dart';

class TodoListPage extends StatefulWidget {
  const TodoListPage({Key? key}) : super(key: key);

  @override
  State<TodoListPage> createState() => _TodoListPageState();
}

class _TodoListPageState extends State<TodoListPage> {
  final TextEditingController todoController = TextEditingController();
  final TodoRepository todoRepository = TodoRepository();
  List<Todo> todos = [];
  String? errorText;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    todoRepository.getTodoList().then((value) {
      setState(() {
        todos = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Center(
            child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: todoController,
                      decoration: InputDecoration(
                          border: const OutlineInputBorder(),
                          labelText: 'Adicione uma tarefa',
                          errorText: errorText),
                    ),
                  ),
                  const SizedBox(
                    width: 8,
                  ),
                  ElevatedButton(
                    onPressed: () {
                      String text = todoController.text;
                      if (text.isEmpty) {
                        setState(() {
                          errorText = 'O titulo não pode ser vazio';
                        });
                        return;
                      }
                      setState(() {
                        Todo newTodo =
                            Todo(title: text, dateTime: DateTime.now());
                        todos.add(newTodo);
                        errorText = null;
                      });
                      todoController.clear();
                      todoRepository.saveTodoList(todos);
                    },
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue,
                        padding: EdgeInsets.all(18)),
                    child: const Icon(
                      Icons.add,
                      size: 30,
                    ),
                  )
                ],
              ),
              const SizedBox(height: 16),
              Flexible(
                child: ListView(
                  shrinkWrap: true,
                  children: [
                    for (Todo todo in todos)
                      TodoListItem(todo: todo, onDelete: onDelete)
                  ],
                ),
              ),
              const SizedBox(
                height: 16,
              ),
              Row(
                children: [
                  Expanded(
                    child:
                        Text('Você possui ${todos.length} Tarefas Pendentes'),
                  ),
                  const SizedBox(width: 8),
                  ElevatedButton(
                    onPressed: removeAll,
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue,
                        padding: const EdgeInsets.all(18)),
                    child: const Text('Limpar Tudo'),
                  )
                ],
              ),
            ],
          ),
        )),
      ),
    );
  }

  onDelete(Todo todo) {
    setState(() {
      todos.remove(todo);
    });
    todoRepository.saveTodoList(todos);
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text('Tarefa ${todo.title} foi removida com sucesso'),
      action: SnackBarAction(
        label: 'Desfazer',
        onPressed: () {
          setState(() {
            todos.add(todo);
          });
        },
      ),
    ));
  }

  removeAll() {
    setState(() {
      todos = [];
    });
    todoRepository.saveTodoList(todos);
  }
}
