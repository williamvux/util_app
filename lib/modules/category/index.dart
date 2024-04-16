import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:util/enum/index.dart';
import 'package:util/models/constant.dart';
import 'package:util/models/model_box.dart';
import 'package:util/modules/category/bloc/category/category_bloc.dart';
import 'package:util/modules/category/components/item_task.dart';
import 'package:util/modules/category/entities/task.dart';
import 'package:util/modules/category/enum/index.dart';
import 'package:util/modules/category/widgets/box_task.dart';
import 'package:util/modules/category/widgets/dialog_add_task.dart';

class CategoryScreen extends StatefulWidget {
  static const String routeName = 'category';
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
    context.read<IUTaskBloc>().add(
          const LoadingCategory(type: TypeTask.I_U),
        );
  }

  void _toggleCheckedItem({required IUTaskEvent category}) {
    context.read<IUTaskBloc>().add(category);
  }

  void _onAddTask<A extends BoxModel>({required TypeTask typeTask}) {
    if (_taskCtrl.text.trim().isNotEmpty) {
      TaskModel model = TaskModel(
        uuid: Constant.uuid(),
        title: _taskCtrl.text.trim(),
        isChecked: false,
        datetime: Constant.now(),
      );
      GetIt.I<A>().box.add(model);
      context.read<IUTaskBloc>().add(
            const LoadingCategory(
              type: TypeTask.I_U,
            ),
          );
      Navigator.pop(context);
    }
  }

  void _deleteAllTasks() {
    context.read<IUTaskBloc>().add(const DeleteAll(type: TypeTask.I_U));
  }

  void _openDialogAddTask({required TypeTask typeTask, required Color color}) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.0),
          ), //this right here
          child: DialogAddTask(
            taskCtrl: _taskCtrl,
            typeTask: typeTask,
            onAddTask: _onAddTask,
            color: color,
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
    final heightEachBox = (MediaQuery.of(context).size.height - 85) / 2;
    return SafeArea(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        mainAxisSize: MainAxisSize.max,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              BoxTask(
                widthEachBox: widthEachBox,
                heightEachBox: heightEachBox,
                placeholder: 'Important\nUrgent',
                boxColor: Colors.red.shade200,
                deleteAllTasks: _deleteAllTasks,
                typeTask: TypeTask.I_U,
                openDialog: _openDialogAddTask,
                child: BlocBuilder<IUTaskBloc, IUTaskState>(
                  builder: (context, state) {
                    if (state.status == Progress.loaded) {
                      return ListView.builder(
                        itemCount: state.tasks.length,
                        itemBuilder: (BuildContext context, int index) {
                          final task = state.tasks[index];
                          return ItemTask(
                            index: index,
                            task: task,
                            toggleCheckedItem: _toggleCheckedItem,
                          );
                        },
                      );
                    }
                    return const Center(
                      child: SizedBox(
                        width: 20,
                        height: 20,
                        child: CircularProgressIndicator(
                          strokeWidth: 3,
                          color: Colors.white,
                        ),
                      ),
                    );
                  },
                ),
              ),
              BoxTask(
                widthEachBox: widthEachBox,
                heightEachBox: heightEachBox,
                placeholder: 'Important\nNot Urgent',
                boxColor: Colors.green.shade200,
                typeTask: TypeTask.I_NU,
                openDialog: _openDialogAddTask,
                deleteAllTasks: _deleteAllTasks,
                child: const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'data',
                      style: TextStyle(color: Colors.white),
                    ),
                  ],
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              BoxTask(
                placeholder: 'Not Important\nUrgent',
                widthEachBox: widthEachBox,
                heightEachBox: heightEachBox,
                boxColor: Colors.blue.shade200,
                typeTask: TypeTask.NI_U,
                openDialog: _openDialogAddTask,
                deleteAllTasks: _deleteAllTasks,
                child: const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'data',
                      style: TextStyle(color: Colors.white),
                    ),
                  ],
                ),
              ),
              BoxTask(
                widthEachBox: widthEachBox,
                heightEachBox: heightEachBox,
                placeholder: 'Not Important\nNot Urgent',
                boxColor: Colors.amber.shade200,
                typeTask: TypeTask.NI_NU,
                openDialog: _openDialogAddTask,
                deleteAllTasks: _deleteAllTasks,
                child: const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'data',
                      style: TextStyle(color: Colors.white),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
