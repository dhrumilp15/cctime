import 'package:flutter/cupertino.dart';
import 'package:quiqui/assets/images.dart';
import 'dart:core';

List<Dog> jsonHandler(file, key) {
  return file[key].map<Dog>((json) => Dog.fromJson(json)).toList();
}

class Dog {
  final String name;
  final String file;

  Dog({this.name, this.file});

  factory Dog.fromJson(Map<String, dynamic> json) {
    return Dog(
      name: json['name'] as String,
      file: json['filepath'] as String,
    );
  }
}

class Quiz {
  List<Dog> dogs;
  int score = 0;
  int dogIndex = 0;
  List<Dog> seen;
  Dog prev;

  Quiz() {
    this.dogs = jsonHandler(images.json, 'dogs');
    this.seen = new List();
  } // Not sure what to put in the constructor

  void correct() {
  	if (!(dogs.length > 0)) return;
    Dog imp = getDog(dogIndex);
    if (dogs.contains(imp) && !seen.contains(imp)) score++;
    dogs.remove(imp);
    dogIndex++;
  }

  void incorrect() {
    if (!(dogs.length > 0)) return;
    Dog imp = getDog(dogIndex);
    seen.add(imp);
    dogIndex++;
  }

  Dog getDog(int dogindex) {
    if (dogs.length > 0) {
    	this.dogIndex = dogindex % dogs.length;
    } else {
    	return null;
    }
    return dogs[this.dogIndex];
  }

  Iterable<Dog> present() sync* {
  	Dog current = getDog(dogIndex); // should start at 0 - dog: toto

    while (true)
    {
      yield current;

//      dogIndex = (dogIndex + 1) % 20;

      if (dogs.length == 0) {
        break;
      }
    }
  }


}
