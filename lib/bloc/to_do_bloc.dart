import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/widgets.dart';
import 'package:todo/domain/todo_api_functions.dart';
import 'package:todo/model/models.dart';

part 'to_do_event.dart';
part 'to_do_state.dart';

class ToDoBloc extends Bloc<ToDoEvent, ToDoState> {
  ToDoApiHelper toDoApiHelper = ToDoApiHelper();

  ToDoBloc(this.toDoApiHelper) : super(InitialToDoState()) {
    on<FetchInitialToDoListEvent>(fetchInitialToDoListEvent);
    on<AddToDoEvent>(addToDoEvent);
    on<UpdateToDoEvent>(updateToDoEvent);
    on<DeleteToDoEvent>(deleteToDoEvent);
  }

  FutureOr<void> fetchInitialToDoListEvent(
      FetchInitialToDoListEvent event, Emitter<ToDoState> emit) async {
    try {
      final toDoList = await toDoApiHelper.fetchToDoList();
      emit(LoadedToDoState(toDoList));
    } catch (error) {
      emit(ErrorToDoState('Fetching Data'));
    }
  }

  Future<void> addToDoEvent(AddToDoEvent event, Emitter<ToDoState> emit) async {
    try {
      await toDoApiHelper.addToDoModel(toDo: event.toDo);
      final updatedList = await toDoApiHelper.fetchToDoList();
      emit(LoadedToDoState(updatedList));
    } catch (error) {
      emit(ErrorToDoState(error.toString()));
    }
  }

  Future<void> updateToDoEvent(
      UpdateToDoEvent event, Emitter<ToDoState> emit) async {
    emit(LoadingToDoState());
    try {
      await toDoApiHelper.updateToDoModel(updatedToDo: event.updatedToDo);
      final updatedList = await toDoApiHelper.fetchToDoList();
      emit(LoadedToDoState(updatedList));
    } catch (error) {
      emit(ErrorToDoState(error.toString()));
    }
  }

  Future<void> deleteToDoEvent(
      DeleteToDoEvent event, Emitter<ToDoState> emit) async {
    emit(LoadingToDoState());
    try {
      await toDoApiHelper.deleteToDoModel(toDoId: event.toDoId);
      final updatedList = await toDoApiHelper.fetchToDoList();
      emit(LoadedToDoState(updatedList));
    } catch (error) {
      emit(ErrorToDoState(error.toString()));
    }
  }
}
