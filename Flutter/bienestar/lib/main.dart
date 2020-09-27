import 'package:bienestar/dummy.data.dart';
import 'package:flutter/material.dart';
import './crear.espacio.dart';
import './beneficiario.consultar.espacios.dart';
import './models/Espacio.dart' show Espacio;
import './models/Reserva.dart' show Reserva;
import 'package:provider/provider.dart';
import 'consultar.reserva.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Bienestar',
        home: MultiProvider(providers: [
          ChangeNotifierProvider(
              create: (context) => EspaciosModel(getDummyItems())),
          ChangeNotifierProvider(
              create: (context) => ReservasModel(getDummyReservas())),
        ], child: Home())

        // home:  ChangeNotifierProvider(
        // create: (context) => EspaciosModel(getDummyItems()),
        // child: Home())
        );
  }
}

class Home extends StatefulWidget {
// La clase Home tiene como funcón principal mostrar otros widgets en el navigationBar
// Por ello guarda una lista de widgets que desplegar

  Home({Key key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  var _selectedIndex = 0;

//Lista de widgets que seleccionar desde el bottomNavigationBar
  static List<Widget> _widgetOptions = <Widget>[
    CrearEspacioForm(),
    ConsultarEspacios(),
    ConsultarReservas()
  ];

  @override
  Widget build(BuildContext context) {
    // loadDummyToFirestore();
    return Scaffold(
      appBar: AppBar(title: Text('Bienestar')),
      body: _widgetOptions[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
              icon: Icon(Icons.add), title: Text('Crear Espacio')),
          BottomNavigationBarItem(
              icon: Icon(Icons.list), title: Text('Consultar')),
          BottomNavigationBarItem(
              icon: Icon(Icons.schedule), title: Text('Reseva')),
        ],
        currentIndex: _selectedIndex,
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
            debugPrint("Tab index has been changet to: $_selectedIndex");
          });
        },
      ),
    );
  }
}

// los comentrios dentro de este ChangeNotifier son de la documentacion.
// Solo es una guía.
class EspaciosModel extends ChangeNotifier {
  /// Internal, private state of the cart.
  List<Espacio> _items;
  get items => _items;

  /// Adds [item] to cart. This and [removeAll] are the only ways to modify the
  /// cart from the outside.

  int length;
  EspaciosModel(List<Espacio> initialData) {
    this._items = initialData;
    this.length = this._items.length;
  }
  setLength() {
    this.length = this._items.length;
  }

  void add(Espacio nuevo) {
    _items.add(nuevo);
    // This call tells the widgets that are listening to this model to rebuild.
    notifyListeners();
    setLength();
  }

  /// Removes all items from the cart.
  void removeAll() {
    _items.clear();
    // This call tells the widgets that are listening to this model to rebuild.
    notifyListeners();
    setLength();
  }

  Map toJson() => {
        'count': length,
        'espacios': items,
      };
}

class ReservasModel extends ChangeNotifier {
  static List<Reserva> items = [];
  int length;

  ReservasModel(List<Reserva> initialData) {
    ReservasModel.items = initialData;
    this.length = ReservasModel.items.length;
  }

  setLength() {
    this.length = ReservasModel.items.length;
  }

  void add(Reserva nuevo) {
    items.add(nuevo);

    notifyListeners();
    setLength();
  }

  void removeAll() {
    items.clear();

    notifyListeners();
    setLength();
  }

  Map toJson() => {
        'count': length,
        'reservas': items,
      };
}
