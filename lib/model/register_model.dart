
class RegisterModel {
    RegisterModel({
        this.status,
        this.message,
        this.data,
    });

    bool status;
    String message;
    Data data;

    factory RegisterModel.fromJson(Map<String, dynamic> json) => RegisterModel(
        status: json["status"],
        message: json["message"],
        data: Data.fromJson(json["data"]),
    );

 
}

class Data {
    Data({
        this.name,
        this.phone,
        this.email,
        this.id,
        this.image,
        this.token,
    });

    String name;
    String phone;
    String email;
    int id;
    String image;
    String token;

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        name: json["name"]??'',
        phone: json["phone"],
        email: json["email"],
        id: json["id"],
        image: json["image"],
        token: json["token"],
    );

}
