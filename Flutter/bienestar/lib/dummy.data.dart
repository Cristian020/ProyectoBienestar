import 'package:flutter/foundation.dart';

import './models/Espacio.dart' show Espacio, Subelemento;
import './models/Reserva.dart' show Reserva;
import './models/Horario.dart' show DisponibilidadHoraria, DisponibilidadPorDia;
import 'package:cloud_firestore/cloud_firestore.dart';

//El propósito de este archivo es reemplazarlo fácilmente por la fuente real de datos.

//Para tener un set de horarios fijos por dia y no tenerlos que ingresar manualmente
var dispoDia = [
  DisponibilidadPorDia('7:00am', '6:00pm'),
  DisponibilidadPorDia('10:00am', '6:00pm'),
  DisponibilidadPorDia('10:00am', '2:00pm'),
];

//Para tener un set de horarios fijos y no tenerlos que ingresar manualmente
var dispoHorario = [
  DisponibilidadHoraria(dispoDia[0], dispoDia[0], dispoDia[0], dispoDia[0],
      dispoDia[2], dispoDia[2]),
  DisponibilidadHoraria(dispoDia[1], dispoDia[1], dispoDia[1], dispoDia[1],
      dispoDia[2], dispoDia[2])
];

var subelementos = [
  Subelemento('Tablero de Ajedrez', 'Tablero y fichas', true),
  Subelemento('UNO', 'Caja de cartas UNO', true),
  Subelemento('Jenga', 'Caja con fichas Jenga', true),
];

getDummyItems() {
  var items = [
    Espacio('Ping Pong', 'Mesa con raquetas y bola',
        'No utilizarla para otros juegos', 8, 2, dispoHorario[0],
        subelementos: null),
    Espacio('Billar', 'Mesa con bolas y tacos',
        'Mucho cuidado con el uso de los tacos', 4, 3, dispoHorario[1],
        subelementos: null),
    Espacio('Mesa de juegos', 'Varios juegos de mesa disponibles',
        'No comer en las mesas ni beber', 3, 4, dispoHorario[1],
        subelementos: subelementos),
    Espacio('Futbol de mesa', 'Mesa con bola', 'No mover la mesa', 4, 1,
        dispoHorario[1],
        subelementos: null),
    Espacio('Sala de musica', 'Varios instrumentos disponibles',
        'No comer ni beber dentro de la sala', 6, 4, dispoHorario[0],
        subelementos: null),
    Espacio('Sala de videojuegos', 'xbox o tapete',
        'No comer ni beber dentro de la sala', 8, 3, dispoHorario[1],
        subelementos: null),
    Espacio('Hokie de mesa', 'Mesa con disco y dos raquetas',
        'Apagarla al finalizar.', 4, 1, dispoHorario[0],
        subelementos: null),
    Espacio('Test letras', '@konrad.edu.co, Nó comer "ñame" ',
        'probando , [*¨+^_] ', 8, 2, dispoHorario[0],
        subelementos: null),
    Espacio(
        'probando simbolos',
        '@konrad PROBANDO , [ ¬ ° | ! \' * + ^ _ - { } ~ ¨ ´ ¿ ? =  ( ) / " # % ], tambien se va a probar los cambios de linea',
        'tambien se estan probando los saltos de linea ',
        8,
        2,
        dispoHorario[0],
        subelementos: null),
  ];
  return items;
}

getDummyReservas() {
  var items = [
    Reserva(
        Espacio('Ping Pong', 'Mesa con raquetas y bola',
            'No utilizarla para otros juegos', 8, 2, dispoHorario[0],
            subelementos: null),
        'Juan Perez'),
    Reserva(
        Espacio('Nudillos de cobre', 'Add status poison',
            'Solo para defensa personal', 8, 2, dispoHorario[0],
            subelementos: null),
        'Malangas'),
    Reserva(
        Espacio('Billar', 'Mesa con bolas y tacos',
            'Mucho cuidado con el uso de los tacos', 4, 3, dispoHorario[1],
            subelementos: null),
        'Don Julio'),
    Reserva(
        Espacio('Futbol de mesa', 'Mesa con bola', 'No mover la mesa', 4, 1,
            dispoHorario[1],
            subelementos: null),
        'Ramón'),
    Reserva(
        Espacio('Sala de musica', 'Varios instrumentos disponibles',
            'No comer ni beber dentro de la sala', 6, 4, dispoHorario[0],
            subelementos: null),
        'Galarga'),
    Reserva(
        Espacio('Sala de videojuegos', 'xbox o tapete',
            'No comer ni beber dentro de la sala', 8, 3, dispoHorario[1],
            subelementos: null),
        '¿Qué?'),
    Reserva(
        Espacio('Hokie de mesa', 'Mesa con disco y dos raquetas',
            'Apagarla al finalizar.', 4, 1, dispoHorario[0],
            subelementos: null),
        'Martinèz'),
    Reserva(
        Espacio('Test letras', '@konrad.edu.co, Nó comer "ñame" ',
            'probando , [*¨+^_] ', 8, 2, dispoHorario[0],
            subelementos: null),
        'Orodoñes Martinèz í'),
  ];

  return items;
}

loadDummyToFirestore() {
  List<Reserva> dummies = getDummyReservas();
  debugPrint('Inicia carga dummy a Firestore');

  dummies.forEach((element) {
    Firestore.instance.collection('reservas').add(element.toJson());
    debugPrint(
        'Wrote ${element.elementoReservado.nombre}, ${element.beneficiario} to Firestore');
  });
}
