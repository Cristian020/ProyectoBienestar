import 'package:flutter/material.dart';
import './models/Espacio.dart' show Espacio, Subelemento;
import './models/Reserva.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:convert';

class VistaDetalle extends StatefulWidget {
  final Espacio espacioDetalle;

  // In the constructor, require a Espacio/elemento
  VistaDetalle({Key key, @required this.espacioDetalle}) : super(key: key);

  @override
  _VistaDetalleState createState() => _VistaDetalleState();
}

class _VistaDetalleState extends State<VistaDetalle> {
  int groupValue1 = 0;

  @override
  Widget build(BuildContext context) {
    // Use the Todo to create the UI.
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.espacioDetalle.nombre),
        ),
        body: SingleChildScrollView(child: Column(children: [vistaDetalle()])));
  }

  Widget vistaDetalle() {
    var listView;

    if (widget.espacioDetalle.subelementos != null) {
      listView = espacioDetalleConElementos();
    } else {
      listView = espacioDetalleSinSubelementos();
    }
    return listView;
  }

  void something(int e, int index) {
    setState(() {
      if (e == index) {
        groupValue1 = index;
      }
    });
  }

  Widget espacioDetalleConElementos() {
    return Column(children: [
      Align(
        alignment: Alignment.center,
        child: Column(children: [
          ListTile(
              title: Text(widget.espacioDetalle.nombre,
                  style: TextStyle(fontSize: 20)),
              subtitle: Text("Nombre",
                  style: TextStyle(fontSize: 15, color: Colors.grey))),
          ListTile(
              title: Text(widget.espacioDetalle.descripcion,
                  style: TextStyle(fontSize: 20)),
              subtitle: Text("Descripción",
                  style: TextStyle(fontSize: 15, color: Colors.grey))),
          ListTile(
              title: Text(widget.espacioDetalle.recomendaciones,
                  style: TextStyle(fontSize: 20)),
              subtitle: Text("Recomendaciones",
                  style: TextStyle(fontSize: 15, color: Colors.grey))),
          ListTile(
              title: Text(widget.espacioDetalle.capacidadMaxima.toString(),
                  style: TextStyle(fontSize: 20)),
              subtitle: Text("Capacidad Máxima",
                  style: TextStyle(fontSize: 15, color: Colors.grey))),
          ListTile(
              title: Text(widget.espacioDetalle.unidades.toString(),
                  style: TextStyle(fontSize: 20)),
              subtitle: Text("Unidades",
                  style: TextStyle(fontSize: 15, color: Colors.grey))),
          SizedBox(
              height: 200.0,
              child: ListView.builder(
                  itemCount: widget.espacioDetalle.subelementos.length,
                  itemBuilder: (context, index) {
                    return RadioListTile(
                      onChanged: (int e) => something(e, index),
                      value: index,
                      groupValue: groupValue1,
                      title: Text(
                          widget.espacioDetalle.subelementos[index].nombre,
                          style: TextStyle(fontSize: 20)),
                      subtitle: Text(
                          widget.espacioDetalle.subelementos[index].descripcion,
                          style: TextStyle(fontSize: 15)),
                    );
                  })),
          Container(
              height: 60.0,
              child: ListView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: 1,
                  itemBuilder: (context, index) {
                    return ListTile(
                        trailing: FlatButton(
                            color: Colors.blue,
                            textColor: Colors.white,
                            disabledColor: Colors.grey,
                            disabledTextColor: Colors.black,
                            padding: EdgeInsets.symmetric(horizontal: 145.0),
                            splashColor: Colors.blueAccent,
                            onPressed: () {
                              // Subelemento subelementoReserva = Subelemento(
                              //     widget.espacioDetalle
                              //         .subelementos[groupValue1].nombre,
                              //     widget.espacioDetalle
                              //         .subelementos[groupValue1].descripcion,
                              //     widget
                              //         .espacioDetalle
                              //         .subelementos[groupValue1]
                              //         .disponibilidad);
                              // List<Subelemento> subelementoGuardar = [];
                              // subelementoGuardar.add(subelementoReserva);
                              // Espacio espacioReserva = Espacio(
                              //     widget.espacioDetalle.nombre,
                              //     widget.espacioDetalle.descripcion,
                              //     widget.espacioDetalle.recomendaciones,
                              //     widget.espacioDetalle.capacidadMaxima,
                              //     widget.espacioDetalle.unidades,
                              //     widget.espacioDetalle.horario,
                              //     subelementoGuardar);
                              // var nuevaReserva =
                              //     Reserva(espacioReserva, 'admin');
                              // ReservasModel.items.add(nuevaReserva);
                              // Scaffold.of(context).showSnackBar(SnackBar(
                              //     content: Text(jsonEncode(nuevaReserva))));
                            },
                            child: Text(
                              "Reservar",
                              style: TextStyle(fontSize: 20.0),
                            )));
                  })),
        ]),
      ),
    ]);
  }

  Widget espacioDetalleSinSubelementos() {
    return Column(children: [
      Align(
        alignment: Alignment.center,
        child: Column(children: [
          ListTile(
              title: Text(widget.espacioDetalle.nombre,
                  style: TextStyle(fontSize: 20)),
              subtitle: Text("Nombre",
                  style: TextStyle(fontSize: 15, color: Colors.grey))),
          ListTile(
              title: Text(widget.espacioDetalle.descripcion,
                  style: TextStyle(fontSize: 20)),
              subtitle: Text("Descripción",
                  style: TextStyle(fontSize: 15, color: Colors.grey))),
          ListTile(
              title: Text(widget.espacioDetalle.recomendaciones,
                  style: TextStyle(fontSize: 20)),
              subtitle: Text("Recomendaciones",
                  style: TextStyle(fontSize: 15, color: Colors.grey))),
          ListTile(
              title: Text(widget.espacioDetalle.capacidadMaxima.toString(),
                  style: TextStyle(fontSize: 20)),
              subtitle: Text("Capacidad Máxima",
                  style: TextStyle(fontSize: 15, color: Colors.grey))),
          ListTile(
              title: Text(widget.espacioDetalle.unidades.toString(),
                  style: TextStyle(fontSize: 20)),
              subtitle: Text("Unidades",
                  style: TextStyle(fontSize: 15, color: Colors.grey))),
          SizedBox(
              height: 100.0,
              child: ListView.builder(
                  itemCount: 1,
                  itemBuilder: (context, index) {
                    return ListTile(
                        title: Text("Sin subelementos",
                            style: TextStyle(fontSize: 20)),
                        subtitle: Text("Sin subelementos por mostrar",
                            style: TextStyle(fontSize: 15)));
                  })),
          Container(
              height: 60.0,
              child: ListView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: 1,
                  itemBuilder: (context, index) {
                    return ListTile(
                        title: Text(""),
                        subtitle: Text(""),
                        trailing: FlatButton(
                            color: Colors.blue,
                            textColor: Colors.white,
                            disabledColor: Colors.grey,
                            disabledTextColor: Colors.black,
                            padding: EdgeInsets.symmetric(horizontal: 145.0),
                            splashColor: Colors.blueAccent,
                            onPressed: () {
                              // var nuevaReserva =
                              //     Reserva(widget.espacioDetalle, 'admin');
                              // ReservasModel.items.add(nuevaReserva);
                              // Scaffold.of(context).showSnackBar(SnackBar(
                              //     content: Text(jsonEncode(nuevaReserva))));
                            },
                            child: Text(
                              "Reservar",
                              style: TextStyle(fontSize: 20.0),
                            )));
                  }))
        ]),
      ),
    ]);
  }
}

/* */
