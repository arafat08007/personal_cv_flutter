class MessageSend {
  //final int id;
  final String name;
  final String email;
  final String subject;
  final String messagebody;

  const MessageSend({ this.name,  this.email, this.subject, this.messagebody});

  factory MessageSend.fromJson(Map<String, dynamic> json) {
    return MessageSend(
      //id: json['id'],
      name: json['name'],
      email: json['email'],
      subject: json['subject'],
      messagebody: json['messagebody'],
    );
  }
}