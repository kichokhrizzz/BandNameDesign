import 'dart:math';

import 'package:band_names/models/band.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({ Key? key }) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  List<Band> bands = [
    Band(id: '1', name: 'Metallica', votes:4),
    Band(id: '2', name: 'Rammstein', votes:7),
    Band(id: '3', name: 'Gorillaz', votes:6),
    Band(id: '4', name: 'Ghost', votes:5),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('BandNames', style: TextStyle(color: Colors.black)),
      ),
      body: ListView.builder(
        itemCount: bands.length,
        itemBuilder: (BuildContext context, int index)=> _bandTile(bands[index]) ,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => addNewBand(),
        child: Icon(Icons.add),
      ),
    );
  }

  Widget _bandTile(Band band) {
    return Dismissible(
      key: Key(band.id!),
      direction: DismissDirection.startToEnd,
      onDismissed: (DismissDirection direction){
        
      },
      background: Container(
        padding: EdgeInsets.only(left: 8.0),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.topRight,
            colors: [
              Colors.red,
              Colors.red.shade100
            ]
          )
        ),
        child: const Align(
          alignment: Alignment.centerLeft,
          child: Icon(Icons.delete_forever, color: Colors.white,)
        ),
      ),
      child: ListTile(
            leading: CircleAvatar(
              child: Text( band.name!.substring(0,2)),
              backgroundColor: Colors.blue[100],
            ),
            title: Text(band.name!),
            trailing: Text('${band.votes}', style: TextStyle(fontSize: 20),),
          ),
    );
  }

  addNewBand( ){

    final textController = new TextEditingController();

    showDialog(
      context: context,
      builder: (context){
        return AlertDialog(
          title: Text('New Band Name:'),
          content: TextField(
            controller: textController,
          ),
          actions: [
            MaterialButton(
              textColor: Colors.blue,
              child: Text('Add'),
              elevation: 5,
              onPressed: (){
                addBandToLits(textController.text);
              },
            )
          ],
        );
      },
    );
  }

  void addBandToLits( String name ) {
    if(name.length > 1)
    {
      this.bands.add(new Band(id:DateTime.now().toString(), name: name, votes: 3));
    
      setState(() {
        
      });

    }

    Navigator.pop(context);
  }

}