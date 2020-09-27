// ignore: unused_import
import 'dart:convert';

class Espacio {
  String _nombre;
  String _descripcion;
  String _recomendaciones;
  int _capacidadMaxima;
  int _unidades;
  // ignore: unused_field
  int _unidadesEnUso;
  DisponibilidadHoraria _horario;
  List<Subelemento> _subelementos;

  List<Subelemento> get subelementos => _subelementos;

  String get nombre => _nombre;
  String get descripcion => _descripcion;
  String get recomendaciones => _recomendaciones;
  int get capacidadMaxima => _capacidadMaxima;
  int get unidades => _unidades;
  DisponibilidadHoraria get horario => _horario;

  Map<String, dynamic> toJson() => {
        'nombre': nombre,
        'descripcion': descripcion,
        'recomendaciones': recomendaciones,
        'capacidadMaxima': capacidadMaxima,
        'unidades': unidades,
        'horario': horario,
        'subelementos': subelementos
      };

  Espacio(this._nombre, this._descripcion, this._recomendaciones,
      this._capacidadMaxima, this._unidades, this._horario, this._subelementos);
}

class Subelemento {
  String _nombre;
  String _descripcion;
  bool _disponibilidad;

  String get nombre => _nombre;
  String get descripcion => _descripcion;
  bool get disponibilidad => _disponibilidad;

  Subelemento(this._nombre, this._descripcion, this._disponibilidad);
  Map<String, dynamic> toJson() => {
        'nombre': nombre,
        'descripcion': descripcion,
        'disponibilidad': disponibilidad
      };
}

class Reserva {
  Espacio _elementoReservado;
  String _beneficiario;
  List<String> invitados;
  Espacio get elementoReservado => _elementoReservado;
  String get beneficiario => _beneficiario;
  Reserva(this._elementoReservado, this._beneficiario);

  Map toJson() => {'Elemento': elementoReservado, 'Usuario': beneficiario};
}

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
