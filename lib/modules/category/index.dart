import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:util/bootstrap/bloc/orientation/orientation_bloc.dart';
import 'package:util/models/constant.dart';
import 'package:util/models/pair.dart';
import 'package:util/modules/category/bloc/inutask/inutask_bloc.dart';
import 'package:util/modules/category/bloc/iutask/iutask_bloc.dart';
import 'package:util/modules/category/bloc/ninutask/ninutask_bloc.dart';
import 'package:util/modules/category/bloc/niutask/niutask_bloc.dart';
import 'package:util/modules/category/entities/task.dart';
import 'package:util/modules/category/enum/index.dart';
import 'package:util/modules/category/widgets/box_task.dart';
import 'package:util/modules/category/widgets/dialog_add_task.dart';
import 'package:util/modules/category/widgets/inherited_category.dart';

class CategoryScreen extends StatefulWidget {
  static const String routeName = 'tasks';
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
  }) {
    switch (type) {
      case TypeTask.I_U:
        {
          final event = ToggleIUTask(model: task);
          context.read<IUTaskBloc>().add(event);
        }
        break;
      case TypeTask.I_NU:
        {
          final event = ToggleINUTask(model: task);
          context.read<INUTaskBloc>().add(event);
        }
        break;
      case TypeTask.NI_U:
        {
          final event = ToggleNIUTask(model: task);
          context.read<NIUTaskBloc>().add(event);
        }
        break;
      case TypeTask.NI_NU:
        {
          final event = ToggleNINUTask(model: task);
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
    required TaskModel task,
    required List<TaskModel> tasks,
  }) {
    switch (type) {
      case TypeTask.I_U:
        final event = DeleteIUTask(task: task, tasks: tasks);
        context.read<IUTaskBloc>().add(event);
        break;
      case TypeTask.I_NU:
        final event = DeleteINUTask(task: task, tasks: tasks);
        context.read<INUTaskBloc>().add(event);
        break;
      case TypeTask.NI_U:
        final event = DeleteNIUTask(task: task, tasks: tasks);
        context.read<NIUTaskBloc>().add(event);
        break;
      case TypeTask.NI_NU:
        final event = DeleteNINUTask(task: task, tasks: tasks);
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

  Pair<double, double> _changeSize({
    required Orientation orientation,
    required Size size,
    required TargetPlatform platform,
  }) {
    Map<TargetPlatform, int> platformSize = {
      TargetPlatform.android: 111,
      TargetPlatform.linux: 85,
      TargetPlatform.iOS: 155,
    };
    if (orientation == Orientation.portrait) {
      return Pair(
        (size.width - 15) / 2,
        (size.height - (platformSize[platform] ?? 80)) / 2,
      );
    } else {
      return Pair(
        (size.width - (platform == TargetPlatform.iOS ? 150 : 15)) / 2,
        (size.height - 35) / 2,
      );
    }
  }

  @override
  void dispose() {
    _taskCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OrientationBloc, OrientationState>(
      builder: (BuildContext context, OrientationState state) {
        final size = _changeSize(
          orientation: state.orientation,
          size: MediaQuery.of(context).size,
          platform: Theme.of(context).platform,
        );
        final widthEachBox = size.first;
        final heightEachBox = size.second;
        return SafeArea(
          child: InheritedCategory(
            toggleCheckedItem: _toggleCheckedItem,
            deleteAllTasks: _deleteAllTasks,
            deleteTask: _deleteTask,
            openDialogAddTask: _openDialogAddTask,
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
                      typeTask: TypeTask.I_U,
                    ),
                    BoxTask<INUTaskBloc>(
                      widthEachBox: widthEachBox,
                      heightEachBox: heightEachBox,
                      placeholder: 'Important\nNot Urgent',
                      boxColor: Colors.green.shade200,
                      typeTask: TypeTask.I_NU,
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
                    ),
                    BoxTask<NINUTaskBloc>(
                      widthEachBox: widthEachBox,
                      heightEachBox: heightEachBox,
                      placeholder: 'Not Important\nNot Urgent',
                      boxColor: Colors.amber.shade200,
                      typeTask: TypeTask.NI_NU,
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
