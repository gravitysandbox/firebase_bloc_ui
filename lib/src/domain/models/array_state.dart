import 'package:firebase_bloc_ui/src/domain/events/array_events.dart';

import 'array_item.dart';

class ArrayState {
  final List<ArrayItem> items;
  final ArrayEventType event;

  ArrayState({
    required this.items,
    required this.event,
  });

  ArrayState createElement(ArrayItem created) {
    items.add(created);
    return ArrayState(items: items, event: ArrayEventType.create);
  }

  ArrayState readElements(List<ArrayItem> items) {
    return ArrayState(items: items, event: ArrayEventType.read);
  }

  ArrayState updateElement(ArrayItem updated) {
    items[items.indexWhere((item) => item.id == updated.id)] = updated;
    return ArrayState(items: items, event: ArrayEventType.update);
  }

  ArrayState deleteElement(String id) {
    items.removeWhere((item) => item.id == id);
    return ArrayState(items: items, event: ArrayEventType.delete);
  }
}
