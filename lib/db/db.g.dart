// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'db.dart';

// **************************************************************************
// MoorGenerator
// **************************************************************************

// ignore_for_file: unnecessary_brace_in_string_interps, unnecessary_this
class ProductData extends DataClass implements Insertable<ProductData> {
  final int id;
  final String name;
  final String image;
  final String? barcode;
  final int? parentId;
  final int? inventoryAmount;
  final double? price;
  ProductData(
      {required this.id,
      required this.name,
      required this.image,
      this.barcode,
      this.parentId,
      this.inventoryAmount,
      this.price});
  factory ProductData.fromData(Map<String, dynamic> data, GeneratedDatabase db,
      {String? prefix}) {
    final effectivePrefix = prefix ?? '';
    final intType = db.typeSystem.forDartType<int>();
    final stringType = db.typeSystem.forDartType<String>();
    final doubleType = db.typeSystem.forDartType<double>();
    return ProductData(
      id: intType.mapFromDatabaseResponse(data['${effectivePrefix}id'])!,
      name: stringType.mapFromDatabaseResponse(data['${effectivePrefix}name'])!,
      image:
          stringType.mapFromDatabaseResponse(data['${effectivePrefix}image'])!,
      barcode:
          stringType.mapFromDatabaseResponse(data['${effectivePrefix}barcode']),
      parentId:
          intType.mapFromDatabaseResponse(data['${effectivePrefix}parent_id']),
      inventoryAmount: intType
          .mapFromDatabaseResponse(data['${effectivePrefix}inventory_amount']),
      price:
          doubleType.mapFromDatabaseResponse(data['${effectivePrefix}price']),
    );
  }
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['name'] = Variable<String>(name);
    map['image'] = Variable<String>(image);
    if (!nullToAbsent || barcode != null) {
      map['barcode'] = Variable<String?>(barcode);
    }
    if (!nullToAbsent || parentId != null) {
      map['parent_id'] = Variable<int?>(parentId);
    }
    if (!nullToAbsent || inventoryAmount != null) {
      map['inventory_amount'] = Variable<int?>(inventoryAmount);
    }
    if (!nullToAbsent || price != null) {
      map['price'] = Variable<double?>(price);
    }
    return map;
  }

  ProductCompanion toCompanion(bool nullToAbsent) {
    return ProductCompanion(
      id: Value(id),
      name: Value(name),
      image: Value(image),
      barcode: barcode == null && nullToAbsent
          ? const Value.absent()
          : Value(barcode),
      parentId: parentId == null && nullToAbsent
          ? const Value.absent()
          : Value(parentId),
      inventoryAmount: inventoryAmount == null && nullToAbsent
          ? const Value.absent()
          : Value(inventoryAmount),
      price:
          price == null && nullToAbsent ? const Value.absent() : Value(price),
    );
  }

  factory ProductData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return ProductData(
      id: serializer.fromJson<int>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      image: serializer.fromJson<String>(json['image']),
      barcode: serializer.fromJson<String?>(json['barcode']),
      parentId: serializer.fromJson<int?>(json['parentId']),
      inventoryAmount: serializer.fromJson<int?>(json['inventoryAmount']),
      price: serializer.fromJson<double?>(json['price']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'name': serializer.toJson<String>(name),
      'image': serializer.toJson<String>(image),
      'barcode': serializer.toJson<String?>(barcode),
      'parentId': serializer.toJson<int?>(parentId),
      'inventoryAmount': serializer.toJson<int?>(inventoryAmount),
      'price': serializer.toJson<double?>(price),
    };
  }

  ProductData copyWith(
          {int? id,
          String? name,
          String? image,
          String? barcode,
          int? parentId,
          int? inventoryAmount,
          double? price}) =>
      ProductData(
        id: id ?? this.id,
        name: name ?? this.name,
        image: image ?? this.image,
        barcode: barcode ?? this.barcode,
        parentId: parentId ?? this.parentId,
        inventoryAmount: inventoryAmount ?? this.inventoryAmount,
        price: price ?? this.price,
      );
  @override
  String toString() {
    return (StringBuffer('ProductData(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('image: $image, ')
          ..write('barcode: $barcode, ')
          ..write('parentId: $parentId, ')
          ..write('inventoryAmount: $inventoryAmount, ')
          ..write('price: $price')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => $mrjf($mrjc(
      id.hashCode,
      $mrjc(
          name.hashCode,
          $mrjc(
              image.hashCode,
              $mrjc(
                  barcode.hashCode,
                  $mrjc(parentId.hashCode,
                      $mrjc(inventoryAmount.hashCode, price.hashCode)))))));
  @override
  bool operator ==(dynamic other) =>
      identical(this, other) ||
      (other is ProductData &&
          other.id == this.id &&
          other.name == this.name &&
          other.image == this.image &&
          other.barcode == this.barcode &&
          other.parentId == this.parentId &&
          other.inventoryAmount == this.inventoryAmount &&
          other.price == this.price);
}

class ProductCompanion extends UpdateCompanion<ProductData> {
  final Value<int> id;
  final Value<String> name;
  final Value<String> image;
  final Value<String?> barcode;
  final Value<int?> parentId;
  final Value<int?> inventoryAmount;
  final Value<double?> price;
  const ProductCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.image = const Value.absent(),
    this.barcode = const Value.absent(),
    this.parentId = const Value.absent(),
    this.inventoryAmount = const Value.absent(),
    this.price = const Value.absent(),
  });
  ProductCompanion.insert({
    this.id = const Value.absent(),
    required String name,
    required String image,
    this.barcode = const Value.absent(),
    this.parentId = const Value.absent(),
    this.inventoryAmount = const Value.absent(),
    this.price = const Value.absent(),
  })  : name = Value(name),
        image = Value(image);
  static Insertable<ProductData> custom({
    Expression<int>? id,
    Expression<String>? name,
    Expression<String>? image,
    Expression<String?>? barcode,
    Expression<int?>? parentId,
    Expression<int?>? inventoryAmount,
    Expression<double?>? price,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (image != null) 'image': image,
      if (barcode != null) 'barcode': barcode,
      if (parentId != null) 'parent_id': parentId,
      if (inventoryAmount != null) 'inventory_amount': inventoryAmount,
      if (price != null) 'price': price,
    });
  }

  ProductCompanion copyWith(
      {Value<int>? id,
      Value<String>? name,
      Value<String>? image,
      Value<String?>? barcode,
      Value<int?>? parentId,
      Value<int?>? inventoryAmount,
      Value<double?>? price}) {
    return ProductCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      image: image ?? this.image,
      barcode: barcode ?? this.barcode,
      parentId: parentId ?? this.parentId,
      inventoryAmount: inventoryAmount ?? this.inventoryAmount,
      price: price ?? this.price,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (image.present) {
      map['image'] = Variable<String>(image.value);
    }
    if (barcode.present) {
      map['barcode'] = Variable<String?>(barcode.value);
    }
    if (parentId.present) {
      map['parent_id'] = Variable<int?>(parentId.value);
    }
    if (inventoryAmount.present) {
      map['inventory_amount'] = Variable<int?>(inventoryAmount.value);
    }
    if (price.present) {
      map['price'] = Variable<double?>(price.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ProductCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('image: $image, ')
          ..write('barcode: $barcode, ')
          ..write('parentId: $parentId, ')
          ..write('inventoryAmount: $inventoryAmount, ')
          ..write('price: $price')
          ..write(')'))
        .toString();
  }
}

class $ProductTable extends Product with TableInfo<$ProductTable, ProductData> {
  final GeneratedDatabase _db;
  final String? _alias;
  $ProductTable(this._db, [this._alias]);
  final VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedIntColumn id = _constructId();
  GeneratedIntColumn _constructId() {
    return GeneratedIntColumn('id', $tableName, false,
        hasAutoIncrement: true, declaredAsPrimaryKey: true);
  }

  final VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedTextColumn name = _constructName();
  GeneratedTextColumn _constructName() {
    return GeneratedTextColumn('name', $tableName, false,
        minTextLength: 3, maxTextLength: 32);
  }

  final VerificationMeta _imageMeta = const VerificationMeta('image');
  @override
  late final GeneratedTextColumn image = _constructImage();
  GeneratedTextColumn _constructImage() {
    return GeneratedTextColumn(
      'image',
      $tableName,
      false,
    );
  }

  final VerificationMeta _barcodeMeta = const VerificationMeta('barcode');
  @override
  late final GeneratedTextColumn barcode = _constructBarcode();
  GeneratedTextColumn _constructBarcode() {
    return GeneratedTextColumn(
      'barcode',
      $tableName,
      true,
    );
  }

  final VerificationMeta _parentIdMeta = const VerificationMeta('parentId');
  @override
  late final GeneratedIntColumn parentId = _constructParentId();
  GeneratedIntColumn _constructParentId() {
    return GeneratedIntColumn(
      'parent_id',
      $tableName,
      true,
    );
  }

  final VerificationMeta _inventoryAmountMeta =
      const VerificationMeta('inventoryAmount');
  @override
  late final GeneratedIntColumn inventoryAmount = _constructInventoryAmount();
  GeneratedIntColumn _constructInventoryAmount() {
    return GeneratedIntColumn(
      'inventory_amount',
      $tableName,
      true,
    );
  }

  final VerificationMeta _priceMeta = const VerificationMeta('price');
  @override
  late final GeneratedRealColumn price = _constructPrice();
  GeneratedRealColumn _constructPrice() {
    return GeneratedRealColumn(
      'price',
      $tableName,
      true,
    );
  }

  @override
  List<GeneratedColumn> get $columns =>
      [id, name, image, barcode, parentId, inventoryAmount, price];
  @override
  $ProductTable get asDslTable => this;
  @override
  String get $tableName => _alias ?? 'product';
  @override
  final String actualTableName = 'product';
  @override
  VerificationContext validateIntegrity(Insertable<ProductData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('name')) {
      context.handle(
          _nameMeta, name.isAcceptableOrUnknown(data['name']!, _nameMeta));
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('image')) {
      context.handle(
          _imageMeta, image.isAcceptableOrUnknown(data['image']!, _imageMeta));
    } else if (isInserting) {
      context.missing(_imageMeta);
    }
    if (data.containsKey('barcode')) {
      context.handle(_barcodeMeta,
          barcode.isAcceptableOrUnknown(data['barcode']!, _barcodeMeta));
    }
    if (data.containsKey('parent_id')) {
      context.handle(_parentIdMeta,
          parentId.isAcceptableOrUnknown(data['parent_id']!, _parentIdMeta));
    }
    if (data.containsKey('inventory_amount')) {
      context.handle(
          _inventoryAmountMeta,
          inventoryAmount.isAcceptableOrUnknown(
              data['inventory_amount']!, _inventoryAmountMeta));
    }
    if (data.containsKey('price')) {
      context.handle(
          _priceMeta, price.isAcceptableOrUnknown(data['price']!, _priceMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  ProductData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : null;
    return ProductData.fromData(data, _db, prefix: effectivePrefix);
  }

  @override
  $ProductTable createAlias(String alias) {
    return $ProductTable(_db, alias);
  }
}

class SaleData extends DataClass implements Insertable<SaleData> {
  final int saleId;
  final DateTime saleDateTime;
  final double totalPrice;
  final String? itemsPurchased;
  SaleData(
      {required this.saleId,
      required this.saleDateTime,
      required this.totalPrice,
      this.itemsPurchased});
  factory SaleData.fromData(Map<String, dynamic> data, GeneratedDatabase db,
      {String? prefix}) {
    final effectivePrefix = prefix ?? '';
    final intType = db.typeSystem.forDartType<int>();
    final dateTimeType = db.typeSystem.forDartType<DateTime>();
    final doubleType = db.typeSystem.forDartType<double>();
    final stringType = db.typeSystem.forDartType<String>();
    return SaleData(
      saleId:
          intType.mapFromDatabaseResponse(data['${effectivePrefix}sale_id'])!,
      saleDateTime: dateTimeType
          .mapFromDatabaseResponse(data['${effectivePrefix}sale_date_time'])!,
      totalPrice: doubleType
          .mapFromDatabaseResponse(data['${effectivePrefix}total_price'])!,
      itemsPurchased: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}items_purchased']),
    );
  }
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['sale_id'] = Variable<int>(saleId);
    map['sale_date_time'] = Variable<DateTime>(saleDateTime);
    map['total_price'] = Variable<double>(totalPrice);
    if (!nullToAbsent || itemsPurchased != null) {
      map['items_purchased'] = Variable<String?>(itemsPurchased);
    }
    return map;
  }

  SaleCompanion toCompanion(bool nullToAbsent) {
    return SaleCompanion(
      saleId: Value(saleId),
      saleDateTime: Value(saleDateTime),
      totalPrice: Value(totalPrice),
      itemsPurchased: itemsPurchased == null && nullToAbsent
          ? const Value.absent()
          : Value(itemsPurchased),
    );
  }

  factory SaleData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return SaleData(
      saleId: serializer.fromJson<int>(json['saleId']),
      saleDateTime: serializer.fromJson<DateTime>(json['saleDateTime']),
      totalPrice: serializer.fromJson<double>(json['totalPrice']),
      itemsPurchased: serializer.fromJson<String?>(json['itemsPurchased']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'saleId': serializer.toJson<int>(saleId),
      'saleDateTime': serializer.toJson<DateTime>(saleDateTime),
      'totalPrice': serializer.toJson<double>(totalPrice),
      'itemsPurchased': serializer.toJson<String?>(itemsPurchased),
    };
  }

  SaleData copyWith(
          {int? saleId,
          DateTime? saleDateTime,
          double? totalPrice,
          String? itemsPurchased}) =>
      SaleData(
        saleId: saleId ?? this.saleId,
        saleDateTime: saleDateTime ?? this.saleDateTime,
        totalPrice: totalPrice ?? this.totalPrice,
        itemsPurchased: itemsPurchased ?? this.itemsPurchased,
      );
  @override
  String toString() {
    return (StringBuffer('SaleData(')
          ..write('saleId: $saleId, ')
          ..write('saleDateTime: $saleDateTime, ')
          ..write('totalPrice: $totalPrice, ')
          ..write('itemsPurchased: $itemsPurchased')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => $mrjf($mrjc(
      saleId.hashCode,
      $mrjc(saleDateTime.hashCode,
          $mrjc(totalPrice.hashCode, itemsPurchased.hashCode))));
  @override
  bool operator ==(dynamic other) =>
      identical(this, other) ||
      (other is SaleData &&
          other.saleId == this.saleId &&
          other.saleDateTime == this.saleDateTime &&
          other.totalPrice == this.totalPrice &&
          other.itemsPurchased == this.itemsPurchased);
}

class SaleCompanion extends UpdateCompanion<SaleData> {
  final Value<int> saleId;
  final Value<DateTime> saleDateTime;
  final Value<double> totalPrice;
  final Value<String?> itemsPurchased;
  const SaleCompanion({
    this.saleId = const Value.absent(),
    this.saleDateTime = const Value.absent(),
    this.totalPrice = const Value.absent(),
    this.itemsPurchased = const Value.absent(),
  });
  SaleCompanion.insert({
    this.saleId = const Value.absent(),
    required DateTime saleDateTime,
    required double totalPrice,
    this.itemsPurchased = const Value.absent(),
  })  : saleDateTime = Value(saleDateTime),
        totalPrice = Value(totalPrice);
  static Insertable<SaleData> custom({
    Expression<int>? saleId,
    Expression<DateTime>? saleDateTime,
    Expression<double>? totalPrice,
    Expression<String?>? itemsPurchased,
  }) {
    return RawValuesInsertable({
      if (saleId != null) 'sale_id': saleId,
      if (saleDateTime != null) 'sale_date_time': saleDateTime,
      if (totalPrice != null) 'total_price': totalPrice,
      if (itemsPurchased != null) 'items_purchased': itemsPurchased,
    });
  }

  SaleCompanion copyWith(
      {Value<int>? saleId,
      Value<DateTime>? saleDateTime,
      Value<double>? totalPrice,
      Value<String?>? itemsPurchased}) {
    return SaleCompanion(
      saleId: saleId ?? this.saleId,
      saleDateTime: saleDateTime ?? this.saleDateTime,
      totalPrice: totalPrice ?? this.totalPrice,
      itemsPurchased: itemsPurchased ?? this.itemsPurchased,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (saleId.present) {
      map['sale_id'] = Variable<int>(saleId.value);
    }
    if (saleDateTime.present) {
      map['sale_date_time'] = Variable<DateTime>(saleDateTime.value);
    }
    if (totalPrice.present) {
      map['total_price'] = Variable<double>(totalPrice.value);
    }
    if (itemsPurchased.present) {
      map['items_purchased'] = Variable<String?>(itemsPurchased.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('SaleCompanion(')
          ..write('saleId: $saleId, ')
          ..write('saleDateTime: $saleDateTime, ')
          ..write('totalPrice: $totalPrice, ')
          ..write('itemsPurchased: $itemsPurchased')
          ..write(')'))
        .toString();
  }
}

class $SaleTable extends Sale with TableInfo<$SaleTable, SaleData> {
  final GeneratedDatabase _db;
  final String? _alias;
  $SaleTable(this._db, [this._alias]);
  final VerificationMeta _saleIdMeta = const VerificationMeta('saleId');
  @override
  late final GeneratedIntColumn saleId = _constructSaleId();
  GeneratedIntColumn _constructSaleId() {
    return GeneratedIntColumn('sale_id', $tableName, false,
        hasAutoIncrement: true, declaredAsPrimaryKey: true);
  }

  final VerificationMeta _saleDateTimeMeta =
      const VerificationMeta('saleDateTime');
  @override
  late final GeneratedDateTimeColumn saleDateTime = _constructSaleDateTime();
  GeneratedDateTimeColumn _constructSaleDateTime() {
    return GeneratedDateTimeColumn(
      'sale_date_time',
      $tableName,
      false,
    );
  }

  final VerificationMeta _totalPriceMeta = const VerificationMeta('totalPrice');
  @override
  late final GeneratedRealColumn totalPrice = _constructTotalPrice();
  GeneratedRealColumn _constructTotalPrice() {
    return GeneratedRealColumn(
      'total_price',
      $tableName,
      false,
    );
  }

  final VerificationMeta _itemsPurchasedMeta =
      const VerificationMeta('itemsPurchased');
  @override
  late final GeneratedTextColumn itemsPurchased = _constructItemsPurchased();
  GeneratedTextColumn _constructItemsPurchased() {
    return GeneratedTextColumn(
      'items_purchased',
      $tableName,
      true,
    );
  }

  @override
  List<GeneratedColumn> get $columns =>
      [saleId, saleDateTime, totalPrice, itemsPurchased];
  @override
  $SaleTable get asDslTable => this;
  @override
  String get $tableName => _alias ?? 'sale';
  @override
  final String actualTableName = 'sale';
  @override
  VerificationContext validateIntegrity(Insertable<SaleData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('sale_id')) {
      context.handle(_saleIdMeta,
          saleId.isAcceptableOrUnknown(data['sale_id']!, _saleIdMeta));
    }
    if (data.containsKey('sale_date_time')) {
      context.handle(
          _saleDateTimeMeta,
          saleDateTime.isAcceptableOrUnknown(
              data['sale_date_time']!, _saleDateTimeMeta));
    } else if (isInserting) {
      context.missing(_saleDateTimeMeta);
    }
    if (data.containsKey('total_price')) {
      context.handle(
          _totalPriceMeta,
          totalPrice.isAcceptableOrUnknown(
              data['total_price']!, _totalPriceMeta));
    } else if (isInserting) {
      context.missing(_totalPriceMeta);
    }
    if (data.containsKey('items_purchased')) {
      context.handle(
          _itemsPurchasedMeta,
          itemsPurchased.isAcceptableOrUnknown(
              data['items_purchased']!, _itemsPurchasedMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {saleId};
  @override
  SaleData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : null;
    return SaleData.fromData(data, _db, prefix: effectivePrefix);
  }

  @override
  $SaleTable createAlias(String alias) {
    return $SaleTable(_db, alias);
  }
}

class DiscountData extends DataClass implements Insertable<DiscountData> {
  final int productId;
  final double salePrice;
  final DateTime expirationDateTime;
  DiscountData(
      {required this.productId,
      required this.salePrice,
      required this.expirationDateTime});
  factory DiscountData.fromData(Map<String, dynamic> data, GeneratedDatabase db,
      {String? prefix}) {
    final effectivePrefix = prefix ?? '';
    final intType = db.typeSystem.forDartType<int>();
    final doubleType = db.typeSystem.forDartType<double>();
    final dateTimeType = db.typeSystem.forDartType<DateTime>();
    return DiscountData(
      productId: intType
          .mapFromDatabaseResponse(data['${effectivePrefix}product_id'])!,
      salePrice: doubleType
          .mapFromDatabaseResponse(data['${effectivePrefix}sale_price'])!,
      expirationDateTime: dateTimeType.mapFromDatabaseResponse(
          data['${effectivePrefix}expiration_date_time'])!,
    );
  }
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['product_id'] = Variable<int>(productId);
    map['sale_price'] = Variable<double>(salePrice);
    map['expiration_date_time'] = Variable<DateTime>(expirationDateTime);
    return map;
  }

  DiscountCompanion toCompanion(bool nullToAbsent) {
    return DiscountCompanion(
      productId: Value(productId),
      salePrice: Value(salePrice),
      expirationDateTime: Value(expirationDateTime),
    );
  }

  factory DiscountData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return DiscountData(
      productId: serializer.fromJson<int>(json['productId']),
      salePrice: serializer.fromJson<double>(json['salePrice']),
      expirationDateTime:
          serializer.fromJson<DateTime>(json['expirationDateTime']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'productId': serializer.toJson<int>(productId),
      'salePrice': serializer.toJson<double>(salePrice),
      'expirationDateTime': serializer.toJson<DateTime>(expirationDateTime),
    };
  }

  DiscountData copyWith(
          {int? productId, double? salePrice, DateTime? expirationDateTime}) =>
      DiscountData(
        productId: productId ?? this.productId,
        salePrice: salePrice ?? this.salePrice,
        expirationDateTime: expirationDateTime ?? this.expirationDateTime,
      );
  @override
  String toString() {
    return (StringBuffer('DiscountData(')
          ..write('productId: $productId, ')
          ..write('salePrice: $salePrice, ')
          ..write('expirationDateTime: $expirationDateTime')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => $mrjf($mrjc(productId.hashCode,
      $mrjc(salePrice.hashCode, expirationDateTime.hashCode)));
  @override
  bool operator ==(dynamic other) =>
      identical(this, other) ||
      (other is DiscountData &&
          other.productId == this.productId &&
          other.salePrice == this.salePrice &&
          other.expirationDateTime == this.expirationDateTime);
}

class DiscountCompanion extends UpdateCompanion<DiscountData> {
  final Value<int> productId;
  final Value<double> salePrice;
  final Value<DateTime> expirationDateTime;
  const DiscountCompanion({
    this.productId = const Value.absent(),
    this.salePrice = const Value.absent(),
    this.expirationDateTime = const Value.absent(),
  });
  DiscountCompanion.insert({
    required int productId,
    required double salePrice,
    required DateTime expirationDateTime,
  })  : productId = Value(productId),
        salePrice = Value(salePrice),
        expirationDateTime = Value(expirationDateTime);
  static Insertable<DiscountData> custom({
    Expression<int>? productId,
    Expression<double>? salePrice,
    Expression<DateTime>? expirationDateTime,
  }) {
    return RawValuesInsertable({
      if (productId != null) 'product_id': productId,
      if (salePrice != null) 'sale_price': salePrice,
      if (expirationDateTime != null)
        'expiration_date_time': expirationDateTime,
    });
  }

  DiscountCompanion copyWith(
      {Value<int>? productId,
      Value<double>? salePrice,
      Value<DateTime>? expirationDateTime}) {
    return DiscountCompanion(
      productId: productId ?? this.productId,
      salePrice: salePrice ?? this.salePrice,
      expirationDateTime: expirationDateTime ?? this.expirationDateTime,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (productId.present) {
      map['product_id'] = Variable<int>(productId.value);
    }
    if (salePrice.present) {
      map['sale_price'] = Variable<double>(salePrice.value);
    }
    if (expirationDateTime.present) {
      map['expiration_date_time'] =
          Variable<DateTime>(expirationDateTime.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('DiscountCompanion(')
          ..write('productId: $productId, ')
          ..write('salePrice: $salePrice, ')
          ..write('expirationDateTime: $expirationDateTime')
          ..write(')'))
        .toString();
  }
}

class $DiscountTable extends Discount
    with TableInfo<$DiscountTable, DiscountData> {
  final GeneratedDatabase _db;
  final String? _alias;
  $DiscountTable(this._db, [this._alias]);
  final VerificationMeta _productIdMeta = const VerificationMeta('productId');
  @override
  late final GeneratedIntColumn productId = _constructProductId();
  GeneratedIntColumn _constructProductId() {
    return GeneratedIntColumn(
      'product_id',
      $tableName,
      false,
    );
  }

  final VerificationMeta _salePriceMeta = const VerificationMeta('salePrice');
  @override
  late final GeneratedRealColumn salePrice = _constructSalePrice();
  GeneratedRealColumn _constructSalePrice() {
    return GeneratedRealColumn(
      'sale_price',
      $tableName,
      false,
    );
  }

  final VerificationMeta _expirationDateTimeMeta =
      const VerificationMeta('expirationDateTime');
  @override
  late final GeneratedDateTimeColumn expirationDateTime =
      _constructExpirationDateTime();
  GeneratedDateTimeColumn _constructExpirationDateTime() {
    return GeneratedDateTimeColumn(
      'expiration_date_time',
      $tableName,
      false,
    );
  }

  @override
  List<GeneratedColumn> get $columns =>
      [productId, salePrice, expirationDateTime];
  @override
  $DiscountTable get asDslTable => this;
  @override
  String get $tableName => _alias ?? 'discount';
  @override
  final String actualTableName = 'discount';
  @override
  VerificationContext validateIntegrity(Insertable<DiscountData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('product_id')) {
      context.handle(_productIdMeta,
          productId.isAcceptableOrUnknown(data['product_id']!, _productIdMeta));
    } else if (isInserting) {
      context.missing(_productIdMeta);
    }
    if (data.containsKey('sale_price')) {
      context.handle(_salePriceMeta,
          salePrice.isAcceptableOrUnknown(data['sale_price']!, _salePriceMeta));
    } else if (isInserting) {
      context.missing(_salePriceMeta);
    }
    if (data.containsKey('expiration_date_time')) {
      context.handle(
          _expirationDateTimeMeta,
          expirationDateTime.isAcceptableOrUnknown(
              data['expiration_date_time']!, _expirationDateTimeMeta));
    } else if (isInserting) {
      context.missing(_expirationDateTimeMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => <GeneratedColumn>{};
  @override
  DiscountData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : null;
    return DiscountData.fromData(data, _db, prefix: effectivePrefix);
  }

  @override
  $DiscountTable createAlias(String alias) {
    return $DiscountTable(_db, alias);
  }
}

abstract class _$MyDatabase extends GeneratedDatabase {
  _$MyDatabase(QueryExecutor e) : super(SqlTypeSystem.defaultInstance, e);
  late final $ProductTable product = $ProductTable(this);
  late final $SaleTable sale = $SaleTable(this);
  late final $DiscountTable discount = $DiscountTable(this);
  @override
  Iterable<TableInfo> get allTables => allSchemaEntities.whereType<TableInfo>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [product, sale, discount];
}
