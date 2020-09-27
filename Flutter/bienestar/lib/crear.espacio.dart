import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import './models/Espacio.dart' show Espacio;
import './models/Horario.dart' show DisponibilidadHoraria, DisponibilidadPorDia;
import 'main.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
import 'package:datetime_picker_formfield/time_picker_formfield.dart';

//Este formulario recibe los datos necesarios para crear un Espacio.

class CrearEspacioForm extends StatefulWidget {
  @override
  CrearEspacioFormState createState() {
    return CrearEspacioFormState();
  }
}
/*
class MyAppHora extends StatefulWidget {
  @override
  //MyAppHoraState createState() => MyAppHoraState();
  MyAppHoraState createState() {
    return MyAppHoraState();
  }
}*/

class CrearEspacioFormState extends State<CrearEspacioForm> {
  var _formKey = GlobalKey<FormState>();
  var tipoSelected = 'Espacio';
  var tiposDeElemento = ['Espacio', 'Elemento', 'Elemento de un espacio'];
  final firestore = Firestore.instance;

  // build helpers
  //  para facilitar la construcción del formulario
  Widget crearCampo(
    String campo,
    TextEditingController controlador,
    Function validator,
  ) {
    final timeFormat = DateFormat("h:mm a");
    TimeOfDay time;
    /*var campoLower = campo.toLowerCase();
    return TextFormField(
        controller: controlador,
        validator: validator,
        decoration: InputDecoration(
          labelText: campo,
          hintText: 'Ingresar $campoLower',
        ));*/
    return ListView(
      children: [
        TimePickerFormField(
          validator: validator,
          controller: controlador,
          format: timeFormat,
          decoration: InputDecoration(labelText: campo),
          onChanged: (t) => setState(() => time = t),
        )
      ],
    );
  }

  Widget createInitialDisponibilidadHorariaField(
      String dia, TextEditingController controller, Function validator) {
    final timeFormat = DateFormat("h:mm a");
    TimeOfDay time;
    return ListView(
      children: <Widget>[
        SizedBox(height: 16.0),
        TimePickerFormField(
          validator: validator,
          controller: controller,
          format: timeFormat,
          decoration: InputDecoration(labelText: 'Inicio $dia'),
          onChanged: (t) => setState(() => time = t),
        ),
        SizedBox(height: 16.0),
        Text('time.toString(): $time', style: TextStyle(fontSize: 18.0)),
      ],
    );
    /* return TextFormField(
        // ignore: missing_return
        validator: validator,
        controller: controller,
        keyboardType: TextInputType.number,
        decoration: InputDecoration(
          labelText: 'Inicio $dia',
          hintText: 'HH:MM',
        ));*/
  }

  Widget createFinalDisponibilidadHorariaField(
      String dia, TextEditingController controller, Function validator) {
    return TextFormField(
        // ignore: missing_return
        validator: validator,
        controller: controller,
        keyboardType: TextInputType.number,
        decoration: InputDecoration(
          labelText: 'Fin $dia',
          hintText: 'HH:MM',
        ));
  }

  // Validators
  // ignore: top_level_function_literal_block
  var validarCampoVacio = (String value) {
    if (value.isEmpty) {
      return 'Este campo no puede estar vacío';
    }
    return null;
  };

//Controllers

  TextEditingController nombreController = TextEditingController();
  TextEditingController descripcionController = TextEditingController();
  TextEditingController recomendacionesDeUsoController =
      TextEditingController();
  TextEditingController capacidadMaximaController = TextEditingController();
  TextEditingController unidadesController = TextEditingController();

//Controller disponibilidad horaria
  TextEditingController lunesInicio = TextEditingController();
  TextEditingController lunesFin = TextEditingController();
  TextEditingController martesInicio = TextEditingController();
  TextEditingController martesFin = TextEditingController();
  TextEditingController miercolesInicio = TextEditingController();
  TextEditingController miercolesFin = TextEditingController();
  TextEditingController juevesInicio = TextEditingController();
  TextEditingController juevesFin = TextEditingController();
  TextEditingController viernesInicio = TextEditingController();
  TextEditingController viernesFin = TextEditingController();
  TextEditingController sabadoInicio = TextEditingController();
  TextEditingController sabadoFin = TextEditingController();

  // Methods

  DisponibilidadHoraria construirHorario(BuildContext context) {
    DisponibilidadPorDia lunes =
        DisponibilidadPorDia(lunesInicio.text, lunesFin.text);
    DisponibilidadPorDia martes =
        DisponibilidadPorDia(martesInicio.text, martesFin.text);
    DisponibilidadPorDia miercoles =
        DisponibilidadPorDia(miercolesInicio.text, miercolesFin.text);
    DisponibilidadPorDia jueves =
        DisponibilidadPorDia(juevesInicio.text, juevesFin.text);
    DisponibilidadPorDia viernes =
        DisponibilidadPorDia(viernesInicio.text, viernesFin.text);
    DisponibilidadPorDia sabado =
        DisponibilidadPorDia(sabadoInicio.text, sabadoFin.text);

    DisponibilidadHoraria horario = DisponibilidadHoraria(
        lunes, martes, miercoles, jueves, viernes, sabado);

    return horario;
  }

  @override
  Widget build(BuildContext context) {
    debugPrint('Se construye la vista beneficiario-crear-espacio');

    return ListView(children: [
      Form(
        key: _formKey,
        child: Column(
          children: <Widget>[
            Row(children: [
              Expanded(
                  child: DropdownButton(
                      isExpanded: true,
                      items: tiposDeElemento.map((String dropDownStringItem) {
                        return DropdownMenuItem<String>(
                          value: dropDownStringItem,
                          child: Text(dropDownStringItem),
                        );
                      }).toList(),
                      onChanged: (String newValueSelected) {
                        setState(() {
                          debugPrint(tipoSelected);
                          tipoSelected = newValueSelected;
                          debugPrint('setState $tipoSelected');
                        });
                      },
                      value: tipoSelected)),
            ]),
            crearCampo('Nombre', nombreController, validarCampoVacio),
            crearCampo('Descripción', descripcionController, validarCampoVacio),
            crearCampo('Recomendaciones de uso', recomendacionesDeUsoController,
                validarCampoVacio),
            crearCampo('Capacidad máxima', capacidadMaximaController,
                validarCampoVacio),
            crearCampo(
                'Número de unidades', unidadesController, validarCampoVacio),
            Text('Disponibilidad Horaria', textAlign: TextAlign.center),
            ListTile(title: Text('Disponibilidad Horaria')),
            ListTile(title: Text('Lunes')),
            createInitialDisponibilidadHorariaField(
                'Lunes', lunesInicio, validarCampoVacio),
            createFinalDisponibilidadHorariaField(
                'Lunes', lunesFin, validarCampoVacio),
            ListTile(title: Text('Martes')),
            createInitialDisponibilidadHorariaField(
                'Martes', martesInicio, validarCampoVacio),
            createFinalDisponibilidadHorariaField(
                'Martes', martesFin, validarCampoVacio),
            ListTile(title: Text('Miércoles')),
            createInitialDisponibilidadHorariaField(
                'Miercoles', miercolesInicio, validarCampoVacio),
            createFinalDisponibilidadHorariaField(
                'Miercoles', miercolesFin, validarCampoVacio),
            ListTile(title: Text('Jueves')),
            createInitialDisponibilidadHorariaField(
                'Jueves', juevesInicio, validarCampoVacio),
            createFinalDisponibilidadHorariaField(
                'Jueves', juevesFin, validarCampoVacio),
            ListTile(title: Text('Viernes')),
            createInitialDisponibilidadHorariaField(
                'Viernes', viernesInicio, validarCampoVacio),
            createFinalDisponibilidadHorariaField(
                'Viernes', viernesFin, validarCampoVacio),
            ListTile(title: Text('Sábado')),
            createInitialDisponibilidadHorariaField(
                'Sábado', sabadoInicio, validarCampoVacio),
            createFinalDisponibilidadHorariaField(
                'Sábado', sabadoFin, validarCampoVacio),
            Padding(
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                child: Consumer<EspaciosModel>(
                    builder: (context, espacios, child) {
                  return RaisedButton(
                    onPressed: () {
                      if (_formKey.currentState.validate()) {
                        // Preparar datos para instanciar un Espacio
                        String nombre = nombreController.text;
                        String descripcion = descripcionController.text;
                        int capacidad =
                            int.parse(capacidadMaximaController.text);
                        String recomendaciones =
                            recomendacionesDeUsoController.text;
                        int unidades = int.parse(unidadesController.text);

                        DisponibilidadHoraria horario =
                            construirHorario(context);

                        var espacioNuevo = Espacio(nombre, descripcion,
                            recomendaciones, capacidad, unidades, horario);

                        String log = jsonEncode(espacioNuevo);

                        debugPrint(
                            'Attempted to write to firestore using add()');
                        debugPrint(log, wrapWidth: 1000);

                        Scaffold.of(context)
                            .showSnackBar(SnackBar(content: Text(log)));

                        return firestore
                            .collection('espacios')
                            .add(espacioNuevo.toJson());
                      }
                    },
                    child: Text('Crear espacio o elemento'),
                  );
                })),
          ],
        ),
      )
    ]);
  }
}
/*
class MyAppHoraState extends State<MyAppHora> {
  final timeFormat = DateFormat("h:mm a");
  TimeOfDay time;
  @override
  Widget build(BuildContext context) => Scaffold(
          body: Padding(
        padding: EdgeInsets.all(16.0),
        child: ListView(
          children: <Widget>[
            SizedBox(height: 16.0),
            TimePickerFormField(
              format: timeFormat,
              decoration: InputDecoration(labelText: 'Time'),
              onChanged: (t) => setState(() => time = t),
            ),
            SizedBox(height: 16.0),
            Text('time.toString(): $time', style: TextStyle(fontSize: 18.0)),
          ],
        ),
      ));
}
*/
/*

class MyAppHora extends StatefulWidget {
  @override
  MyAppHoraState createState() => MyAppHoraState();
}

class MyAppHoraState extends State<MyAppHora> {
  final timeFormat = DateFormat("h:mm a");
  TimeOfDay time;
  @override
  Widget build(BuildContext context) => Scaffold(
          body: Padding(
        padding: EdgeInsets.all(16.0),
        child: ListView(
          children: <Widget>[
            SizedBox(height: 16.0),
            TimePickerFormField(
              format: timeFormat,
              decoration: InputDecoration(labelText: 'Time'),
              onChanged: (t) => setState(() => time = t),
            ),
            SizedBox(height: 16.0),
            Text('time.toString(): $time', style: TextStyle(fontSize: 18.0)),
          ],
        ),
      ));
}
*/

/*
 class MyAppHoras extends StatefulWidget {
  @override
  Date createState() => new Date();
}

class Date extends State<MyAppHoras> {
  TimeOfDay tiempo = new TimeOfDay.now();

  Future<Null> seleccionarTiempo/*<CrearEspacioFormState>*/(BuildContext context) async {
    final TimeOfDay seleccion =
        await showTimePicker(context: context, initialTime: tiempo);

    if (seleccion != null && seleccion != tiempo) {
      // print('Hora seleecionada: ${tiempo.toString()}');
      setState(() {
        tiempo = seleccion;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    throw UnimplementedError();
  }
}
*/
