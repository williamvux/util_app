import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:util/components/loading.dart';
import 'package:util/components/no_task.dart';
import 'package:util/enum/index.dart';
import 'package:util/modules/history/bloc/todo/todo_bloc.dart';
import 'package:util/modules/history/bloc/toggle/toggle_bloc.dart';
import 'package:util/modules/history/components/item_expanded.dart';

class HistoryScreen extends StatefulWidget {
  static const String routeName = 'history';
  static Route route() {
    return MaterialPageRoute(
      builder: (BuildContext context) => MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => TodoBloc(),
          ),
          BlocProvider(
            create: (context) => ToggleBloc(),
          ),
        ],
        child: const HistoryScreen(),
      ),
      settings: const RouteSettings(name: routeName),
    );
  }

  const HistoryScreen({super.key});

  @override
  State<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  @override
  void initState() {
    super.initState();
    context.read<TodoBloc>().add(const LoadMapTodo());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.yellow.shade50,
      appBar: AppBar(
        backgroundColor: Colors.yellow.shade100,
        title: const Text(
          'History',
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.indigoAccent),
        ),
      ),
      body: SafeArea(
        child: BlocBuilder<TodoBloc, TodoState>(
          builder: (context, state) {
            if (state.status != Progress.loaded) {
              return const Loading();
            }
            if (state.status == Progress.loaded && state.mapTodo.isEmpty) {
              return const NoTask();
            }
            final datetimes = state.mapTodo.keys;
            return ListView.builder(
              itemCount: datetimes.length,
              shrinkWrap: true,
              itemBuilder: (BuildContext context, int index) {
                final datetime = datetimes.elementAt(datetimes.length - index - 1);
                return ItemExpanded(
                  index: index,
                  datetime: datetime,
                  todos: state.mapTodo[datetime]!,
                );
              },
            );
          },
        ),
      ),
    );
  }
}
