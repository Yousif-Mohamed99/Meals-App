import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meals_app/data/dummy_data.dart';
import 'package:meals_app/provider/favorites_provider.dart';
import 'package:meals_app/provider/filters_provider.dart';
import 'package:meals_app/views/categories.dart';
import 'package:meals_app/views/filters.dart';
import 'package:meals_app/views/meals.dart';
import 'package:meals_app/widgets/main_drawer.dart';

// tabs navigation requires its own screen which then loads other screens as embedded screens

const kInitialFilters = {
  Filter.glutenFree: false,
  Filter.lactoseFree: false,
  Filter.vegetarian: false,
  Filter.vegan: false,
};

class TabsScreen extends ConsumerStatefulWidget {
  const TabsScreen({super.key});
  @override
  ConsumerState<TabsScreen> createState() {
    return _TabsScreenState();
  }
}

class _TabsScreenState extends ConsumerState<TabsScreen> {
  var selectedPageIndex = 0;

  void _selectPage(int index) {
    setState(() {
      selectedPageIndex = index;
    });
  }

  void _setScreen(String identifier) async {
    Navigator.of(context).pop();
    if (identifier == 'filters') {
      await Navigator.of(context).push<Map<Filter, bool>>(
        MaterialPageRoute(builder: (ctx) => FiltersScreen()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final activeFilters = ref.watch(filtersProvider);
    final availableMeals =
        dummyMeals.where((meal) {
          if (activeFilters[Filter.glutenFree]! && !meal.isGlutenFree) {
            return false;
          }
          if (activeFilters[Filter.lactoseFree]! && !meal.isLactoseFree) {
            return false;
          }
          if (activeFilters[Filter.vegetarian]! && !meal.isVegetarian) {
            return false;
          }
          if (activeFilters[Filter.vegan]! && !meal.isVegan) {
            return false;
          }
          return true;
        }).toList();

    Widget activePage = CategoriesScreen(availableMeals: availableMeals);
    var activePageTitle = 'Categories';

    if (selectedPageIndex == 1) {
      final favoriteMeals = ref.watch(favoriteMealsProvider);
      activePage = MealsScreen(meals: favoriteMeals);
      activePageTitle = 'Your Favorites';
    }

    return Scaffold(
      appBar: AppBar(title: Text(activePageTitle)),
      drawer: MainDrawer(onSelectScreen: _setScreen),
      body: activePage,
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: selectedPageIndex,
        onTap: _selectPage,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.set_meal),
            label: 'Categories',
          ),
          BottomNavigationBarItem(icon: Icon(Icons.star), label: 'Favorites'),
        ],
      ),
    );
  }
}
