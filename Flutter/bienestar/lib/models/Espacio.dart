import 'package:cloud_firestore/cloud_firestore.dart';
import './Horario.dart' show DisponibilidadHoraria;

class Espacio {
  String _nombre;
  String _descripcion;
  String _recomendaciones;
  int _capacidadMaxima;
  int _unidades;
  DisponibilidadHoraria _horario;
  List<Subelemento> subelementos;
  DocumentReference reference;

  // getters

  String get nombre => _nombre;
  String get descripcion => _descripcion;
  String get recomendaciones => _recomendaciones;
  int get capacidadMaxima => _capacidadMaxima;
  int get unidades => _unidades;
  DisponibilidadHoraria get horario => _horario;
  // List<Subelemento> get subelementos => _subelementos;

  // Para imprimir o pasar a Firestore
  Map<String, dynamic> toJson() => {
        'nombre': nombre,
        'descripcion': descripcion,
        'recomendaciones': recomendaciones,
        'capacidadMaxima': capacidadMaxima,
        'unidades': unidades,
        'horario': horario
            .toJson() //es necesario hacer el llamado al toJson(). De lo contrario el codec de Firestore no reconoce la referencia.
      };
  //Para instanciar un Espacio a partir de un Map, que retorna Firestore

  Espacio.fromMap(Map<String, dynamic> map, {this.reference}) {
    _nombre = map['nombre'];
    _descripcion = map['descripcion'];
    _recomendaciones = map['recomendaciones'];
    _capacidadMaxima = map['capacidadMaxima'];
    _unidades = map['unidades'];
    _horario = DisponibilidadHoraria.fromMap(map[
        'horario']); // tiene que haber un constructor fromMap en disponibilidad Horaria
  }

  Espacio.fromSnapshot(DocumentSnapshot snapshot)
      : this.fromMap(snapshot.data, reference: snapshot.reference);

  Espacio(this._nombre, this._descripcion, this._recomendaciones,
      this._capacidadMaxima, this._unidades, this._horario,
      {this.subelementos});
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
