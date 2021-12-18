class Famille {
  String cod_fam;
  String lib_fam;
  String image;

  Famille(this.cod_fam, this.lib_fam, this.image);

  factory Famille.fromJson(Map<String, dynamic> json) {
    return Famille(json['cod_fam'], json['lib_fam'], json['image']);
  }


}
