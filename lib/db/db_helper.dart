import 'package:Hisabi/models/product_model.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import '../models/user_model.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();

  factory DatabaseHelper() => _instance;

  DatabaseHelper._internal();

  static Database? _db;

  Future<Database> get database async {
    if (_db != null) return _db!;
    _db = await _initDB();
    return _db!;
  }

  Future<Database> _initDB() async {
    String path = join(await getDatabasesPath(), 'hisabi.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute('''
        CREATE TABLE users(
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          name TEXT,
          email TEXT UNIQUE,
          phone TEXT,
          password TEXT
        )
      ''');

        await db.execute('''
        CREATE TABLE products(
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          name TEXT,
          price TEXT,
          description TEXT,
          image TEXT,
          category TEXT
        )
      ''');

        List<ProductModel> sampleProducts = [
          ProductModel(
              name: 'Nike Tiempo Legend',
              price: '₹ 20995.00',
              description:
                  "Even Legends find ways to evolve. The latest iteration of this Elite boot has all-new FlyTouch Plus engineered leather. Softer than natural leather, it contours to your foot and works with All Conditions Control (a grippy texture even in wet weather) so you can dictate the pace of your game. Lighter and sleeker than any other Tiempo to date, the Legend 10 is for any position on the pitch, whether you're sending a pinpoint pass through the defence or tracking back to stop a break-away.",
              image: 'assets/Images/Home/Shoes/Shoes1.png',
              category: 'Formal Shoes'),
          ProductModel(
              name: 'Nike Air-Max Dn Essential',
              price: '₹ 14995.00',
              description:
                  "The Air Max Dn features our Dynamic Air unit system of dual-pressure tubes, creating a responsive sensation with every step. This results in a futuristic design that's comfortable enough to wear from day to night. Go ahead—Feel The Unreal",
              image: 'assets/Images/Home/Shoes/Shoes2.png',
              category: 'Sports & Athletic Shoes'),
          ProductModel(
              name: 'Nike Air-Max-2013',
              price: '₹ 16995.00',
              description:
                  "The Air Max 2013 brings back an all-time favourite from the Air Max franchise. Just as stylish and sporty as ever, it combines airy mesh and no-sew overlays to help keep you looking and feeling fresh. Plus, Flywire lacing and Air cushioning provide lasting comfort and support.",
              image: 'assets/Images/Home/Shoes/Shoes3.png',
              category: 'Sports & Athletic Shoes'),
          ProductModel(
              name: 'Nike Air Zoom-Upturn-SC',
              price: '₹ 7895.00',
              description:
                  "Breathable, light, durable. The Upturn SC combines airy mesh with a cushioned midsole and generous Air Zoom in the heel, making it the perfect shoe to throw on and go.",
              image: 'assets/Images/Home/Shoes/Shoes4.png',
              category: 'Boots'),
          ProductModel(
              name: 'Nike Elevate 3',
              price: '₹ 7095.00',
              description:
                  "Level up your game on both ends of the floor in the Nike Renew Elevate 3. Specifically tuned for 2-way players who want to make an impact offensively and defensively, this shoe helps you optimise your ability with all-game, all-season support and stability. Improved traction and arch support enhance cutting and pivoting, which can make the difference down the stretch.",
              image: 'assets/Images/Home/Shoes/Shoes5.png',
              category: 'Formal Shoes'),
          ProductModel(
              name: 'Nike SB Dunk Low Pro',
              price: '₹ 9695.00',
              description:
                  "You can always count on a classic. The Nike SB Dunk Low pairs iconic colour-blocking with premium materials and plush padding for game-changing comfort that lasts. The possibilities are endless—how will you wear your Dunks?  ",
              image: 'assets/Images/Home/Shoes/Shoes6.png',
              category: 'Boots'),
        ];

        for (var product in sampleProducts) {
          await db.insert('products', product.toMap());
        }
      },
    );
  }

  Future<int> insertUser(UserModel user) async {
    final db = await database;
    return await db.insert('users', user.toMap());
  }

  static Future<UserModel?> getLatestUser() async {
    final db = await _instance.database;
    final List<Map<String, dynamic>> maps = await db.query(
      'users',
      orderBy: 'id DESC',
      limit: 1,
    );
    if (maps.isNotEmpty) {
      return UserModel.fromMap(maps.first);
    }
    return null;
  }

  static Future<bool> isEmailExist(String email) async {
    final db = await _instance.database;
    List<Map<String, dynamic>> result = await db.query(
      'users',
      where: 'email = ?',
      whereArgs: [email],
    );
    return result.isNotEmpty;
  }

  Future<UserModel?> getUserByEmail(String email) async {
    final db = await database;
    List<Map<String, dynamic>> result = await db.query(
      'users',
      where: 'email = ?',
      whereArgs: [email],
    );
    if (result.isNotEmpty) {
      return UserModel.fromMap(result.first);
    }
    return null;
  }

  Future<int> updateUser(UserModel user) async {
    final db = await database;
    return await db.update(
      'users',
      user.toMap(),
      where: 'id = ?',
      whereArgs: [user.id],
    );
  }

  Future<int> deleteUser(int id) async {
    final db = await database;
    return await db.delete(
      'users',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future<List<UserModel>> getAllUsers() async {
    final db = await database;
    final List<Map<String, dynamic>> result = await db.query('users');
    return result.map((map) => UserModel.fromMap(map)).toList();
  }

  Future<int> insertProduct(ProductModel product) async {
    final db = await database;
    return await db.insert('products', product.toMap());
  }

  Future<List<ProductModel>> getAllProducts() async {
    final db = await database;
    final List<Map<String, dynamic>> result = await db.query('products');
    return result.map((map) => ProductModel.fromMap(map)).toList();
  }

  Future<ProductModel?> getProductById(int id) async {
    final db = await database;
    final result = await db.query(
      'products',
      where: 'id = ?',
      whereArgs: [id],
    );

    if (result.isNotEmpty) {
      return ProductModel.fromMap(result.first);
    }
    return null;
  }

  Future<void> deleteDatabaseForDebug() async {
    String path = join(await getDatabasesPath(), 'hisabi.db');
    await deleteDatabase(path);
    print("Database deleted for reset");
  }
}
