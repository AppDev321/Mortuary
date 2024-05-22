import 'dart:async';
import 'dart:convert';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'package:socket_io_client/socket_io_client.dart';

import '../constants/app_urls.dart';
import '../enums/socket_enum.dart';

class StreamSocket {
  final _socketResponse = StreamController<dynamic>();

  void Function(dynamic) get addResponse => _socketResponse.sink.add;

  Stream<dynamic> get getResponse => _socketResponse.stream;


  void dispose() {
    _socketResponse.close();
  }
}

class SocketService {
  late IO.Socket socket;
  StreamSocket streamSocket = StreamSocket();

  var isSocketConnected = false;


  void connect() {
    socket = IO.io(AppUrls.socketIOUrl,
        OptionBuilder().setTransports(['websocket']).build());

    socket.onConnect((data) {
      isSocketConnected = true;
      var streaming = setSocketDataState(SocketStates.CONNECTED, data);
      streamSocket.addResponse(streaming);
    });
    socket.onConnecting((data) {
      var streaming = setSocketDataState(SocketStates.CONNECTING, data);
      streamSocket.addResponse(streaming);
    });
    socket.onConnectError((data) {
      var streaming = setSocketDataState(SocketStates.CONNECTED_ERROR, data);
      streamSocket.addResponse(streaming);
    });
    socket.onDisconnect((data) {
      var streaming = setSocketDataState(SocketStates.DISCONNECT, data);
      streamSocket.addResponse(streaming);
    });

    socket.onReconnect((data) {
      var streaming = setSocketDataState(SocketStates.RECONNECTED, data);
      streamSocket.addResponse(streaming);
    });

    socket.onReconnectAttempt((data) {
      var streaming = setSocketDataState(SocketStates.RECONNECT_ATTEMT, data);
      streamSocket.addResponse(streaming);
    });

    socket.onPing((data) {
      var streaming = setSocketDataState(SocketStates.PING, data);
      streamSocket.addResponse(streaming);
    });
    socket.onPong((data) {
      var streaming = setSocketDataState(SocketStates.PONG, data);
      streamSocket.addResponse(streaming);
    });
  }

  void emit(String event, dynamic data) {
    socket.emit(event, data);
  }

  void setEventListener(String event) {
    if (isEventSubscribed(event, socket) == false) {
      socket.on(event, (data) {
        var socketData =  {
          "event":event,
          "data":data
        };
        streamSocket.addResponse(jsonEncode(socketData));
      });
    }
  }

  bool isEventSubscribed(String eventName, IO.Socket socket) {
    return socket.hasListeners(eventName);
  }

  void disconnect() {
    socket.disconnect();
  }

  Map<String, dynamic> setSocketDataState(SocketStates state, dynamic data) {
    if(state == SocketStates.CONNECTED)
      {
        isSocketConnected = true;
      }
    else {
      isSocketConnected = false;
    }
    return {"type": "SocketIO", "state": state, "error": data};
  }
}
