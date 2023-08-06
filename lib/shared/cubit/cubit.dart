import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:udemy_flutter/modules/modules.archived_tasks/archived_tasks_screen.dart';
import 'package:udemy_flutter/shared/cubit/states.dart';

import '../../modules/modules.done_tasks/done_tasks_screen.dart';
import '../../modules/modules.new_tasks/new_tasks_screen.dart';

class AppCubit extends Cubit<AppSates> {

  AppCubit() : super( AppInitialSates() );

  static AppCubit get(context) => BlocProvider.of(context);

List<Widget> screens = [
    const NewTasksScreen(),
    const DoneTasksScreen(),
    const ArchivedTasksScreen(),
  ];

  List<String> titles = [
    'New Tasks',
    'Done Tasks',
    'Archived Tasks',
  ];

  int currentIndex = 0;

  void changeIndex( int index){
    currentIndex = index;
    emit(AppChangeNavBarSates());
  }

}

