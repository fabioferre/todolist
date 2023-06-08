import 'package:curso/models/todo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:intl/intl.dart';

class TodoListItem extends StatelessWidget {
  const TodoListItem({Key? key, required this.todo, required this.onDelete})
      : super(key: key);
  final Todo todo;
  final Function(Todo) onDelete;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Slidable(
        key: const ValueKey(0),
        endActionPane: ActionPane(
          motion: const DrawerMotion(),
          children: [
            // A SlidableAction can have an icon and/or a label.
            SlidableAction(
              flex: 2,
              onPressed: (e) {
                onDelete(todo);
              },
              backgroundColor: Color(0xFFFE4A49),
              foregroundColor: Colors.white,
              icon: Icons.delete,
            ),
          ],
        ),
        child: Row(
          children: [
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(4),
                  color: Colors.grey[200],
                ),
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      DateFormat('dd/MM/yyyy HH:mm').format(todo.dateTime),
                      style: TextStyle(fontSize: 12),
                    ),
                    Text(
                      todo.title,
                      style: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
