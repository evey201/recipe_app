import 'package:flutter/material.dart';
import 'package:recipe_app/models/recipe.dart';
import 'package:recipe_app/services/data_service.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String _selectedRecipeType = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('RecipBook'),
        centerTitle: true,
      ),
      body: SafeArea(child: _buildHomePageUI()),
    );
  }

  Widget _buildHomePageUI() {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        children: [
          _recipeTypeButtons(),
          _recipeList(),
        ],
      ),
    );
  }

  Widget _recipeTypeButtons() {
    return SizedBox(
      height: MediaQuery.sizeOf(context).height * 0.05,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5.0),
            child: FilledButton(
                onPressed: () {
                  setState(() {
                    _selectedRecipeType = 'snack';
                  });
                },
                child: const Text('🥕 Snack')),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5.0),
            child: FilledButton(
                onPressed: () {
                  setState(() {
                    _selectedRecipeType = 'breakfast';
                  });
                },
                child: const Text('🍳 Breakfast')),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5.0),
            child: FilledButton(
                onPressed: () {
                  setState(() {
                    _selectedRecipeType = 'lunch';
                  });
                },
                child: const Text('🍔 Lunch')),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5.0),
            child: FilledButton(
                onPressed: () {
                  setState(() {
                    _selectedRecipeType = 'dinner';
                  });
                },
                child: const Text(
                  '🍕 Dinner'
                  )
                ),
          ),
        ],
      ),
    );
  }

  Widget _recipeList() {
    return Expanded(
        child: FutureBuilder(
      future: DataService().getRecipes(
          _selectedRecipeType,
      ),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }
        if (snapshot.hasError) {
          return const Center(child: Text('Failed to load recipes'));
        }
        return ListView.builder(
          itemCount: snapshot.data!.length,
          itemBuilder: (context, index) {
            Recipe recipe = snapshot.data![index];
            return ListTile(
              contentPadding: const EdgeInsets.only(top: 20.0),
              isThreeLine: true,
              subtitle: Text(
                "${recipe.cuisine}\nDifficulty: ${recipe.difficulty}",
              ),
              leading: Image.network(recipe.image),
              title: Text(
                recipe.name,
                // style: const TextStyle(fontSize: 20),
              ),
              trailing: Text(
                "${recipe.rating.toString()} ⭐️",
                style: const TextStyle(fontSize: 15),
              ),
            );
          },
        );
      },
    ));
  }
}
