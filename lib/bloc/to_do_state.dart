part of 'to_do_bloc.dart';

@immutable
sealed class ToDoState {}

class InitialToDoState extends ToDoState {}

class LoadingToDoState extends ToDoState {}

class LoadedToDoState extends ToDoState {
  final List<ToDoModel> toDoList;

  LoadedToDoState(this.toDoList);
}

class ErrorToDoState extends ToDoState {
  final String errorMessage;

  ErrorToDoState(this.errorMessage);
}
