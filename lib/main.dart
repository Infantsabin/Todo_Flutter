import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Todo',
      theme: ThemeData(
        primaryColor: Colors.pink[300],
      ),
      home: MyHomePage(title: 'Todo List'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
//  int _counter = 0;
  List<String> litems =[];
  final TextEditingController eCtrl = new TextEditingController();
  final Set _saved = Set();
  final TextStyle _biggerFont = TextStyle(fontSize: 18.0);
  Widget _buildRow(pair) {
    final bool alreadySaved = _saved.contains(pair);
    return ListTile(
      title: Text(
        pair,
        style: _biggerFont,
      ),
      trailing: Icon(   // Add the lines from here...
        alreadySaved ? Icons.favorite : Icons.favorite_border,
        color: alreadySaved ? Colors.red : null,
      ),
      onTap: () {
        setState(() {
          alreadySaved ? _saved.remove(pair) : _saved.add(pair);
        });
      },// ... to here.
    );
  }
  void _pushSaved() {
    Navigator.of(context).push(
      MaterialPageRoute<void>(   // Add 20 lines from here...
        builder: (BuildContext context) {
          final Iterable<ListTile> tiles = _saved.map(
                (pair) {
              return ListTile(
                title: Text(
                  pair,
                  style: _biggerFont,
                ),
              );
            },
          );
          final List<Widget> divided = ListTile
              .divideTiles(
            context: context,
            tiles: tiles,
          )
              .toList();
          return Scaffold(         // Add 6 lines from here...
            appBar: AppBar(
              title: Text('Saved'),
            ),
            body: ListView(children: divided),
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
   return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        actions: <Widget>[      // Add 3 lines from here...
          IconButton(icon: Icon(Icons.list), onPressed: _pushSaved),
        ],
      ),

       body: new Column(
         children: <Widget>[
           new TextField(
             controller: eCtrl,
             onSubmitted: (text) {
               litems.add(text);
               eCtrl.clear();
               setState(() {});
             },
           ),
           new Expanded(
               child: new ListView.builder
                 (
                   padding: const EdgeInsets.all(16.0),
                   itemCount: litems.length,
                   itemBuilder: (BuildContext ctxt, int Index) {
                     Divider();
                     return _buildRow(litems[Index]);
                   }
               )
           )
         ],
       ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        tooltip: 'Add',
        child: Icon(Icons.add),
        backgroundColor: Colors.pink[300],
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
