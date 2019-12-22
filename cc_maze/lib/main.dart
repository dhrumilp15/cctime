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
	gen(4,4);
  }

  void gen(rows, cols, {String algValue = ''}) {
    maze = Maze(rows, cols);
    iter = maze.generate(algValue).iterator;
	Timer.periodic(Duration(milliseconds: 50), onTick);
  }

  void onTick(Timer timer) {
    if (iter.moveNext())
	{
	  var visited = iter.current;
	  setState(() {});
	  debugPrint('visited: (${visited.row},${visited.col})');
	} else {
      timer.cancel();
      iter = null;
      setState(() {});
	}
  }

  String algValue = 'Binary Tree';
  List<String> _algValue = <String>['Binary Tree']; // Add algorithms here

  int rows = 0;
  List<int> _rows = Iterable<int>.generate(21).toList();

  int cols = 0;
  List<int> _cols = Iterable<int>.generate(21).toList();

  @override
  Widget build(BuildContext context) =>
    Scaffold(
	  backgroundColor: Colors.black12,
	  appBar: AppBar(title: Text('CC Maze')),
	  floatingActionButton: FloatingActionButton(
		onPressed: () {
		  if (rows == 0 && cols == 0)
		  {
		    gen(4,4);
		  }
		  else if (iter == null)
		  {
		    gen(rows, cols, algValue: algValue);
		  }
		  else return null;
		},
		child: Icon(Icons.autorenew),
	  ),
	  drawer: Drawer(
		child: ListView(
	          padding: EdgeInsets.zero,
	          children: <Widget>[
				DrawerHeader(
				  child: Text('Maze Menu',
					style: TextStyle(
						fontWeight: FontWeight.bold,
					  	fontSize: 50.0,
					  	color: Colors.white.withOpacity(0.7),
					)
				  ),
				  decoration: BoxDecoration(
					color: Colors.blue,
				  ),
				),
				Center(
				  child: Text('Algorithm'),
				),
				DropdownButtonHideUnderline(
				  child: ButtonTheme(
					alignedDropdown: true,
					child: DropdownButton<String>(
					  isExpanded: true,
					  hint: new Text('Algorithm'),
					  elevation: 16,
					  value: algValue,
					  onChanged: (String newValue) {
						setState(() {
						  algValue = newValue;
						});
					  },
					  items: _algValue.map((String value) {
						return new DropdownMenuItem<String>(
						  value: value,
						  child: Text(value),
						);
					  }).toList(),
					),
				  )
				),
				Text(''),
				Row(
				  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
				  children: [
					Text('Row'),
					Text('x'),
					Text('Col')
				  ]
				),
				Row(
				  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
				  children: [
				    DropdownButtonHideUnderline(
					  child: ButtonTheme(
						alignedDropdown: true,
						child: DropdownButton<String>(
						  hint: Text('rows'),
						  value: rows.toString(),
						  elevation: 16,
						  onChanged: (String newValue) {
							setState(() {
							  rows = int.parse(newValue);
							});
						  },
						  items: _rows.map((int value) {
							return new DropdownMenuItem<String>(
							  value: value.toString(),
							  child: Text(value.toString()),
							);
						  }).toList(),
						),
					  )
					),
					Text('x'),
					DropdownButtonHideUnderline(
					  child: ButtonTheme(
						alignedDropdown: true,
						child: DropdownButton<String>(
						  hint: Text('row'),
						  value: cols.toString(),
						  elevation: 16,
						  onChanged: (String newValue) {
							setState(() {
							  cols = int.parse(newValue);
							});
						  },
						  items: _cols.map((int value) {
							return new DropdownMenuItem<String>(
							  value: value.toString(),
							  child: Text(value.toString()),
							);
						  }).toList(),
						)
					  )
					),
				  ]
				)
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