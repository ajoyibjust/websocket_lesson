class Message {
  final String name;
  final String message;
  final DateTime time;

  Message({required this.name, required this.message, required this.time});

  factory Message.fromJson(Map<String, dynamic> json) {
    return Message(
      name: json['name'],
      message: json['message'],
      time: DateTime.parse(json['time']),
    );
  }

  Map<String, dynamic> toJson() {
    return {'name': name, 'message': message, 'time': time.toIso8601String()};
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'message': message,
      'time': time.millisecondsSinceEpoch,
    };
  }

  factory Message.fromMap(Map<String, dynamic> map) {
    return Message(
      name: map['name'],
      message: map['message'],
      time: DateTime.fromMillisecondsSinceEpoch(map['time']),
    );
  }
}
