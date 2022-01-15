class Product {
  String name;
  String libele;
  String ImgSrc;
  int quantity;
  String price;

  Product(this.name, this.libele,this.ImgSrc, this.quantity, this.price);

  factory Product.fromJson(Map<String, dynamic> json) {
    return new Product(
        json['name'],json['libele'], json['ImgSrc'], json['quantity'], json['price']);
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'libele': libele,
      'ImgSrc': ImgSrc,
      'quantity': quantity,
      'price': price,
    };
  }


}