class DrinkCategory {
  String category;
  Drink drinks;

  DrinkCategory(this.category, this.drinks);
}

class Drink {
  String name;
  DrinkPrice price;
  String desc;
  String img;

  Drink(this.name, this.price, this.desc, this.img);
}

class DrinkPrice {
  int M;
  int L;

  DrinkPrice(this.M, this.L);
}
