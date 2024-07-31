import 'package:ass2/states.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:sqflite/sqflite.dart';
import 'package:fluttertoast/fluttertoast.dart';

class cubit_App extends Cubit<states_App> {
  cubit_App() : super(ini());
  Database? database;
  List signUp_data = [];
  List stores_data = [];
  List favorite_data = [];
  bool servicse = false;
  var per;
  Position? current;
  List<Placemark>? placemarker;
  double? distance;
  var distanceBetween;

  static cubit_App get(context) => BlocProvider.of(context);
  get_postion() async {
    servicse = await Geolocator.isLocationServiceEnabled();
    per = await Geolocator.checkPermission();
    per == LocationPermission.denied
        ? per = await Geolocator.requestPermission()
        : null;

    if (servicse == true && per != LocationPermission.denied) {
      current = await Geolocator.getCurrentPosition().then((value) => value);
      placemarker =
          await placemarkFromCoordinates(current!.latitude, current!.longitude);
      print(current);
      print(placemarker![0].subAdministrativeArea);
      print(per);
      print(servicse);
    } else {
      Fluttertoast.showToast(
          msg: "Open Location and Permation",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
      print("Services $servicse");
    }
  }

  create_data() async {
    emit(Load_Data());
    {
      database = await openDatabase("App_Stores.db", version: 1,
          onCreate: (database, version) {
        database
            .execute(
                'CREATE TABLE sign_Up (id INTEGER PRIMARY KEY, name TEXT, Age TEXT, email TEXT , password TEXT)')
            .then((value) {
          print("sign_Up created");
        });
        database
            .execute(
                'CREATE TABLE stores (id INTEGER PRIMARY KEY, name TEXT, image TEXT, city TEXT)')
            .then((value) {
          print("stores created");
        });
        database
            .execute(
                'CREATE TABLE fav (id INTEGER PRIMARY KEY, name TEXT, image TEXT, city TEXT)')
            .then((value) {
          print("fav created");
        });
        print("Database created");
      }, onOpen: (database) {
        database.rawQuery('SELECT * FROM sign_Up').then((value) {
          emit(Load_Data());
          value.forEach((element) {
            signUp_data.add(element);
            print(element);
          });
          emit(Get_Data_signUp());
        });
        database.rawQuery('SELECT * FROM stores').then((value) {
          emit(Load_Data());
          value.forEach((element) {
            stores_data.add(element);
            print(element);
          });
          emit(Get_Data_Stores());
        });
        emit(Load_Data());

        database.rawQuery('SELECT * FROM fav').then((value) {
          value.forEach((element) {
            favorite_data.add(element);
            print(element);
          });
          emit(Get_Data_Favorite());
        });
        print("Open Database");
      });

      emit(Create_DataBase());
    }
  }

  insert_data_SignUp({
    required String name,
    required String email,
    required String password,
    required String Age,
  }) {
    emit(Load_Data());
    database!
        .rawInsert(
            'INSERT INTO sign_Up(name, Age, email, password) VALUES("$name", "$Age", "$email" , "$password")')
        .then((value) {
      emit(Inseart_Data());
      Fluttertoast.showToast(
          msg: "Register successfully",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
    }).catchError((e) {
      print(e);
    });
  }

  get_data_signUp() {
    signUp_data = [];
    database!.rawQuery('SELECT * FROM sign_Up').then((value) {
      emit(Load_Data());
      value.forEach((element) {
        print(element);
        signUp_data.add(element);
      });

      emit(Get_Data_signUp());
    });
  }

  // Example method to insert data into the stores table
  insert_data_Store({
    required String name,
    required String image,
    required String city,
  }) {
    emit(Load_Data());
    database!.transaction((txn) async {
      try {
        await txn.rawInsert(
            'INSERT INTO stores(name, image, city) VALUES("$name", "$image", "$city")');
        emit(Inseart_Data());
        Fluttertoast.showToast(
            msg: "Store added successfully",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0);
      } catch (e) {
        print(e);
        Fluttertoast.showToast(
            msg: "Failed to add store",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0);
      }
    });
  }


  get_data_Stores() {
    stores_data = [];
    emit(Load_Data()); // Emitting Load_Data to indicate that data is being fetched

    database!.rawQuery('SELECT * FROM stores').then((value) {
      emit(Load_Data()); // Emitting Load_Data again to indicate that data has been loaded
      value.forEach((element) {
        print(element); // Debugging: Print each element to see the data
        stores_data.add(element); // Adding each element to the stores_data list
      });

      emit(Get_Data_Stores()); // Emitting Get_Data_Stores to indicate that data has been successfully fetched
    });
  }


  inseart_database_fav({
    required String name,
    required String image,
    required String city,
  }) {
    emit(Load_Data());
    database!.rawInsert(
        'INSERT INTO fav(name, image, city) VALUES("$name", "$image", "$city")');
    emit(Inseart_Data());
  }

  get_data_fav() {
    favorite_data = [];
    emit(Load_Data());

    database!.rawQuery('SELECT * FROM fav').then((value) {
      value.forEach((element) {
        favorite_data.add(element);
        print(element);
      });
      emit(Get_Data_Favorite());
    });
  }

  delete_data(String name) {
    database!.rawDelete('DELETE FROM fav WHERE name ="$name" ').then((value) {
      print("Deette");
    }).catchError((e) {
      print(e);
    });
  }

  void Chang_nav() {
    emit(change_nav());
  }

  void chang_to_distance() {
    emit(change_nav_Distance());
  }

}

class MyBlocObserver extends BlocObserver {
  @override
  void onCreate(BlocBase bloc) {
    super.onCreate(bloc);
    print("onCreate -- ${bloc.runtimeType}");
  }

  @override
  void onChange(BlocBase bloc, Change change) {
    super.onChange(bloc, change);
    print("onChange -- ${bloc.runtimeType}, $change");
  }

  @override
  void onError(BlocBase bloc, Object error, StackTrace stackTrace) {
    super.onError(bloc, error, stackTrace);
    print("onError -- ${bloc.runtimeType}, $error");
  }

  @override
  void onClose(BlocBase bloc) {
    super.onClose(bloc);
    print("onClose -- ${bloc.runtimeType}");
  }
}
