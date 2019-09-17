import 'package:flutter/material.dart';
import 'package:flutter_firestore_crud/data/firestore_service.dart';
import 'package:flutter_firestore_crud/data/model/note.dart';
import 'package:flutter_firestore_crud/presentation/pages/add_note.dart';
import 'package:flutter_firestore_crud/presentation/pages/note_details.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: Text('Notes'),
      ),
      body: StreamBuilder(
        stream: FirestoreService().getNotes() ,
        builder: (BuildContext context, AsyncSnapshot<List<Note>> snapshot){
          if(snapshot.hasError || !snapshot.hasData)
            return CircularProgressIndicator();
          return ListView.builder(
            itemCount: snapshot.data.length,
            itemBuilder: (BuildContext context, int index) {
              Note note = snapshot.data[index];
              return ListTile(
                title: Text(note.title),
                subtitle: Text(note.description),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    IconButton(
                      color: Colors.blue,
                      icon: Icon(Icons.edit),
                      onPressed: () => Navigator.push(context, MaterialPageRoute(
                        builder: (_) => AddNotePage(note: note),
                      )),
                    ),
                    IconButton(
                      color: Colors.red,
                      icon: Icon(Icons.delete),
                      onPressed: () => _deleteNote(context, note.id),
                    ),
                  ],
                ),
                onTap: ()=>Navigator.push(
                  context, MaterialPageRoute(
                    builder: (_) => NoteDetailsPage(note: note,),
                  ),
                ),
              );
           },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: (){
          Navigator.push(context, MaterialPageRoute(
            builder: (_) => AddNotePage()
          ));
        },
      ),
    );
  }

  void _deleteNote(BuildContext context,String id) async {
    if(await _showConfirmationDialog(context)) {
      try {
        await FirestoreService().deleteNote(id);
      }catch(e) {
        print(e);
      }
    }
  }

  Future<bool> _showConfirmationDialog(BuildContext context) async {
    return showDialog(
      context: context,
      barrierDismissible: true,
      builder: (context) => AlertDialog(
        content: Text("Are you sure you want to delete?"),
        actions: <Widget>[
          FlatButton(
            textColor: Colors.red,
            child: Text("Delete"),
            onPressed: () => Navigator.pop(context,true),
          ),
          FlatButton(
            textColor: Colors.black,
            child: Text("No"),
            onPressed: () => Navigator.pop(context,false),
          ),
        ],
      )
    );
  }
}