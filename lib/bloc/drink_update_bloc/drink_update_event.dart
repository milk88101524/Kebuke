// Event
abstract class DrinkUpdateEvent {}

class UpdateSize extends DrinkUpdateEvent {
  final String size;
  UpdateSize(this.size);
}

class UpdateSweetness extends DrinkUpdateEvent {
  final String sweetness;
  UpdateSweetness(this.sweetness);
}

class UpdateIce extends DrinkUpdateEvent {
  final String ice;
  UpdateIce(this.ice);
}

class UpdateWhiteBubble extends DrinkUpdateEvent {
  final String whiteBubble;
  UpdateWhiteBubble(this.whiteBubble);
}

class UpdateWhiteJelly extends DrinkUpdateEvent {
  final String whiteJelly;
  UpdateWhiteJelly(this.whiteJelly);
}

class UpdateSweetAlmond extends DrinkUpdateEvent {
  final String sweetAlmond;
  UpdateSweetAlmond(this.sweetAlmond);
}

class Increment extends DrinkUpdateEvent {
  final int count;
  Increment(this.count);
}

class Decrement extends DrinkUpdateEvent {
  final int count;
  Decrement(this.count);
}
