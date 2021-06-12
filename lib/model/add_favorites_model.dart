class AddFavoritesModel {
  AddFavoritesModel({
    this.status,
    this.message,
  });

  bool status;
  String message;

  factory AddFavoritesModel.fromJson(Map<String, dynamic> json) => AddFavoritesModel(
        status: json["status"]??'',
        message: json["message"]??'',
      );
}

// class Data {
//     Data({
//         this.id,
//         this.product,
//     });

//     int id;
//     Product product;

//     factory Data.fromJson(Map<String, dynamic> json) => Data(
//         id: json["id"],
//         product: Product.fromJson(json["product"]),
//     );

//     Map<String, dynamic> toJson() => {
//         "id": id,
//         "product": product.toJson(),
//     };
// }

// class Product {
//     Product({
//         this.id,
//         this.price,
//         this.oldPrice,
//         this.discount,
//         this.image,
//     });

//     int id;
//     int price;
//     int oldPrice;
//     int discount;
//     String image;

//     factory Product.fromJson(Map<String, dynamic> json) => Product(
//         id: json["id"],
//         price: json["price"],
//         oldPrice: json["old_price"],
//         discount: json["discount"],
//         image: json["image"],
//     );

//     Map<String, dynamic> toJson() => {
//         "id": id,
//         "price": price,
//         "old_price": oldPrice,
//         "discount": discount,
//         "image": image,
//     };
// }
