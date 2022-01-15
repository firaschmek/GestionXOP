class CommandItemEntity {
  String name;
  String libele;
  String ImgSrc;
  int quantity;
  String price;

  CommandItemEntity(this.name, this.libele,this.ImgSrc, this.quantity, this.price);

  factory CommandItemEntity.fromJson(Map<String, dynamic> json) {
    return new CommandItemEntity(
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