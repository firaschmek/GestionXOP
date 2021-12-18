class Product {
  String name;
  String ImgSrc;
  int quantity;
  String price;

  Product(this.name, this.ImgSrc, this.quantity, this.price);

  factory Product.fromJson(Map<String, dynamic> json) {
    return new Product(
        json['name'], json['ImgSrc'], json['quantity'], json['price']);
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'ImgSrc': ImgSrc,
      'quantity': quantity,
      'price': price,
    };
  }


}
