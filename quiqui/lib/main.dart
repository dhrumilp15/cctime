import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'quiz.dart';
import 'dart:async';
import 'package:quiqui/assets/images.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
	return MaterialApp(
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
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var quiz;
//  String name = 'bingbong';
  Iterator<Dog> iter;

  @override
	void initState() {
  	super.initState();
  	initQuiz();
	}

	void initQuiz() {
  	quiz = Quiz();
  	iter = quiz.present().iterator;
  	Timer.periodic(Duration(milliseconds: 20), onTick);
	}

	void onTick(Timer timer) {
  	if (quiz.dogs.length > 0) {
  		setState(() {});
		} else {
  		timer.cancel();
  		iter = null;
  		setState(() {});
		}
	}

	@override
  Widget build(BuildContext context) {
    if (!(quiz.dogs.length > 0)) {
	    return Scaffold(
			    appBar: AppBar(
					    title: Text('Dogs: Qui, Qui (Who is Who)')
			    ),
			    body: Center(
					    child: Text("Nice! You got a score of ${quiz.score.toString()} out of ${images.json['dogs'].length.toString()}!")
			    )
	    );
    } else {
	    return Scaffold(
			    appBar: AppBar(
				    title: Text('Dogs: Qui, Qui (Who is Who)'),
			    ),
			    body: Column(
					    children: <Widget>[
						    ImageView(quiz.getDog(quiz.dogIndex).file),
						    Divider(),
						    Column(
								    crossAxisAlignment: CrossAxisAlignment.center,
								    children: [YesNo(quiz)]
						    )
					    ]
			    )
	    );
    }


  }
}

class ImageView extends StatelessWidget {
  final String file;
  final double dimension = 305.0;
  ImageView(this.file);

  @override
  Widget build(BuildContext context) {
    return Container(
	    padding: EdgeInsets.only(top : 50.0, bottom: 50.0),
        child: Row(
		        mainAxisAlignment: MainAxisAlignment.center,
		        children: <Widget>[
		        	Container(
				          width:dimension,
					        height: dimension,
					        decoration: BoxDecoration(
				            borderRadius: BorderRadius.circular(8.0),
				            border: Border.all(
					            color: Colors.blue,
					            width: 5.0
				            ),
							        image: DecorationImage(
								        image: ExactAssetImage(file),
								        fit: BoxFit.fill,
					        )
                ),
              )
      ]
    )
    );
  }
}

class YesNo extends StatelessWidget {
  final Quiz quiz;

  YesNo(this.quiz);

	@override
  Widget build(BuildContext context) {
		return Container(
	    child: Row(
//		    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
		    children: <Widget>[
		    	ButtonTheme(
				    minWidth: MediaQuery.of(context).size.width / 2,
				    height: 200,
				    child: RaisedButton(
					    onPressed: () {
						    quiz.correct(); // Update score and dogList
					    },
					    color: Colors.lightGreen,
					    child: Icon(Icons.check),
				    ),
			    ),
			    ButtonTheme(
				    minWidth: MediaQuery.of(context).size.width / 2,
				    height: 200,
				    child: RaisedButton(
					    onPressed: () {
					    	quiz.incorrect();
					    }, //Just move on to next picture
					    color: Colors.redAccent,
					    child: Icon(Icons.close),
				    ),
			    )
		    ]
	    )
    );
  }
}


