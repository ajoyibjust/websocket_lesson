class Message {
  final String name;
  final String message;
  final DateTime time;

  Message({
    required this.name,
    required this.message,
    required this.time,
  });

  // JSON dan o'qish
  factory Message.fromJson(Map<String, dynamic> json) {
    return Message(
      name: json['name'],
      message: json['message'],
      time: DateTime.parse(json['time']),
    );
  }

  // JSON ga aylantirish
  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'message': message,
      'time': time.toIso8601String(),
    };
  }

  // Hive uchun Map ga aylantirish
  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'message': message,
      'time': time.millisecondsSinceEpoch,
    };
  }

  // Map dan Message yaratish
  factory Message.fromMap(Map<String, dynamic> map) {
    return Message(
      name: map['name'],
      message: map['message'],
      time: DateTime.fromMillisecondsSinceEpoch(map['time']),
    );
  }
}