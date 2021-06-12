
class FavoritesModel {
    FavoritesModel({
        this.status,
        this.message,
        this.data,
    });

    bool status;
    dynamic message;
    Data data;

    factory FavoritesModel.fromJson(Map<String, dynamic> json) => FavoritesModel(
        status: json["status"],
        message: json["message"]??'',
        data: Data.fromJson(json["data"]),
    );

  
}

class Data {
    Data({
        this.currentPage,
        this.productItem,
        this.firstPageUrl,
        this.from,
        this.lastPage,
        this.lastPageUrl,
        this.nextPageUrl,
        this.path,
        this.perPage,
        this.prevPageUrl,
        this.to,
        this.total,
    });

    int currentPage;
    List<ProductItem> productItem;
    String firstPageUrl;
    int from;
    int lastPage;
    String lastPageUrl;
    dynamic nextPageUrl;
    String path;
    int perPage;
    dynamic prevPageUrl;
    int to;
    int total;

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        currentPage: json["current_page"],
        productItem: List<ProductItem>.from(json["data"].map((x) => ProductItem.fromJson(x))),
        firstPageUrl: json["first_page_url"],
        from: json["from"],
        lastPage: json["last_page"],
        lastPageUrl: json["last_page_url"],
        nextPageUrl: json["next_page_url"],
        path: json["path"],
        perPage: json["per_page"],
        prevPageUrl: json["prev_page_url"],
        to: json["to"],
        total: json["total"],
    );


}

class ProductItem {
    ProductItem({
        this.id,
        this.product,
    });

    int id;
    ProductFavorite product;

    factory ProductItem.fromJson(Map<String, dynamic> json) => ProductItem(
        id: json["id"],
        product: ProductFavorite.fromJson(json["product"]),
    );

   
}

class ProductFavorite {
    ProductFavorite({
        this.id,
        this.price,
        this.oldPrice,
        this.discount,
        this.image,
        this.name,
        this.description,
    });

    int id;
    dynamic price;
    dynamic oldPrice;
    int discount;
    String image;
    String name;
    String description;

    factory ProductFavorite.fromJson(Map<String, dynamic> json) => ProductFavorite(
        id: json["id"],
        price: json["price"].toDouble(),
        oldPrice: json["old_price"],
        discount: json["discount"],
        image: json["image"],
        name: json["name"],
        description: json["description"],
    );


}
