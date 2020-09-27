import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import './models/Reserva.dart' show Reserva;
import 'package:cloud_firestore/cloud_firestore.dart';

class ConsultarReservas extends StatefulWidget {
  @override
  ConsultarReservasState createState() {
    return ConsultarReservasState();
  }
}

class ConsultarReservasState extends State<ConsultarReservas> {
  @override
  Widget build(BuildContext context) {
    debugPrint('ConsultarEspacios listView created');
    return _buildBody(context);
  }
}

Widget _buildBody(BuildContext context) {
  //el StreamBuilder chequea si los snapshots de la coleccion
  //tienen datos. Si sí tienen datos,entonces construye una lista a partir de
  //sus *documentos*

  return StreamBuilder<QuerySnapshot>(
    stream: Firestore.instance.collection('reservas').snapshots(),
    builder: (context, snapshot) {
      if (!snapshot.hasData) return LinearProgressIndicator();

      return _buildList(context, snapshot.data.documents);
    },
  );
}

Widget _buildList(BuildContext context, List<DocumentSnapshot> snapshot) {
  return ListView(
    padding: const EdgeInsets.only(top: 20.0),
    children: snapshot.map((data) => _buildListItem(context, data)).toList(),
  );
}

Widget _buildListItem(BuildContext context, DocumentSnapshot data) {
  //este es el widget de cada elemento individual,
  final reserva = Reserva.fromSnapshot(data);

  return Padding(
    key: ValueKey(reserva.elementoReservado),
    padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
    child: Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(5.0),
      ),
      child: Column(children: [
        ListTile(
          title: Text(reserva.beneficiario),
          subtitle: Text(reserva.elementoReservado.nombre),
          trailing:
              Text("Capacidad: ${reserva.elementoReservado.capacidadMaxima}"),
          // onTap: () => print(record),
        ),
        Row(children: [
          Center(
              child: RaisedButton(
                  onPressed: () {
                    // TODO
                    // Este es el procedimiento para instanciar una reserva:

                    //   Scaffold.of(context).showSnackBar(
                    //       SnackBar(content: Text(jsonEncode(nuevaReserva))));
                    // },
                  },
                  child: Icon(Icons.add))),
          Center(
            child: RaisedButton(
                onPressed: () {
                  // TODO
                  // Este es el procedimiento para instanciar una reserva:

                  //   Scaffold.of(context).showSnackBar(
                  //       SnackBar(content: Text(jsonEncode(nuevaReserva))));
                  // },
                },
                child: Icon(Icons.more_horiz)),
          )
        ])
      ]),
    ),
  );
}
