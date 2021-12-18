class Article {
  String code_art;
  String lib_art;
  String cod_fam;
  String cod_s_fam;
  String cod_unite;
  String prix;
  String unite;
  String image;

  Article(this.code_art, this.lib_art,this.cod_fam,this.cod_s_fam,this.cod_unite, this.prix,this.unite,this.image);

  factory Article.fromJson(Map<String, dynamic> json) {
    return Article(json['code_art'],
      json['lib_art'],
      json['cod_fam'],
      json['cod_s_fam'],
      json['cod_unite'],
        json['prix'],
        json['unite'],
      json['image']);
  }


}
