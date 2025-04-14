import 'package:Hisabi/models/order_model.dart';
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
      version: 2,
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

        // Create Orders Table
        await db.execute('''
        CREATE TABLE orders(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        user_id INTEGER,
        product_id INTEGER,
        quantity INTEGER,
        status TEXT,
        order_date TEXT,
        address TEXT,
        FOREIGN KEY(user_id) REFERENCES users(id),
        FOREIGN KEY(product_id) REFERENCES products(id)
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
          ProductModel(
              name: "Nike Air Force 1 '07",
              price: '₹ 9695.00',
              description:
                  "Comfortable, durable and timeless—it's number 1 for a reason. The '80s construction pairs with classic colours for style that tracks whether you're on court or on the go. ",
              image: 'assets/Images/Home/Shoes/Shoes7.png',
              category: 'Formal Shoes'),
          ProductModel(
              name: "Nike ReactX Rejuven8",
              price: '₹  4695.00',
              description:
                  "Give your feet a rest. Made from soft and responsive ReactX foam, the Rejuven8 uses some of our best tech to create recovery slides you'll look forward to wearing.",
              image: 'assets/Images/Home/Shoes/Shoes8.png',
              category: 'Casual'),
        ];

        for (var product in sampleProducts) {
          await db.insert('products', product.toMap());
        }
      },
      onUpgrade: (db, oldVersion, newVersion) async {
        if (oldVersion < 3) {
          // Add new columns
          await db.execute('''
          ALTER TABLE orders ADD COLUMN product_name TEXT;
        ''');
          await db.execute('''
          ALTER TABLE orders ADD COLUMN product_image TEXT;
        ''');
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

  Future<UserModel?> getCurrentUser() async {
    final db = await database;
    final List<Map<String, dynamic>> result = await db.query(
      'users',
      orderBy: 'id DESC',
      limit: 1,
    );
    if (result.isNotEmpty) {
      return UserModel.fromMap(result.first);
    } else {
      return null;
    }
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

  // Insert new order
  Future<int> insertOrder({
    required int userId,
    required int productId,
    int quantity = 1,
  }) async {
    final db = await database;

    // Check if the same product is already in cart
    final existing = await db.query(
      'orders',
      where: 'user_id = ? AND product_id = ? AND status = ?',
      whereArgs: [userId, productId, 'In Cart'],
    );

    if (existing.isNotEmpty) {
      // Product already in cart -> update quantity
      final currentQty = existing.first['quantity'] as int;
      final newQty = currentQty + quantity;

      return await db.update(
        'orders',
        {'quantity': newQty},
        where: 'id = ?',
        whereArgs: [existing.first['id']],
      );
    } else {
      // New product in cart -> insert new row
      final now = DateTime.now().toIso8601String();

      return await db.insert('orders', {
        'user_id': userId,
        'product_id': productId,
        'quantity': quantity,
        'status': 'In Cart',
        'order_date': now,
        'address': '',
      });
    }
  }

// Fetch orders with product info
  Future<List<OrderModel>> getOrdersByUser(int userId) async {
    final db = await database;
    final List<Map<String, dynamic>> results = await db.rawQuery('''
    SELECT o.*, p.name, p.image, p.price
    FROM orders o
    JOIN products p ON o.product_id = p.id
    WHERE o.user_id = ?
  ''', [userId]);

    print("Query Results: $results");
    return results.map((map) => OrderModel.fromJoinedMap(map)).toList();
  }

// Update quantity
  Future<int> updateOrderQuantity(int orderId, int quantity) async {
    final db = await database;
    return await db.update(
      'orders',
      {'quantity': quantity},
      where: 'id = ?',
      whereArgs: [orderId],
    );
  }

  Future<int> updateOrder(OrderModel order) async {
    final db = await database;
    return await db.update(
      'orders',
      order.toMap(),
      where: 'id = ?',
      whereArgs: [order.id],
    );
  }

// Delete order
  Future<int> deleteOrder(int orderId) async {
    final db = await database;
    return await db.delete('orders', where: 'id = ?', whereArgs: [orderId]);
  }

  Future<int> getOrderCountByUserId(int userId) async {
    final db = await database;
    var result = await db
        .rawQuery('SELECT COUNT(*) FROM orders WHERE user_id = ?', [userId]);
    return Sqflite.firstIntValue(result) ?? 0;
  }

  static Future<void> updateUserPassword(
      String email, String newPassword) async {
    final db = await _instance.database;
    await db.update(
      'users',
      {'password': newPassword.trim()},
      where: 'email = ?',
      whereArgs: [email],
    );

  }
}
