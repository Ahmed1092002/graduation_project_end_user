class ChatModel {
  final int senderId;

  final String senderName;
  // String? massageId;
  List? images ;

  final String message;
  final String time;



  ChatModel({
    required this.senderId,


    this.images,



    required this.message,
    required this.time,
    required this.senderName,
  });

  Map<String, dynamic> toMap() {
    return {
      'senderId': senderId,

      'senderName': senderName,
      'images': images,
      'message': message,

      'time': time,

    };
  }

  factory ChatModel.fromMap(Map<String, dynamic> map, String chatId) {
    return ChatModel(
      senderId: map['senderId'] ?? '',

      images: map['images'] ?? [],
      senderName: map['senderName'] ?? '',
      message: map['message'] ?? '',

      time: map['time'] ?? '',
    );
  }
}