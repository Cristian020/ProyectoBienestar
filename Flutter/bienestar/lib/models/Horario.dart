class DisponibilidadHoraria {
  Map<String, dynamic> _dias;
  Map<String, dynamic> get dias => _dias;

  DisponibilidadHoraria(
      DisponibilidadPorDia lunes, martes, miercoles, jueves, viernes, sabado) {
    _dias = {
      "lunes": lunes.toJson(),
      "martes": martes.toJson(),
      "miercoles": miercoles.toJson(),
      "jueves": jueves.toJson(),
      "viernes": viernes.toJson(),
      "sabado": sabado.toJson()
    };
  }

  //Creo que aquí se podría romper si recibe solo los días y no 'dias' : { 'lunes'...}

  DisponibilidadHoraria.fromMap(Map<String, dynamic> map) {
    _dias = map['dias'];
  }

  Map<String, dynamic> toJson() => {"dias": dias};
}

class DisponibilidadPorDia {
  String _inicio;
  String _fin;

  String get inicio => _inicio;
  String get fin => _fin;

  DisponibilidadPorDia(this._inicio, this._fin);

  Map<String, dynamic> toJson() => {'inicio': inicio, 'fin': fin};
}
