import 'package:equatable/equatable.dart';
import 'package:firebase_bloc_ui/src/domain/models/array_state.dart';

enum ArrayEventType {
  create,
  read,
  update,
  delete,
}

abstract class ArrayEvent extends Equatable {
  final ArrayEventType type;
  const ArrayEvent(this.type, [List props = const []]) : super();
}

class ArrayItemCreate extends ArrayEvent {
  final ArrayItem item;

  ArrayItemCreate({required this.item}) : super(ArrayEventType.create, [item]);

  @override
  List<Object?> get props => [item.id, item.title, item.subtitle];
}

class ArrayItemRead extends ArrayEvent {
  final List<ArrayItem> items;

  ArrayItemRead({required this.items}) : super(ArrayEventType.read, [items]);

  @override
  List<Object?> get props => items;
}

class ArrayItemUpdate extends ArrayEvent {
  final ArrayItem item;

  ArrayItemUpdate({required this.item}) : super(ArrayEventType.update, [item]);

  @override
  List<Object?> get props => [item.id, item.title, item.subtitle];
}

class ArrayItemDelete extends ArrayEvent {
  final String id;

  ArrayItemDelete({required this.id}) : super(ArrayEventType.delete, [id]);

  @override
  List<Object?> get props => [id];
}