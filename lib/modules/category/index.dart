import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:util/models/constant.dart';
import 'package:util/modules/category/bloc/inutask/inutask_bloc.dart';
import 'package:util/modules/category/bloc/iutask/iutask_bloc.dart';
import 'package:util/modules/category/bloc/ninutask/ninutask_bloc.dart';
import 'package:util/modules/category/bloc/niutask/niutask_bloc.dart';
import 'package:util/modules/category/entities/task.dart';
import 'package:util/modules/category/enum/index.dart';
import 'package:util/modules/category/widgets/box_task.dart';
import 'package:util/modules/category/widgets/dialog_add_task.dart';

class CategoryScreen extends StatefulWidget {
  static const String routeName = 'iutask';
  static Route route() {
    return MaterialPageRoute(
      builder: (BuildContext context) => const CategoryScreen(),
      settings: const RouteSettings(name: routeName),
    );
  }

  const CategoryScreen({super.key});

  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  final TextEditingController _taskCtrl = TextEditingController();
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 1)).then((_) {
      context.read<IUTaskBloc>().add(const LoadingIUTasks());
      context.read<INUTaskBloc>().add(const LoadingINUTasks());
      context.read<NIUTaskBloc>().add(const LoadingNIUTasks());
      context.read<NINUTaskBloc>().add(const LoadingNINUTasks());
    });
  }

  void _toggleCheckedItem({
    required TaskModel task,
    required TypeTask type,
    required int index,
    required List<TaskModel> tasks,
  }) {
    switch (type) {
      case TypeTask.I_U:
        {
          final event = ToggleIUTask(
            model: task,
            index: index,
            tasks: tasks,
          );
          context.read<IUTaskBloc>().add(event);
        }
        break;
      case TypeTask.I_NU:
        {
          final event = ToggleINUTask(
            model: task,
            index: index,
            tasks: tasks,
          );
          context.read<INUTaskBloc>().add(event);
        }
        break;
      case TypeTask.NI_U:
        {
          final event = ToggleNIUTask(
            model: task,
            index: index,
            tasks: tasks,
          );
          context.read<NIUTaskBloc>().add(event);
        }
        break;
      case TypeTask.NI_NU:
        {
          final event = ToggleNINUTask(
            model: task,
            index: index,
            tasks: tasks,
          );
          context.read<NINUTaskBloc>().add(event);
        }
        break;
    }
  }

  void _onAddTask({
    required TypeTask typeTask,
    required List<TaskModel> tasks,
  }) {
    if (_taskCtrl.text.trim().isNotEmpty) {
      TaskModel model = TaskModel(
        uuid: Constant.uuid(),
        title: _taskCtrl.text.trim(),
        isChecked: false,
        datetime: Constant.now(),
      );
      switch (typeTask) {
        case TypeTask.I_U:
          {
            context
                .read<IUTaskBloc>()
                .add(AddIUTask(model: model, tasks: tasks));
          }
          break;
        case TypeTask.I_NU:
          {
            context
                .read<INUTaskBloc>()
                .add(AddINUTask(model: model, tasks: tasks));
          }
          break;
        case TypeTask.NI_U:
          {
            context
                .read<NIUTaskBloc>()
                .add(AddNIUTask(model: model, tasks: tasks));
          }
          break;
        case TypeTask.NI_NU:
          {
            context
                .read<NINUTaskBloc>()
                .add(AddNINUTask(model: model, tasks: tasks));
          }
          break;
      }
      Navigator.pop(context);
    }
  }

  void _deleteAllTasks({required TypeTask typeTask}) {
    switch (typeTask) {
      case TypeTask.I_U:
        context.read<IUTaskBloc>().add(const DeleteAllIUTasks());
        break;
      case TypeTask.I_NU:
        context.read<INUTaskBloc>().add(const DeleteAllINUTasks());
        break;
      case TypeTask.NI_U:
        context.read<NIUTaskBloc>().add(const DeleteAllNIUTasks());
        break;
      case TypeTask.NI_NU:
        context.read<NINUTaskBloc>().add(const DeleteAllNINUTasks());
        break;
    }
  }

  void _deleteTask({
    required TypeTask type,
    required int index,
    required List<TaskModel> tasks,
  }) {
    switch (type) {
      case TypeTask.I_U:
        final event = DeleteIUTask(index: index, tasks: tasks);
        context.read<IUTaskBloc>().add(event);
        break;
      case TypeTask.I_NU:
        final event = DeleteINUTask(index: index, tasks: tasks);
        context.read<INUTaskBloc>().add(event);
        break;
      case TypeTask.NI_U:
        final event = DeleteNIUTask(index: index, tasks: tasks);
        context.read<NIUTaskBloc>().add(event);
        break;
      case TypeTask.NI_NU:
        final event = DeleteNINUTask(index: index, tasks: tasks);
        context.read<NINUTaskBloc>().add(event);
        break;
    }
  }

  void _openDialogAddTask({
    required TypeTask typeTask,
    required Color color,
    required List<TaskModel> tasks,
  }) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        final boxRadius = BorderRadius.circular(20.0);
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: boxRadius,
          ), //this right here
          child: DialogAddTask(
            taskCtrl: _taskCtrl,
            typeTask: typeTask,
            onAddTask: _onAddTask,
            color: color,
            boxRadius: boxRadius,
            tasks: tasks,
          ),
        );
      },
    );
  }

  @override
  void dispose() {
    _taskCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final widthEachBox = (MediaQuery.of(context).size.width - 15) / 2;
    final heightEachBox = (MediaQuery.of(context).size.height - 80) / 2;
    return SafeArea(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        mainAxisSize: MainAxisSize.max,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              BoxTask<IUTaskBloc>(
                widthEachBox: widthEachBox,
                heightEachBox: heightEachBox,
                placeholder: 'Important\nUrgent',
                boxColor: Colors.red.shade200,
                deleteAllTasks: _deleteAllTasks,
                typeTask: TypeTask.I_U,
                openDialog: _openDialogAddTask,
                toggleCheckedItem: _toggleCheckedItem,
                deleteTask: _deleteTask,
              ),
              BoxTask<INUTaskBloc>(
                widthEachBox: widthEachBox,
                heightEachBox: heightEachBox,
                placeholder: 'Important\nNot Urgent',
                boxColor: Colors.green.shade200,
                typeTask: TypeTask.I_NU,
                openDialog: _openDialogAddTask,
                deleteAllTasks: _deleteAllTasks,
                toggleCheckedItem: _toggleCheckedItem,
                deleteTask: _deleteTask,
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              BoxTask<NIUTaskBloc>(
                placeholder: 'Not Important\nUrgent',
                widthEachBox: widthEachBox,
                heightEachBox: heightEachBox,
                boxColor: Colors.blue.shade200,
                typeTask: TypeTask.NI_U,
                openDialog: _openDialogAddTask,
                deleteAllTasks: _deleteAllTasks,
                toggleCheckedItem: _toggleCheckedItem,
                deleteTask: _deleteTask,
              ),
              BoxTask<NINUTaskBloc>(
                widthEachBox: widthEachBox,
                heightEachBox: heightEachBox,
                placeholder: 'Not Important\nNot Urgent',
                boxColor: Colors.amber.shade200,
                typeTask: TypeTask.NI_NU,
                openDialog: _openDialogAddTask,
                deleteAllTasks: _deleteAllTasks,
                toggleCheckedItem: _toggleCheckedItem,
                deleteTask: _deleteTask,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
