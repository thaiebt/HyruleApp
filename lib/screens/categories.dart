import 'package:flutter/material.dart';
import 'package:hyrule/screens/components/category.dart';
import 'package:hyrule/screens/favorites.dart';
import 'package:hyrule/utils/const/categories.dart';

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Escolha uma categoria"), 
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: (){
              Navigator.push(context, MaterialPageRoute(builder: (context) => FavoritesScreen(),));
            }, 
            icon: const Icon(Icons.bookmark))
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: GridView(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2, 
            crossAxisSpacing: 16,
            mainAxisExtent: 193, 
            mainAxisSpacing: 16),
          children: categories.keys.map((e) => CategoryWidget(category: e)).toList(),
        ),
      ),
    );
  }
}