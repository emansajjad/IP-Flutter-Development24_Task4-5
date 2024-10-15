import 'package:flutter/material.dart';
import 'add_recipe_page.dart';
import 'recipe_card.dart';
import 'recipe.dart';
import 'recipe_detail_page.dart';

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<Recipe> recipes = [
    Recipe(
      name: 'Pasta Primavera',
      ingredients: [
        'Pasta',
        'Bell Peppers',
        'Onion',
        'Garlic',
        'Olive Oil',
        'Parmesan Cheese'
      ],
      steps: [
        'Cook pasta according to package instructions.',
        'Sauté vegetables in olive oil.',
        'Combine pasta and vegetables.',
        'Serve with parmesan cheese.'
      ],
      imageUrl: 'assets/images/prim.jpg',
    ),
    Recipe(
      name: 'Chicken Curry',
      ingredients: [
        'Chicken',
        'Curry Powder',
        'Coconut Milk',
        'Onion',
        'Garlic',
        'Ginger'
      ],
      steps: [
        'Sauté onion, garlic, and ginger.',
        'Add chicken and curry powder.',
        'Pour in coconut milk and simmer.',
        'Serve with rice.'
      ],
      imageUrl: 'assets/images/cc.jpg',
    ),
    Recipe(
      name: 'Chocolate Cake',
      ingredients: [
        'Flour',
        'Cocoa Powder',
        'Sugar',
        'Eggs',
        'Butter',
        'Baking Powder'
      ],
      steps: [
        'Mix dry ingredients.',
        'Add eggs and melted butter.',
        'Bake at 350°F for 30 minutes.',
        'Cool and serve.'
      ],
      imageUrl: 'assets/images/cake.webp',
    ),
    Recipe(
      name: 'Caesar Salad',
      ingredients: [
        'Romaine Lettuce',
        'Parmesan Cheese',
        'Croutons',
        'Caesar Dressing'
      ],
      steps: [
        'Chop lettuce.',
        'Add croutons and parmesan.',
        'Toss with dressing.'
      ],
      imageUrl: 'assets/images/csalad.jpg',
    ),
    Recipe(
      name: 'Beef Tacos',
      ingredients: [
        'Ground Beef',
        'Taco Seasoning',
        'Tortillas',
        'Cheese',
        'Lettuce',
        'Tomato'
      ],
      steps: [
        'Cook beef with seasoning.',
        'Assemble in tortillas with toppings.',
        'Serve with salsa.'
      ],
      imageUrl: 'assets/images/taco.jpg',
    ),
  ];

  List<Recipe> filteredRecipes = []; // List for filtered recipes
  String searchQuery = ''; // Search query

  @override
  void initState() {
    super.initState();
    filteredRecipes = recipes; // Initialize filtered list with all recipes
  }

  void _addRecipe(Recipe recipe) {
    setState(() {
      recipes.add(recipe);
      filteredRecipes = recipes; // Update filtered recipes list
    });
  }

  void _filterRecipes(String query) {
    setState(() {
      searchQuery = query.toLowerCase();
      filteredRecipes = recipes.where((recipe) {
        return recipe.name.toLowerCase().contains(searchQuery);
      }).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Recipes',
          style: TextStyle(fontSize: 21, color: Colors.white),
        ),
        centerTitle: true,
        backgroundColor: Colors.black,
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(50.0),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              onChanged: _filterRecipes,
              decoration: InputDecoration(
                hintText: 'Search recipes...',
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide.none,
                ),
                prefixIcon: const Icon(Icons.search),
              ),
            ),
          ),
        ),
      ),
      body: filteredRecipes.isEmpty
          ? const Center(child: Text('No Recipes Available'))
          : ListView.builder(
              padding: const EdgeInsets.all(10),
              itemCount: filteredRecipes.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            RecipeDetailPage(recipe: filteredRecipes[index]),
                      ),
                    );
                  },
                  child: RecipeCard(recipe: filteredRecipes[index]),
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final newRecipe = await Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AddRecipePage()),
          );
          if (newRecipe != null) {
            _addRecipe(newRecipe);
          }
        },
        child: const Icon(Icons.add, color: Colors.white),
        backgroundColor: Colors.black,
      ),
    );
  }
}
