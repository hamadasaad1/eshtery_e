
class CartsUpdateModel {
    CartsUpdateModel({
        this.status,
        this.message,
       
    });

    bool status;
    String message;
   

    factory CartsUpdateModel.fromJson(Map<String, dynamic> json) => CartsUpdateModel(
        status: json["status"],
        message: json["message"],
        
    );

 
}

