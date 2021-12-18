class SousFamille {
  String cod_fam;
  String cod_s_fam;
  String lib_sfam;
  String image;

  SousFamille(this.cod_fam, this.cod_s_fam,this.lib_sfam, this.image);

  factory SousFamille.fromJson(Map<String, dynamic> json) {
    return SousFamille(json['cod_fam'], json['cod_s_fam'],json['lib_sfam'], json['image']);
  }


}
