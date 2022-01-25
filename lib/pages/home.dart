import 'dart:math';

import 'package:band_names/models/band.dart';
import 'package:band_names/services/socket_service.dart';
import 'package:flutter/material.dart';
import 'package:pie_chart/pie_chart.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({ Key? key }) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  List<Band> bands = [
    //Band(id: '1', name: 'Metallica', votes:4),
    //Band(id: '2', name: 'Rammstein', votes:7),
    //Band(id: '3', name: 'Gorillaz', votes:6),
    //Band(id: '4', name: 'Ghost', votes:5),
  ];

  @override
  void initState() {
  
    final socketService = Provider.of<SocketService>(context, listen: false);

    socketService.socket.on('active-bands', _handleActiveBands);

    super.initState();

  }

  _handleActiveBands( dynamic payload ){

    this.bands = (payload as List)
        .map((band) => Band.fromMap(band))
        .toList();

      setState(() {
        
      });

  }

  @override
  void dispose() {
    
    final socketService = Provider.of<SocketService>(context, listen: false);

    socketService.socket.off('active-bands');
    
    super.dispose();

  }

  @override
  Widget build(BuildContext context) {

    final socketService = Provider.of<SocketService>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('BandNames', style: TextStyle(color: Colors.black)),
        actions: [
          Container(
            margin: EdgeInsets.only(right: 20),
            child: ( socketService.serverStatus == ServerStatus.Online )
            ? Icon(Icons.wifi, color: Colors.blue[300],)
            : Icon(Icons.wifi_off, color: Colors.red,),
          )
        ],
      ),
      body: Column(
        children: [
          (bands.isNotEmpty)
          ? _showGraph()
          : Text('No Hay Bandas', style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold)),

          Expanded(
            child: ListView.builder(
                  itemCount: bands.length,
                  itemBuilder: (BuildContext context, int index)=> _bandTile(bands[index]) ,
                ),
          ),
          
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => addNewBand(),
        child: Icon(Icons.add),
      ),
    );
  }

  Widget _bandTile(Band band) {

    final socketService = Provider.of<SocketService>(context, listen: false);

    return Dismissible(
      key: Key(band.id!),
      direction: DismissDirection.startToEnd,
      onDismissed: (DismissDirection direction){
        //llamar al servidor
        socketService.emit('delete-band', {'id': band.id});
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
              backgroundImage: NetworkImage('${band.img}'),
              //child: Text( band.name!.substring(0,2)),
              backgroundColor: Colors.blue[100],
            ),
            title: Text(band.name!),
            trailing: Text('${band.votes}', style: TextStyle(fontSize: 20),),
            onTap: (){
              print(band.id);
              socketService.emit('vote-band', { 'id': band.id });
            },
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

    final socketService = Provider.of<SocketService>(context, listen: false);

    if(name.length > 1)
    {
      socketService.emit('add-band', {'name': name});
    }

    Navigator.pop(context);
  }

  //Mostrar grafica
  Widget _showGraph(){

    Map<String, double> dataMap = new Map();

  bands.forEach((band) { 
    dataMap.putIfAbsent(band.name!, () => band.votes!.toDouble());
  });

  return Container(
    width: double.infinity,
    height: 200,
    child: PieChart(dataMap: dataMap,),
  );

  }

}
