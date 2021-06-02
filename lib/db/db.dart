import 'dart:io';

import 'package:barcode/barcode.dart';
import 'package:brother_app/util/barcode_helper.dart';
import 'package:brother_app/util/print_helper.dart';
import 'package:moor/ffi.dart';
import 'package:moor/moor.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';

part 'db.g.dart';

//RUN flutter packages pub run build_runner build
//TO REFRESH

class Product extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get name => text().withLength(min: 3, max: 32)();
  TextColumn get image => text()();
  TextColumn get barcode => text().nullable()();
  IntColumn get parentId => integer().nullable()();
  IntColumn get inventoryAmount => integer().nullable()();
  RealColumn get price => real().nullable()();
}

class Discount extends Table {
  IntColumn get productId => integer()();
  RealColumn get salePrice => real()();
  DateTimeColumn get expirationDateTime => dateTime()();
}

class Sale extends Table {
  IntColumn get saleId => integer().autoIncrement()();
  DateTimeColumn get saleDateTime => dateTime()();
  RealColumn get totalPrice => real()();
  TextColumn get itemsPurchased => text().nullable()();
}

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(p.join(dbFolder.path, 'db.sqlite'));
    return VmDatabase(file);
  });
}

@UseMoor(tables: [Product, Sale, Discount])
class MyDatabase extends _$MyDatabase {
  // we tell the database where to store the data with this constructor
  MyDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 1;

  Future createProduct(ProductCompanion entry) async {
    int productId = await into(product).insert(entry);
    String barcode = buildBarcode(Barcode.code128(), productId.toString(),
        height: DEFAULT_BARCODE_HEIGHT.toDouble(),
        width: DEFAULT_BARCODE_WIDTH.toDouble());
    ProductCompanion newEntry =
        entry.copyWith(barcode: Value(barcode), id: Value(productId));

    //TEST: Print barcode on save
    // printBarcodeData(productId.toString());
    // print("updating db and printing barcode with id: " + productId.toString());
    //printLabel(imageFromBase64String(barcode) as ui.Image);

    await update(product).replace(newEntry);
  }

  Future<List<ProductData>> getAllProducts() {
    return select(product).get();
  }

  Future createSale(SaleCompanion entry) {
    return into(sale).insert(entry);
  }

  Future<List<ProductData>> getAllProductsForIds(List<int> ids) {
    var query = select(product)..where((t) => t.id.isIn(ids));
    return query.get();
  }

  Future<ProductData> getProductForId(int id) {
    var query = select(product)..where((t) => t.id.equals(id));
    return query.getSingle();
  }

  Future decrementInventoryAmountForProduct(int id, int amount) async {
    ProductData p = await getProductForId(id);
    return update(product).replace(new ProductData(
        id: p.id,
        name: p.name,
        inventoryAmount: p.inventoryAmount! - amount,
        image: p.image));
  }
}
