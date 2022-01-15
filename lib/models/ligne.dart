class Ligne {
  String code_art;
  String prix;
  int qte;

  Ligne(this.code_art, this.prix, this.qte);

  factory Ligne.fromJson(Map<String, dynamic> json) {
    return Ligne(json['code_art'], json['prix'], json['qte']);
  }


  Map toJson() => {
    'code_art': code_art,
    'prix': prix,
    'qte': qte,
  };
}