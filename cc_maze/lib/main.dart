import 'package:flutter/material.dart';
import 'maze.dart';
import 'dart:async';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) =>
    MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var maze;
  Iterator<Cell> iter;

  @override
  void initState() {
    super.initState();
    gen();
  }

  void gen() {
    maze = Maze(4,4);
    iter = maze.binTree().iterator;
	Timer.periodic(Duration(milliseconds: 50), onTick);
  }

  void onTick(Timer timer) {
    if (iter.moveNext())
	{
//	  var visited = iter.current;
	  setState(() {});
//	  debugPrint('visited: (${visited.row},${visited.col})');
	} else {
      timer.cancel();
      iter = null;
      setState(() {});
	}
  }

  @override
  Widget build(BuildContext context) =>
    Scaffold(
	  backgroundColor: Colors.black12,
	  appBar: AppBar(title: Text('CC Maze')),
	  floatingActionButton: FloatingActionButton(
		onPressed: iter == null ? gen : null,
		child: Icon(Icons.directions_run),
	  ),
	  drawer: Drawer(
	        child: ListView(
	          padding: EdgeInsets.zero,
	          children: <Widget>[
	            DrawerHeader(
	              child: Text('Drawer Helper'),
	              decoration: BoxDecoration(
	                color: Colors.blue,
	              ),
	            ),
	            DropdownButton<String>(
//				  title: Text('Algorithm')
	            ),
	            ListTile(
	              title: Text('Algorithm'), // Replace with chosen algorithm
	              onTap: () {
	                print("Item 1 hath been pressed");
	                showDialog(
	                  context: context,
	                  builder: (BuildContext context) {
	                    return AlertDialog(
	                        title: Text("Oh yeah eh"),
	                        content: Text("biggolodius modius"),
	                        actions: <Widget>[
	                          FlatButton(
	                            child: Text("eh"),
	                            onPressed: () {
	                              Navigator.of(context).pop();
	                              Navigator.of(context).pop();
	                            },
	                          )
	                        ]

	                    );
	                  }
	                );
	              },
	            ),
	            ListTile(
	              title: Text('Item 2'),
	              onTap: () {
	                print("Item 2");
	                Navigator.pop(context);
	              },
	            ),
	          ]
	        ),
	      ),
	  body: Center(
		child: AspectRatio(
		  aspectRatio: 1,
			child: Column(
			  children: [
				for (var row = 0; row != maze.rows; ++row)
				  Expanded(
					  child: Row(
						  children: [
							for (var col = 0; col != maze.cols; ++col)
							  Expanded(
								  child: CellView(maze.getCell(row, col))
							  )
						  ]
					  )
				  )
			  ],
			)
		),
	  )
  );
}

class CellView extends StatelessWidget {
  final Cell cell;
  CellView(this.cell);

  @override
  Widget build(BuildContext context) {
    return Container(
	  decoration: BoxDecoration(
		border: Border(
		  top: getside(Walls.up),
		  left: getside(Walls.left),
		  right: getside(Walls.right),
		  bottom: getside(Walls.down),
		),
		color: cell.visited ? Colors.white : Colors.black,
	  ),
	);
  }

  BorderSide getside(Walls wall) =>
	BorderSide(
	  width: 2.0,
	  style: cell.walls[wall.index] ? BorderStyle.solid : BorderStyle.none,
	);
  }
//class MyHomePage extends StatelessWidget {
//  final String title;
//
//  MyHomePage({Key key, this.title}) : super(key: key);
//
//  @override
//  Widget build(BuildContext context) {
//    return Scaffold(
//      appBar: AppBar(title: Text(title)),
//      body: Center(child: Text('My Page!')),
//      drawer: Drawer(
//        child: ListView(
//          padding: EdgeInsets.zero,
//          children: <Widget>[
//            DrawerHeader(
//              child: Text('Drawer Helper'),
//              decoration: BoxDecoration(
//                color: Colors.blue,
//              ),
//            ),
//            DropdownButton<String>(
//
//            ),
//            ListTile(
//              title: Text('Algorithm'), // Replace with chosen algorithm
//              onTap: () {
//                print("Item 1 hath been pressed");
//                showDialog(
//                  context: context,
//                  builder: (BuildContext context) {
//                    return AlertDialog(
//                        title: Text("Oh yeah eh"),
//                        content: Text("biggolodius modius"),
//                        actions: <Widget>[
//                          FlatButton(
//                            child: Text("eh"),
//                            onPressed: () {
//                              Navigator.of(context).pop();
//                              Navigator.of(context).pop();
//                            },
//                          )
//                        ]
//
//                    );
//                  }
//                );
//              },
//            ),
//            ListTile(
//              title: Text('Item 2'),
//              onTap: () {
//                print("Item 2");
//                Navigator.pop(context);
//              },
//            ),
//          ]
//        ),
//      ),
//    );
//  }
//}
/*
class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Column(
          // Column is also a layout widget. It takes a list of children and
          // arranges them vertically. By default, it sizes itself to fit its
          // children horizontally, and tries to be as tall as its parent.
          //
          // Invoke "debug painting" (press "p" in the console, choose the
          // "Toggle Debug Paint" action from the Flutter Inspector in Android
          // Studio, or the "Toggle Debug Paint" command in Visual Studio Code)
          // to see the wireframe for each widget.
          //
          // Column has various properties to control how it sizes itself and
          // how it positions its children. Here we use mainAxisAlignment to
          // center the children vertically; the main axis here is the vertical
          // axis because Columns are vertical (the cross axis would be
          // horizontal).
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.display1,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
*/