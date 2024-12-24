import 'dart:convert';

import 'package:flu_drinks/models/cart_model.dart';
import 'package:flu_drinks/models/drink_model.dart';
import 'package:http/http.dart' as http;

String drinkMenuUri =
    "https://raw.githubusercontent.com/milk88101524/kebukeMenu/main/kebukeMenu.json";
String drinkCartUri = "https://api.airtable.com/v0/appWGfuE25modmD0d/Drinks";
String drinkOrderUri = "https://api.airtable.com/v0/appWGfuE25modmD0d/Orders";

String _apiKey =
    "patyjW8yHd1cIRrxQ.4ee43e8302ed9be89bb00ed74339af553528828a171ad4d79552b6149cc295af";

Future<List> showGitMenu() async {
  List<Drink> menu = [];
  var response = await http.get(Uri.parse(drinkMenuUri));

  for (var category in jsonDecode(response.body)) {
    for (var drink in category['drinks']) {
      menu.add(
        Drink(
          drink['name'],
          DrinkPrice(drink['price']['M'], drink['price']['L']),
          drink['desc'],
          drink['img'],
        ),
      );
    }
  }
  return menu;
}

Future<Drink> findDrink(String drinkName) async {
  var data = null;
  var response = await http.get(Uri.parse(drinkMenuUri));

  if (response.statusCode == 200) {
    for (var category in jsonDecode(response.body)) {
      for (var drink in category['drinks']) {
        if (drink['name'] == drinkName) {
          data = Drink(
            drink['name'],
            DrinkPrice(drink['price']['M'], drink['price']['L']),
            drink['desc'],
            drink['img'],
          );
        }
      }
    }
    return data;
  } else {
    throw Exception("Failed to load carts");
  }
}

Future<List<Cart>> fetchCart() async {
  List<Cart> carts = [];
  var response = await http.get(
    Uri.parse(drinkCartUri),
    headers: {"Authorization": "Bearer $_apiKey"},
  );

  if (response.statusCode == 200) {
    var records = jsonDecode(response.body)['records'];

    // 遍歷每個 record
    for (var record in records) {
      var fields = record['fields'];
      carts.add(Cart(
        fields['id'],
        fields['drinkName'],
        fields['size'],
        fields['sweetness'],
        fields['ice'],
        fields['name'],
        fields['price'],
        fields['count'],
        fields['whiteBubble'],
        fields['whiteJelly'],
        fields['sweetAlmond'],
      ));
    }
    return carts;
  } else {
    throw Exception("Failed to load carts");
  }
}

Future<int> getCartCount() async {
  int count = 0;
  var response = await http.get(
    Uri.parse(drinkCartUri),
    headers: {"Authorization": "Bearer $_apiKey"},
  );

  if (response.statusCode == 200) {
    var records = jsonDecode(response.body)['records'];

    // 遍歷每個 record
    for (var record in records) {
      var fields = record['fields'];
      count = count + int.parse(fields['count']);
    }
    return count;
  } else {
    throw Exception("Failed to get count");
  }
}

Future<List> fetchOrder() async {
  List<Cart> orders = [];
  var response = await http.get(
    Uri.parse(drinkOrderUri),
    headers: {"Authorization": "Bearer $_apiKey"},
  );

  if (response.statusCode == 200) {
    var records = jsonDecode(response.body)['records'];

    for (var record in records) {
      var fields = record['fields'];
      orders.add(Cart(
        fields['id'],
        fields['drinkName'],
        fields['size'],
        fields['sweetness'],
        fields['ice'],
        fields['name'],
        fields['price'],
        fields['count'],
        fields['whiteBubble'],
        fields['whiteJelly'],
        fields['sweetAlmond'],
      ));
    }
    return orders;
  } else {
    throw Exception("Failed to load orders");
  }
}

Future<int> getOrderCount() async {
  int count = 0;
  var response = await http.get(
    Uri.parse(drinkOrderUri),
    headers: {"Authorization": "Bearer $_apiKey"},
  );

  if (response.statusCode == 200) {
    var records = jsonDecode(response.body)['records'];

    for (var record in records) {
      var fields = record['fields'];
      count = count + int.parse(fields['count']);
    }
    return count;
  } else {
    throw Exception("Failed to get count");
  }
}

Future<void> addCart(Cart cart) async {
  Map<String, dynamic> payload = {
    "records": [
      CartRecord(cart).toJson(),
    ]
  };

  print(payload);

  var response = await http.post(
    Uri.parse(drinkCartUri),
    headers: {
      "Authorization": "Bearer $_apiKey",
      "Content-Type": "application/json"
    },
    body: jsonEncode(payload),
  );

  if (response.statusCode == 200) {
    print("Successfully");
  } else {
    throw Exception(
      "Failed to send data: ${response.statusCode} ${response.body}",
    );
  }
}

Future<String> findRecordID(String id) async {
  // test
  // String id = "69cff1b0-eda8-4fb5-a9b6-88c3493cfdf2";
  String recordId = "";
  var response = await http.get(
    Uri.parse(
        "https://api.airtable.com/v0/appWGfuE25modmD0d/Drinks?filterByFormula=({id} = '$id')"),
    headers: {
      "Authorization": "Bearer $_apiKey",
    },
  );

  if (response.statusCode == 200) {
    var record = jsonDecode(response.body)["records"];
    for (var recordID in record) {
      recordId = recordID["id"];
    }
    return recordId;
  } else {
    return ("Failed to send data: ${response.statusCode} ${response.body}");
  }
}

Future<void> editCartCount(String id, String count) async {
  Map<String, dynamic> payload = {
    "fields": {"count": count}
  };
  String recordId = await findRecordID(id);

  var response = await http.patch(
    Uri.parse("https://api.airtable.com/v0/appWGfuE25modmD0d/Drinks/$recordId"),
    headers: {
      "Authorization": "Bearer $_apiKey",
      "Content-Type": "application/json"
    },
    body: jsonEncode(payload),
  );

  if (response.statusCode == 200) {
    print("Successfully");
  } else {
    throw Exception(
      "Failed to send data: ${response.statusCode} ${response.body}",
    );
  }
}

Future<void> editCart(Cart cart) async {
  String recordId = await findRecordID(cart.id);

  print(CartRecord(cart).toJson());

  var response = await http.patch(
    Uri.parse("https://api.airtable.com/v0/appWGfuE25modmD0d/Drinks/$recordId"),
    headers: {
      "Authorization": "Bearer $_apiKey",
      "Content-Type": "application/json"
    },
    body: jsonEncode(CartRecord(cart).toJson()),
  );

  if (response.statusCode == 200) {
    print("Successfully");
  } else {
    print("Failed to send data: ${response.statusCode} ${response.body}");
    throw Exception(
      "Failed to send data: ${response.statusCode} ${response.body}",
    );
  }
}

Future<void> deleteCart(String id) async {
  String recordId = await findRecordID(id);

  var response = await http.delete(
    Uri.parse("https://api.airtable.com/v0/appWGfuE25modmD0d/Drinks/$recordId"),
    headers: {"Authorization": "Bearer $_apiKey"},
  );

  if (response.statusCode == 200) {
    print("Successfully");
  } else {
    throw Exception(
      "Failed to send data: ${response.statusCode} ${response.body}",
    );
  }
}

Future<void> addOrder(List<Cart> carts) async {
  Map<String, dynamic> payload = {
    "records": carts.map((cart) => CartRecord(cart).toJson()).toList(),
  };

  var response = await http.post(
    Uri.parse(drinkOrderUri),
    headers: {
      "Authorization": "Bearer $_apiKey",
      "Content-Type": "application/json"
    },
    body: jsonEncode(payload),
  );

  if (response.statusCode == 200) {
    print("Successfully");
  } else {
    throw Exception(
      "Failed to send data: ${response.statusCode} ${response.body}",
    );
  }
}
