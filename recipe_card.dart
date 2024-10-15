import 'package:flutter/material.dart';
import 'recipe.dart';

class RecipeCard extends StatelessWidget {
  final Recipe recipe;

  RecipeCard({required this.recipe});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
      elevation: 5,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.vertical(top: Radius.circular(15)),
            child: Container(
              height: 200, // Fixed height for the image
              decoration: BoxDecoration(
                borderRadius:
                    const BorderRadius.vertical(top: Radius.circular(15)),
                image: DecorationImage(
                  image: AssetImage(recipe.imageUrl),
                  fit: BoxFit.cover, // Ensures the image covers the container
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  recipe.name,
                  style: const TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Colors.black, // Changed to black
                  ),
                ),
                const SizedBox(height: 8), // Increased spacing
                Text(
                  '${recipe.ingredients.length} Ingredients',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.grey[
                        700], // Slightly darker grey for better readability
                  ),
                ),
                const SizedBox(height: 4), // Space below ingredients
              ],
            ),
          ),
        ],
      ),
    );
  }
}
