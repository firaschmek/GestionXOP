import 'Ligne.dart';

class CommandPourEnvoi {
  String cod_cli;

  DateTime com_date;
  List<Ligne> lignes;

  CommandPourEnvoi(this.cod_cli, this.com_date, this.lignes);

  factory CommandPourEnvoi.fromJson(Map<String, dynamic> json) {
    return CommandPourEnvoi(json['cod_cli'], json['com_date'], json['lignes']);
  }


  Map toJson() => {
        'cod_cli': cod_cli,
        'com_date': com_date == null ? null : com_date.toIso8601String(),
        'lignes': lignes,
      };
}
