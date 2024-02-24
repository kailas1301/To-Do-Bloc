part of 'to_do_bloc.dart';

@immutable
sealed class ToDoEvent {}

class FetchInitialToDoListEvent extends ToDoEvent {}

class AddToDoEvent extends ToDoEvent {
  final ToDoModel toDo;

  AddToDoEvent({required this.toDo});
}

class UpdateToDoEvent extends ToDoEvent {
  final ToDoModel updatedToDo;

  UpdateToDoEvent({required this.updatedToDo});
}

class DeleteToDoEvent extends ToDoEvent {
  final String toDoId;

  DeleteToDoEvent({required this.toDoId});
}
