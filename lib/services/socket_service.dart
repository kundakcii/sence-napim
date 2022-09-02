import 'package:socket_io_client/socket_io_client.dart';
import 'dart:async';

class SocketService {
  Socket socket = io(
      'https://sence-napim.herokuapp.com/',
      OptionBuilder().setTransports(['websocket']) // for Flutter or Dart VM
          .build());
  Future<void> connection({required String userId}) async {
    socket.onConnect((_) {
      socket.emit('userId', userId);
    });
  }
}
