import 'package:equatable/equatable.dart';

enum NetworkEventType {
  enable,
  disable,
}

abstract class NetworkEvent extends Equatable {
  final NetworkEventType type;
  const NetworkEvent(this.type) : super();
}

class NetworkEnable extends NetworkEvent {
  const NetworkEnable() : super(NetworkEventType.enable);

  @override
  List<Object?> get props => throw UnimplementedError();
}

class NetworkDisable extends NetworkEvent {
  const NetworkDisable() : super(NetworkEventType.disable);

  @override
  List<Object?> get props => throw UnimplementedError();
}