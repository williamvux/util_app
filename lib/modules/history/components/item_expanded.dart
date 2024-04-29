import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:util/extension/string.dart';
import 'package:util/modules/history/bloc/toggle/toggle_bloc.dart';
import 'package:util/modules/todolist/entities/todo.dart';

class ItemExpanded extends StatefulWidget {
  final int index;
  final String datetime;
  final List<TodoModel> todos;
  const ItemExpanded({
    super.key,
    required this.datetime,
    required this.index,
    required this.todos,
  });

  @override
  State<ItemExpanded> createState() => _ItemExpandedState();
}

class _ItemExpandedState extends State<ItemExpanded> {
  bool isOpen = false;
  @override
  Widget build(BuildContext context) {
    return BlocListener<ToggleBloc, ToggleState>(
      listener: (context, state) {
        if (state.datetime == widget.datetime) {
          setState(() {
            isOpen = !isOpen;
          });
        } else {
          if (isOpen) {
            setState(() {
              isOpen = false;
            });
          }
        }
      },
      child: ExpansionPanelList(
        expandIconColor: Colors.indigoAccent,
        expandedHeaderPadding: const EdgeInsets.symmetric(vertical: 5),
        children: [
          ExpansionPanel(
            canTapOnHeader: true,
            headerBuilder: (BuildContext context, bool isExpanded) {
              return Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(width: 20),
                  Text(
                    widget.datetime,
                    style: const TextStyle(color: Colors.indigo, fontWeight: FontWeight.bold),
                  ),
                ],
              );
            },
            body: Padding(
              padding: const EdgeInsets.only(left: 20, right: 8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: widget.todos.map((TodoModel todo) {
                  return Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        todo.title.capitalize(),
                        style: const TextStyle(color: Colors.black87, fontWeight: FontWeight.w500),
                      ),
                      Checkbox(value: todo.isChecked, onChanged: null),
                    ],
                  );
                }).toList(),
              ),
            ),
            isExpanded: isOpen,
          )
        ],
        expansionCallback: (int panelIndex, bool isExpanded) {
          context.read<ToggleBloc>().add(ToggleEvent(datetime: widget.datetime));
        },
      ),
    );
  }
}
