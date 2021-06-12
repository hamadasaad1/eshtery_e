/*


"status": true,
"message": "تم تسجيل الدخول بنجاح",
"data": {
"id": 1089,
"name": "Hamada",
"email": "hamada12@gmail.com",
"phone": "011232323",
"image": "https://student.valuxapps.com/storage/uploads/users/Lejn7ugfqp_1622585096.jpeg",
"points": 0,
"credit": 0,
"token": "IYvFgKFW8LREndz6nhECXViPK9DEyTyxXLEdFKVm45UUoUXYhGYHaGZkRJmE7tkJR6ZHrj"
}
}*/



class UserModel {
  bool status;
  String message;
  UserData data;

  UserModel({this.status, this.message, this.data});

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        status: json['status'],
        message: json['message']??"",
        data: json['data'] != null ? UserData.fromJson(json["data"]) : null,
      );
}

class UserData {
  int id;
  String name;
  String email;
  String phone;
  String image;
  int points;
  int credit;
  String token;

  UserData({
    this.id,
    this.name,
    this.email,
    this.phone,
    this.image,
    this.points,
    this.credit,
    this.token,
  });

  factory UserData.fromJson(Map<String, dynamic> json) => UserData(
        id: json['id'],
        name: json['name'],
        image: json['image'],
        email: json['email'],
        phone: json['phone'],
        points: json['points'],
        credit: json['credit'],
        token: json['token'],
      );
}
