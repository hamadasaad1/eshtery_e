class SearchModel {
  SearchModel({
    this.status,
    this.message,
    this.data,
  });

  bool status;
  dynamic message;
  Data data;

  factory SearchModel.fromJson(Map<String, dynamic> json) => SearchModel(
        status: json["status"],
        message: json["message"] ?? '',
        data: Data.fromJson(json["data"]),
      );
}

class Data {
  Data({
    this.currentPage,
    this.searchItem,

    this.total,
  });

  int currentPage;
  List<SearchItem> searchItem;

  dynamic total;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        currentPage: json["current_page"],
        searchItem: List<SearchItem>.from(
            json["data"].map((x) => SearchItem.fromJson(x))),

        total: json["total"],
      );
}

class SearchItem {
  SearchItem({
    this.id,
    this.price,
    this.image,
    this.name,
    this.description,
    this.images,
    this.inFavorites,
    this.inCart,
  });

  dynamic id;
  dynamic  price;
  String image;
  String name;
  String description;
  List<String> images;
  bool inFavorites;
  bool inCart;

  factory SearchItem.fromJson(Map<String, dynamic> json) => SearchItem(
        id: json["id"],
        price: json["price"],
        image: json["image"],
        name: json["name"],
        description: json["description"],
        images: List<String>.from(json["images"].map((x) => x)),
        inFavorites: json["in_favorites"],
        inCart: json["in_cart"],
      );
}
