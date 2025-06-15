import 'package:web_socket_channel/web_socket_channel.dart';

class WebSocketServices {
  static late WebSocketChannel channel;
  static void getInstance(String url) {
    channel = WebSocketChannel.connect(Uri.parse(url));
  }
}
