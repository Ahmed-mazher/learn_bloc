import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:udemy_flutter/shared/cubit/cubit.dart';
import 'package:udemy_flutter/shared/cubit/states.dart';

import '../../shared/componenet/component.dart';

class NewTasksScreen extends StatefulWidget {
  const NewTasksScreen({super.key});

  @override
  State<NewTasksScreen> createState() => _NewTasksScreenState();
}

class _NewTasksScreenState extends State<NewTasksScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppSates>(
        builder: (builderContext, state) {
          var tasks = AppCubit.get(builderContext).tasks;
          tasks = tasks.reversed.toList(); 
          return ListView.separated(
            itemBuilder: (context, index) => buildTaksItem(tasks[index], context),
            separatorBuilder: (context, index) => Padding(
              padding: const EdgeInsetsDirectional.only(
                start: 20.0,
              ),
              child: Container(
                height: 1,
                color: Colors.grey[300],
              ),
            ),
            itemCount: tasks.length,
          );
        },
        listener: (listenerContext, state) {});
  }
}
