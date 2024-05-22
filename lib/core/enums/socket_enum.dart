enum SocketStates {
  CONNECTED,
  CONNECTING,
  CONNECTED_ERROR,
  RECONNECTED,
  RECONNECTING,
  RECONNECT_ATTEMT,
  DISCONNECT,
  PING,
  PONG
}

enum SocketIOEvent { OPEN_ORDER, POSITION_ORDER }

extension SocketEventExtension on SocketIOEvent {
  String get value {
    switch (this) {
      case SocketIOEvent.OPEN_ORDER:
        return 'open-orders';
      case SocketIOEvent.POSITION_ORDER:
        return 'positions-orders';
      default:
        return 'notification';
    }
  }
}
