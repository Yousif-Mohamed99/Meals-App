import 'package:meals_app/models/meal.dart';
import 'package:riverpod/riverpod.dart';

class FavoriteMealsNotifier extends StateNotifier<List<Meal>> {
  FavoriteMealsNotifier() : super([]);

  bool toggleFavorite(Meal meal) {
    final mealIsFav = state.contains(meal);

    if (mealIsFav) {
      state = state.where((m) => m.id != meal.id).toList();
      // This filters the state list to exclude the meal with the matching id.
      return false; // indicates the meal is no longer a favorite.
    } else {
      state = [...state, meal];
      // This creates a new list by spreading the current state and appending the meal, effectively adding the meal to the favorites list.
      return true; // ndicates the meal is now a favorite.
    }
  }
}

final favoriteMealsProvider =
    StateNotifierProvider<FavoriteMealsNotifier, List<Meal>>(
      (ref) => FavoriteMealsNotifier(),
    );
