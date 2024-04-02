import 'package:flutter/material.dart';
import 'package:hyrule/controllers/api_controller.dart';
import 'package:hyrule/screens/components/entry_card.dart';
import 'package:hyrule/screens/favorites.dart';
import 'package:hyrule/utils/const/categories.dart';

class ResultsScreen extends StatelessWidget {
  ResultsScreen({super.key, required this.category});
  final String category;

  final ApiController apiController = ApiController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(categories[category] ?? ''),
         actions: [
          IconButton(
            onPressed: (){
              Navigator.push(context, MaterialPageRoute(builder: (context) => FavoritesScreen()));
            }, 
            icon: const Icon(Icons.bookmark))
        ],
      ),
      body: FutureBuilder(
        future: apiController.getEntriesByCategory(category: category), 
        builder: (context, snapshot) {
          switch(snapshot.connectionState) { 
            case ConnectionState.none:
              break;
            case ConnectionState.waiting:
              return const Center(child: CircularProgressIndicator(),);
            case ConnectionState.active:
              break;
            case ConnectionState.done:
              if (snapshot.hasData) {
                return ListView.builder(
                  itemBuilder: (context, index) => EntryCardWidget(
                    entry: snapshot.data![index], 
                    isSaved: false,
                  ), 
                  itemCount: snapshot.data!.length
                );
              }
          }
          return Container();
        },
      ),
    );
  }
}