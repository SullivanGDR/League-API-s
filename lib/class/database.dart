import 'package:lol_api/class/champion.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseCollections {
  static Database? _db;

  Future<Database?> get db async {
    if (_db != null) {
      return _db;
    }
    _db = await initDb();
    return _db;
  }

  Future<Database> initDb() async {
    final db = await openDatabase(
        join(await getDatabasesPath(), 'lolCollections.db'),
        onCreate: (db, version){
        },
        version: 2
    );
    await db.execute('''CREATE TABLE IF NOT EXISTS TOP (id INTEGER PRIMARY KEY, nom TEXT, icon TEXT, nomCompact TEXT)''');
    await db.execute('''CREATE TABLE IF NOT EXISTS JGL (id INTEGER PRIMARY KEY, nom TEXT, icon TEXT, nomCompact TEXT)''');
    await db.execute('''CREATE TABLE IF NOT EXISTS MID (id INTEGER PRIMARY KEY, nom TEXT, icon TEXT, nomCompact TEXT)''');
    await db.execute('''CREATE TABLE IF NOT EXISTS ADC (id INTEGER PRIMARY KEY, nom TEXT, icon TEXT, nomCompact TEXT)''');
    await db.execute('''CREATE TABLE IF NOT EXISTS Support (id INTEGER PRIMARY KEY, nom TEXT, icon TEXT, nomCompact TEXT)''');
    await db.execute('''CREATE TABLE IF NOT EXISTS Favoris (id INTEGER PRIMARY KEY, nom TEXT, icon TEXT, nomCompact TEXT)''');
    return db;
  }

  Future<bool> addChampionToCollection(String collectionTable, Champion champion) async {
    final db = await this.db;

    if (db == null) {
      print("Erreur lors de l'ouverture de la base de données.");
      return false;
    }

    bool championExists = await isChampionInCollection(collectionTable, champion);

    if (championExists) {
      print("${champion.getNom()} est déjà dans la collection $collectionTable.");
      return false;
    }

    await db!.insert(collectionTable, champion.toMap());

    return true;
  }

  Future<bool> isChampionInCollection(String collectionName, Champion champion) async {
    final db = await this.db;

    if (db == null) {
      print("Erreur lors de l'ouverture de la base de données.");
      return false;
    }

    List<Map<String, dynamic>> results = await db.query(
      collectionName,
      where: 'nom = ?',
      whereArgs: [champion.getNom()],
    );

    return results.isNotEmpty;
  }

  Future<void> deleteItem(int id, String tableName) async {
    final db = await this.db;
    await db!.delete(
      tableName,
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future<List<Champion>> getListeFavoris() async {
    // Get a reference to the database.
    final db = await this.db;

    if (db == null) {
      print("Erreur lors de l'ouverture de la base de données.");
      return [];
    }
    // Query the table for all The Dogs.
    List<Map<String, dynamic>> maps = await db.query('Favoris');

    // Convert the List<Map<String, dynamic> into a List<Dog>.
    return List.generate(maps.length, (i) {
      return Champion(
        maps[i]['id'] as int,
        maps[i]['nom'] as String,
        maps[i]['icon'] as String,
        maps[i]['nomCompact'] as String,
      );
    });
  }

  Future<List<Champion>> getListeTop() async {
    // Get a reference to the database.
    final db = await this.db;

    if (db == null) {
      print("Erreur lors de l'ouverture de la base de données.");
      return [];
    }

    List<Map<String, dynamic>> maps = await db.query('TOP');

    return List.generate(maps.length, (i) {
      return Champion(
        maps[i]['id'] as int,
        maps[i]['nom'] as String,
        maps[i]['icon'] as String,
        maps[i]['nomCompact'] as String,
      );
    });
  }

  Future<List<Champion>> getListeJgl() async {
    // Get a reference to the database.
    final db = await this.db;

    if (db == null) {
      print("Erreur lors de l'ouverture de la base de données.");
      return [];
    }
    // Query the table for all The Dogs.
    List<Map<String, dynamic>> maps = await db.query('JGL');

    // Convert the List<Map<String, dynamic> into a List<Dog>.
    return List.generate(maps.length, (i) {
      return Champion(
        maps[i]['id'] as int,
        maps[i]['nom'] as String,
        maps[i]['icon'] as String,
        maps[i]['nomCompact'] as String,
      );
    });
  }

  Future<List<Champion>> getListeMid() async {
    // Get a reference to the database.
    final db = await this.db;

    if (db == null) {
      print("Erreur lors de l'ouverture de la base de données.");
      return [];
    }
    // Query the table for all The Dogs.
    List<Map<String, dynamic>> maps = await db.query('MID');

    // Convert the List<Map<String, dynamic> into a List<Dog>.
    return List.generate(maps.length, (i) {
      return Champion(
        maps[i]['id'] as int,
        maps[i]['nom'] as String,
        maps[i]['icon'] as String,
        maps[i]['nomCompact'] as String,
      );
    });
  }

  Future<List<Champion>> getListeAdc() async {
    // Get a reference to the database.
    final db = await this.db;

    if (db == null) {
      print("Erreur lors de l'ouverture de la base de données.");
      return [];
    }
    // Query the table for all The Dogs.
    List<Map<String, dynamic>> maps = await db.query('ADC');

    // Convert the List<Map<String, dynamic> into a List<Dog>.
    return List.generate(maps.length, (i) {
      return Champion(
        maps[i]['id'] as int,
        maps[i]['nom'] as String,
        maps[i]['icon'] as String,
        maps[i]['nomCompact'] as String,
      );
    });
  }

  Future<List<Champion>> getListeSupport() async {
    // Get a reference to the database.
    final db = await this.db;

    if (db == null) {
      print("Erreur lors de l'ouverture de la base de données.");
      return [];
    }
    // Query the table for all The Dogs.
    List<Map<String, dynamic>> maps = await db.query('Support');

    // Convert the List<Map<String, dynamic> into a List<Dog>.
    return List.generate(maps.length, (i) {
      return Champion(
        maps[i]['id'] as int,
        maps[i]['nom'] as String,
        maps[i]['icon'] as String,
        maps[i]['nomCompact'] as String,
      );
    });
  }

  void printDatabaseContents() async {
    final dbHelper = DatabaseCollections();
    final db = await dbHelper.db;

    if (db == null) {
      print("Erreur lors de l'ouverture de la base de données.");
      return;
    }

    // Liste des noms de vos tables (collections)
    final tableNames = ["TOP", "JGL", "MID", "ADC", "Support", "Favoris"];

    for (final tableName in tableNames) {
      final List<Map<String, dynamic>> results = await db.query(tableName);

      print("Contenu de la table $tableName:");
      for (final row in results) {
        print(row);
      }
      print("----");
    }
  }
}