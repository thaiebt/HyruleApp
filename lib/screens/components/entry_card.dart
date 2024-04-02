import 'package:flutter/material.dart';
import 'package:hyrule/controllers/dao_controller.dart';
import 'package:hyrule/domain/model/entry.dart';
import 'package:hyrule/screens/details.dart';

class EntryCardWidget extends StatelessWidget {
  EntryCardWidget({
    Key? key,
    required this.entry,
    required this.isSaved,
  }) : super(key: key);

  final Entry entry;
  final bool isSaved;
  final DaoController daoController = DaoController();

  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.hardEdge,
      child: Dismissible(
        key: ValueKey(entry.id),
        direction: isSaved ? DismissDirection.endToStart : DismissDirection.none,
        background: Container(
          color: Colors.red,
          child:const Align(
            alignment: Alignment.centerRight,
            child: Padding(
              padding: EdgeInsets.all(16.0),
              child: Icon(Icons.delete),
            ),
          ),
        ),
        onDismissed: (direction) {
          daoController.deleteEntry(entry: entry);
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Item removido!")));
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(
              height: 180,
              child: InkWell(
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context) => DetailsScreen(entry: entry)));
                },
                child: Ink(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Flexible(
                        fit: FlexFit.tight,
                        flex: 1,
                        child: Container(
                          margin: const EdgeInsets.symmetric(
                          vertical: 16.0,
                          horizontal: 8.0,
                          ),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            image: DecorationImage(
                              image: NetworkImage(entry.image),
                              fit: BoxFit.cover
                            )
                          ),
                        )
                      ),
                      Flexible(
                        flex: 2,
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(bottom: 8.0),
                                child: Text(entry.name.toUpperCase(), style: TextStyle(fontSize: 16),),
                              ),
                              Flexible(
                                child: Text(
                                  entry.description,
                                  overflow: TextOverflow.ellipsis, 
                                  maxLines: 5
                                )
                              )
                          ],),
                        ),
                      )
                  ],),
                ),
              ),
            ),
            Container(
              decoration: const BoxDecoration(
                color: Color.fromRGBO(59, 72, 88, 1),
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Wrap(
                  spacing: 8,
                  children: entry.commonLocationsConverter().map((e) => Chip(
                    label: Text(e),
                    backgroundColor: Color.fromRGBO(59, 72, 88, 1),
                  )).toList(),
                ),
              ),
            )
        ]),
      ),
    );
  }
}
