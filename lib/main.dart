import 'package:flutter/material.dart';
import 'package:nid_notes/screens/home.dart';
import 'package:nid_notes/screens/login.dart';
import 'package:nid_notes/screens/splash.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import 'models/note.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final Future<Database> database = openDatabase(
    join(await getDatabasesPath(), 'nid_notes.db'),
    onCreate: (db, version) {
      return db.execute(
        "CREATE TABLE notes(id INTEGER PRIMARY KEY, title TEXT, content TEXT)",
      );
    },
    version: 1,
  );
  Future<void> insertNote(Note note) async {
    final Database db = await database;
    await db.insert(
      'notes',
      note.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }
  runApp(NIDNotes());
}

class NIDNotes extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'NID Notes',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/splash',
      routes: {
        '/splash': (context) => SplashScreen(),
        '/login': (context) => LoginScreen(),
        '/home': (context) => HomeScreen(),
      },
    );
  }
}

