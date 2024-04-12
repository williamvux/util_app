import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:util/enum/index.dart';
import 'package:util/models/model_box.dart';
import 'package:util/modules/category/bloc/category/category_bloc.dart';
import 'package:util/modules/category/entities/task.dart';
import 'package:util/modules/category/widgets/box_task.dart';

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
    context.read<CategoryBloc>().add(const LoadingCategory());
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
    return Scaffold(
      floatingActionButton: FloatingActionButton.small(
        enableFeedback: true,
        onPressed: () {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return Dialog(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0),
                ), //this right here
                child: Padding(
                  padding: const EdgeInsets.only(
                    left: 50,
                    right: 50,
                    top: 50,
                    bottom: 30,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      FractionallySizedBox(
                        widthFactor: 0.9,
                        child: TextField(
                          controller: _taskCtrl,
                          decoration: const InputDecoration(
                            hintText: 'Task',
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      ElevatedButton.icon(
                        onPressed: () {
                          if (_taskCtrl.text.trim().isNotEmpty) {
                            TaskModel model =
                                TaskModel(title: _taskCtrl.text.trim());
                            GetIt.I<IUBox>().box.add(model);
                            Navigator.pop(context);
                          }
                        },
                        icon: const Icon(Icons.edit, size: 20),
                        label: const Text('Save'),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
        child: const Icon(Icons.add),
      ),
      body: SafeArea(
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
                  boxColor: Colors.red.shade400,
                  child: BlocBuilder<CategoryBloc, CategoryState>(
                    builder: (context, state) {
                      if (state.status == Progress.loaded) {
                        return ListView.builder(
                          itemCount: state.tasks.length,
                          itemBuilder: (BuildContext context, int index) {
                            final task = state.tasks[index];
                            return ListTile(
                              dense: true,
                              leading: Checkbox(
                                checkColor: Colors.white,
                                hoverColor: Colors.white,
                                activeColor: Colors.white,
                                value: task.isChecked,
                                onChanged: (bool? isChecked) {},
                              ),
                              title: Text(
                                task.title,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 15,
                                ),
                              ),
                            );
                          },
                        );
                      }
                      return const SizedBox(
                        width: 20,
                        height: 20,
                        child: CircularProgressIndicator(strokeWidth: 1),
                      );
                    },
                  ),
                ),
                BoxTask(
                  widthEachBox: widthEachBox,
                  heightEachBox: heightEachBox,
                  placeholder: 'Important\nNot Urgent',
                  boxColor: Colors.green.shade300,
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
                  boxColor: Colors.amber.shade100,
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
      ),
    );
  }
}
