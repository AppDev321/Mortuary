import 'dart:async';
import 'dart:convert';
import 'package:mortuary/core/network/log_debugger_style.dart';
import 'package:web_socket_client/web_socket_client.dart';
import '../enums/socket_enum.dart';

class StreamWebSocket {
  final _socketResponse = StreamController<dynamic>();

  void Function(dynamic) get addResponse => _socketResponse.sink.add;

  Stream<dynamic> get getResponse => _socketResponse.stream;

  void dispose() {
    _socketResponse.close();
  }
}

class WebSocketService {
  late WebSocket channel;
  StreamWebSocket streamSocket = StreamWebSocket();
  late bool isConnected ;

  void connect() {
    var uri = Uri.parse('wss://stream.binance.com:9443/ws');
    var backoff = LinearBackoff(
      initial: const Duration(seconds: 0),
      increment: const Duration(seconds: 1),
      maximum: const Duration(seconds: 10),
    );
    channel = WebSocket(uri, backoff: backoff);

    listenForMessages();
  }

  void listenForMessages() {
    channel.messages.listen(
      (event) {
        streamSocket.addResponse(event);
      },
      onDone: () {
        logDebug("Websocket OnDone called");
      },
      onError: (err) {
        logDebug("Websocket error =>\n$err");
     //   onError(err.toString());
      },
    );

    channel.connection.listen((state) {
      isConnected = false;
      if (state is Connected) {
        var streaming = setSocketDataState(SocketStates.CONNECTED, "");
        streamSocket.addResponse(jsonEncode(streaming));
        isConnected = true;
      } else if (state is Reconnected) {
        var streaming = setSocketDataState(SocketStates.RECONNECTED, "");
        streamSocket.addResponse(jsonEncode(streaming));
      } else if (state is Disconnected) {
        var streaming = setSocketDataState(SocketStates.DISCONNECT, "");
        streamSocket.addResponse(jsonEncode(streaming));
      } else if (state is Reconnecting) {
        var streaming = setSocketDataState(SocketStates.RECONNECTING, "");
        streamSocket.addResponse(jsonEncode(streaming));
      }
    });
  }

  void sendMessage(dynamic message) {
    logDebug('Sending Message to Socket: $message');
    channel.send(message);
  }

  Map<String, dynamic> setSocketDataState(SocketStates state, dynamic data) {
    return {"type": "WebSocket", "state": state.name, "error": data};
  }
}
