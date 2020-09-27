import 'package:flutter/material.dart';
import './models/Espacio.dart' show Espacio, Subelemento;
import './models/Reserva.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:convert';
import 'consultar.espacios.detalle.dart';

class ConsultarEspacios extends StatefulWidget {
  @override
  ConsultarEspaciosFormState createState() {
    return ConsultarEspaciosFormState();
  }
}

class ConsultarEspaciosFormState extends State<ConsultarEspacios> {
  @override
  Widget build(BuildContext context) {
    debugPrint('ConsultarEspacios form created');
    return _buildBody(context);
  }
}

Widget _buildBody(BuildContext context) {
  //el StreamBuilder chequea si los snapshots de la coleccion
  //tienen datos. Si sí tienen datos,entonces construye una lista a partir de
  //sus *documentos*

  return StreamBuilder<QuerySnapshot>(
    stream: Firestore.instance.collection('espacios').snapshots(),
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
  final espacio = Espacio.fromSnapshot(data);

  return Padding(
    key: ValueKey(espacio.nombre),
    padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
    child: Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(5.0),
      ),
      child: Column(children: [
        ListTile(
          title: Text(espacio.nombre),
          subtitle: Text(espacio.descripcion),
          trailing: Text("Capacidad: ${espacio.capacidadMaxima}"),
          // onTap: () => print(record),
        ),
        Row(children: [
          Center(
              child: RaisedButton(
                  onPressed: () {
                    Reserva nuevaReserva = Reserva(espacio, 'admin');
                    Firestore.instance
                        .collection('reservas')
                        .add(nuevaReserva.toJson());

                    debugPrint(
                        'wrote ${nuevaReserva.toJson()['elemento']['nombre']}, ${nuevaReserva.toJson()['usuario']} to Firestore');

                    Scaffold.of(context).showSnackBar(
                        SnackBar(content: Text(jsonEncode(nuevaReserva))));
                  },
                  child: Icon(Icons.add))),
          Center(
            child: RaisedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => VistaDetalle(
                              espacioDetalle: espacio,
                            )),
                  );
                },
                child: Icon(Icons.more_horiz)),
          )
        ])
      ]),
    ),
  );
}
