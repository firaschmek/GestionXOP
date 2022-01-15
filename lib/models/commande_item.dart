class CommandItem {
  String name;
  String libele;
  String ImgSrc;
  int quantity;
  String price;

  CommandItem(this.name, this.libele,this.ImgSrc, this.quantity, this.price);

  factory CommandItem.fromJson(Map<String, dynamic> json) {
    return new CommandItem(
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