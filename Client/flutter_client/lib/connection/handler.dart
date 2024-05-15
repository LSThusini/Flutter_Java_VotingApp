import 'dart:async';
import 'dart:io';

class ServerConnection {
  Socket? _socket;
  String _response = '';
  bool _isLogged = false;
  Completer<String> _completer = Completer<String>();

  Future<void> connectToServer() async {
    try {
      _socket = await Socket.connect('10.0.2.2', 9999);
      print('Connected to server');

      _socket!.listen((List<int> data) {
        _response = String.fromCharCodes(data);
        if (_response.startsWith("ADMIN") || _response.startsWith("VOTER")) {
          _isLogged = true;
        } else if (_response.startsWith("FAIL")) {
          _isLogged = false;
        }
        print('Server: $_response');

        // Complete the completer when a response is received
        if (!_completer.isCompleted) {
          _completer.complete(_response);
        }
      }, onDone: () {
        print('Server disconnected');
        _socket!.destroy();
      }, onError: (error) {
        print('Error: $error');
        _socket!.destroy();
        // Complete the completer with an error if not already completed
        if (!_completer.isCompleted) {
          _completer.completeError(error);
        }
      });
    } catch (error) {
      print('Error: $error');
    }
  }

  Future<String> sendRequest(String request) async {
    if (_socket != null) {
      print('Sending request: $request');
      _completer =
          Completer<String>(); // Create a new completer for each request
      _socket!.writeln(request);
      return _completer
          .future; // Return the future that will complete when the response is received
    } else {
      print('Socket is not connected or closed.');
      throw Exception('Socket is not connected or closed.');
    }
  }

  String getResponse() {
    return _response;
  }

  bool getLogged() {
    return _isLogged;
  }
}
