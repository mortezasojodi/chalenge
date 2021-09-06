class Contact {
  final int? Id;
  final String? Name;
  final String? Token;
  const Contact({this.Id, this.Name, this.Token});

  Contact.fromMap(Map<String, dynamic> map)
      : Name = "${map['name']}",
        Token = "${map['token']}",
        Id = map['id'];
}
