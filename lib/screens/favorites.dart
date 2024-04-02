import 'package:flutter/material.dart';
import 'package:hyrule/controllers/dao_controller.dart';
import 'package:hyrule/screens/components/entry_card.dart';

class FavoritesScreen extends StatelessWidget {
  FavoritesScreen({super.key});

  final DaoController daoController = DaoController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Itens salvos"),
      ),
      body: FutureBuilder(
        future: daoController.getSavedEntries(), 
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
                    isSaved: true,
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