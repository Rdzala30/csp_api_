class Manager {
  String? userId;
  String? email;
  String? picture;
  String? name;

  Manager({this.userId, this.email, this.picture, this.name});

  Manager.fromJson(Map<String, dynamic> json) {
    userId = json['user_id'];
    email = json['email'];
    picture = json['picture'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['user_id'] = this.userId;
    data['email'] = this.email;
    data['picture'] = this.picture;
    data['name'] = this.name;
    return data;
  }
}
