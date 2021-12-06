// ignore_for_file: avoid_print

import 'dart:collection';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';


import '../models/movie_list.dart';

class MoviesData extends ChangeNotifier {
  File? image;

  final List<MovieLists> movieList = [];

  UnmodifiableListView<MovieLists> get tasks {
    return UnmodifiableListView(movieList);
  }

  int get moviesCount {
    return movieList.length;
  }

  void addMovieInfo(String newMovieTitle, String newMovieDescription) {
    final mDATA = MovieLists(
        movieTitle: newMovieTitle,
        movieDirector: newMovieDescription,
        image: image);
        image = null;
    movieList.add(mDATA);

    notifyListeners();
  }

  Future pickImage() async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.gallery);
      if (image == null) return;

      final imageTemporary = File(image.path);
      this.image = imageTemporary;
    } on PlatformException catch (e) {
      print('Failed to pick image : $e');
    }
  }

  void deleteMovie(MovieLists movieitem) {
    movieList.remove(movieitem);
    
    notifyListeners();
  }
}
