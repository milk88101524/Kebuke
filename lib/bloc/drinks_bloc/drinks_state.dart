abstract class DrinksState {
  DrinksState();

  List<Object?> get props => [];
}

class DrinkInitial extends DrinksState {}

class DrinkLoading extends DrinksState {}

class DrinkLoadSuccess extends DrinksState {
  final List drinks;

  DrinkLoadSuccess(this.drinks);

  @override
  List<Object?> get props => [];
}

class DrinkLoadFail extends DrinksState {
  final String message;

  DrinkLoadFail(this.message);

  @override
  List<Object?> get props => [message];
}
