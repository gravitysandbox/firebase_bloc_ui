import 'package:firebase_bloc_ui/src/domain/bloc/array_bloc.dart';
import 'package:firebase_bloc_ui/src/domain/events/array_events.dart';
import 'package:firebase_bloc_ui/src/domain/models/array_state.dart';
import 'package:firebase_bloc_ui/src/domain/repositories/database.dart';
import 'package:firebase_bloc_ui/src/domain/usecases/create_item.dart';
import 'package:firebase_bloc_ui/src/domain/usecases/delete_item.dart';
import 'package:firebase_bloc_ui/src/domain/usecases/read_items.dart';
import 'package:firebase_bloc_ui/src/domain/usecases/update_item.dart';
import 'package:get_it/get_it.dart';

GetIt locator = GetIt.instance;

void initLocator() {
  locator.registerLazySingleton(
      () => ArrayBloc(ArrayState(items: [], event: ArrayEventType.create)));
  locator.registerLazySingleton(() => Database());

  locator.registerLazySingleton(() => ReadItems(
        bloc: locator<ArrayBloc>(),
        database: locator<Database>(),
      ));
  locator.registerLazySingleton(() => CreateItem(
        bloc: locator<ArrayBloc>(),
        database: locator<Database>(),
      ));
  locator.registerLazySingleton(() => UpdateItem(
        bloc: locator<ArrayBloc>(),
        database: locator<Database>(),
      ));
  locator.registerLazySingleton(() => DeleteItem(
        bloc: locator<ArrayBloc>(),
        database: locator<Database>(),
      ));
}
