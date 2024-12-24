// State
class DrinkUpdateState {
  final int price;
  final String size;
  final String sweetness;
  final String ice;
  final String whiteBubble;
  final String whiteJelly;
  final String sweetAlmond;
  final int count;

  DrinkUpdateState({
    required this.price,
    required this.size,
    required this.sweetness,
    required this.ice,
    required this.whiteBubble,
    required this.whiteJelly,
    required this.sweetAlmond,
    required this.count,
  });

  DrinkUpdateState copyWith({
    int? price,
    String? size,
    String? sweetness,
    String? ice,
    String? whiteBubble,
    String? whiteJelly,
    String? sweetAlmond,
    int? count,
  }) {
    return DrinkUpdateState(
      price: price ?? this.price,
      size: size ?? this.size,
      sweetness: sweetness ?? this.sweetness,
      ice: ice ?? this.ice,
      whiteBubble: whiteBubble ?? this.whiteBubble,
      whiteJelly: whiteJelly ?? this.whiteJelly,
      sweetAlmond: sweetAlmond ?? this.sweetAlmond,
      count: count ?? this.count,
    );
  }
}
