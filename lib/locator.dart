import 'package:firebase_bloc_ui/src/domain/bloc/array_bloc.dart';
import 'package:firebase_bloc_ui/src/domain/bloc/network_bloc.dart';
import 'package:firebase_bloc_ui/src/domain/events/array_events.dart';
import 'package:firebase_bloc_ui/src/domain/models/array_state.dart';
import 'package:firebase_bloc_ui/src/domain/repositories/database.dart';
import 'package:firebase_bloc_ui/src/domain/repositories/network.dart';
import 'package:firebase_bloc_ui/src/domain/usecases/create_item.dart';
import 'package:firebase_bloc_ui/src/domain/usecases/delete_item.dart';
import 'package:firebase_bloc_ui/src/domain/usecases/disable_network.dart';
import 'package:firebase_bloc_ui/src/domain/usecases/enable_network.dart';
import 'package:firebase_bloc_ui/src/domain/usecases/read_items.dart';
import 'package:firebase_bloc_ui/src/domain/usecases/update_item.dart';
import 'package:get_it/get_it.dart';

GetIt locator = GetIt.instance;

void initLocator() {
  /// Blocs
  locator.registerLazySingleton(() => ArrayBloc(ArrayState(
        items: [],
        event: ArrayEventType.create,
      )));
  locator.registerLazySingleton(() => NetworkBloc(true));

  /// Repositories
  locator.registerLazySingleton(() => DatabaseImpl());
  locator.registerLazySingleton(() => NetworkImpl(
        enableNetwork: locator<EnableNetwork>(),
        disableNetwork: locator<DisableNetwork>(),
      ));

  /// Usecases
  locator.registerLazySingleton(() => ReadItems(
        bloc: locator<ArrayBloc>(),
        database: locator<DatabaseImpl>(),
      ));
  locator.registerLazySingleton(() => CreateItem(
        bloc: locator<ArrayBloc>(),
        database: locator<DatabaseImpl>(),
      ));
  locator.registerLazySingleton(() => UpdateItem(
        bloc: locator<ArrayBloc>(),
        database: locator<DatabaseImpl>(),
      ));
  locator.registerLazySingleton(() => DeleteItem(
        bloc: locator<ArrayBloc>(),
        database: locator<DatabaseImpl>(),
      ));
  locator.registerLazySingleton(() => EnableNetwork(
        bloc: locator<NetworkBloc>(),
      ));
  locator.registerLazySingleton(() => DisableNetwork(
        bloc: locator<NetworkBloc>(),
      ));
}
