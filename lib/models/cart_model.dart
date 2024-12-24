class Cart {
  String id;
  String drinkName;
  String size;
  String sweetness;
  String ice;
  String username;
  String price;
  String count;
  String whiteBubble;
  String whiteJelly;
  String sweetAlmond;

  Cart(
    this.id,
    this.drinkName,
    this.size,
    this.sweetness,
    this.ice,
    this.username,
    this.price,
    this.count,
    this.whiteBubble,
    this.whiteJelly,
    this.sweetAlmond,
  );

  Cart copyWith({
    String? id,
    String? drinkName,
    String? size,
    String? sweetness,
    String? ice,
    String? username,
    String? price,
    String? count,
    String? whiteBubble,
    String? whiteJelly,
    String? sweetAlmond,
  }) {
    return Cart(
      id ?? this.id,
      drinkName ?? this.drinkName,
      size ?? this.size,
      sweetness ?? this.sweetness,
      ice ?? this.ice,
      username ?? this.username,
      price ?? this.price,
      count ?? this.count,
      whiteBubble ?? this.whiteBubble,
      whiteJelly ?? this.whiteJelly,
      sweetAlmond ?? this.sweetAlmond,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "drinkName": drinkName,
      "size": size,
      "sweetness": sweetness,
      "ice": ice,
      "name": username,
      "price": price,
      "count": count,
      "whiteBubble": whiteBubble,
      "whiteJelly": whiteJelly,
      "sweetAlmond": sweetAlmond,
    };
  }
}

class CartRecords {
  CartRecord records;

  CartRecords(this.records);
}

class CartRecord {
  Cart fields;

  CartRecord(this.fields);

  Map<String, dynamic> toJson() {
    return {
      "fields": fields.toJson(),
    };
  }
}
