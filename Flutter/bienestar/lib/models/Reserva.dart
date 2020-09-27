import 'package:cloud_firestore/cloud_firestore.dart';

import './Espacio.dart' show Espacio;

class Reserva {
  Espacio _elementoReservado;
  String _beneficiario;
  List<String> invitados;
  Espacio get elementoReservado => _elementoReservado;
  String get beneficiario => _beneficiario;
  DocumentReference reference;
  Reserva(this._elementoReservado, this._beneficiario);

  Map<String, dynamic> toJson() =>
      {'elemento': elementoReservado.toJson(), 'usuario': beneficiario};

  Reserva.fromMap(Map<String, dynamic> map, {this.reference}) {
    _elementoReservado = Espacio.fromMap(map['elemento']);
    _beneficiario = map['usuario'];
  }

  Reserva.fromSnapshot(DocumentSnapshot snapshot)
      : this.fromMap(snapshot.data, reference: snapshot.reference);
}
