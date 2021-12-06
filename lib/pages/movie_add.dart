

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import 'package:moviesapp_zu/providers/movies_provider.dart';
import 'package:provider/provider.dart';

class MovieAdd extends StatefulWidget {
  const MovieAdd({Key? key}) : super(key: key);

  @override
  State<MovieAdd> createState() => _MovieAddState();
}

class _MovieAddState extends State<MovieAdd> {
  String? imageFile;
  String newMovieTitle = "";
  String newMovieDescription = "";

  TextEditingController movieNameController = TextEditingController();

  TextEditingController movieDescrptionController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  AutovalidateMode autoValidate = AutovalidateMode.disabled;

  final FocusNode _movieNameFocus = FocusNode();

  final FocusNode _movieDescriptionFocus = FocusNode();

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue[900],
        title: const Text("Add Your Fav Movie Details"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 30, left: 10, right: 10),
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      TextFormField(
                        controller: movieNameController,
                        focusNode: _movieNameFocus,
                        onChanged: (newtext) {
                          newMovieTitle = newtext;
                        },
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter movie name';
                          }
                          return null;
                        },
                        decoration: const InputDecoration(
                          labelText: 'Movie Name',
                          border: OutlineInputBorder(),
                        ),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      TextFormField(
                        controller: movieDescrptionController,
                        focusNode: _movieDescriptionFocus,
                        onChanged: (newtext) {
                          newMovieDescription = newtext;
                        },
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter movie Director Name';
                          }
                          return null;
                        },
                        decoration: const InputDecoration(
                          labelText: 'Movie Director Name',
                          border: OutlineInputBorder(),
                        ),
                      ),

                      const SizedBox(height: 15),
                      // imageFile!=null ? Image.network(imageFile!):Container(),
                      Container(
                        margin: const EdgeInsets.all(15.0),
                        padding: const EdgeInsets.all(3.0),
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.black)),
                        height: 110,
                        width: 500,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  elevation: 0,
                                  primary: Colors.white,
                                  fixedSize: const Size(140, 20)),
                              onPressed: () {
                                
                                Provider.of<MoviesData>(context,listen: false).pickImage();
                              },
                              child: const Center(
                                child: Text(
                                  "Upload Poster ",
                                  style: TextStyle(color: Colors.black),
                                ),
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
      
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blue[900],
        onPressed: () {
           
      
    
          if (_formKey.currentState!.validate() ) {
            Provider.of<MoviesData>(context, listen: false)
                .addMovieInfo(newMovieTitle, newMovieDescription);
            Navigator.pop(context);
          ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('New Movie added'),
          )
      );
          }


        },
        child: const Icon(Icons.save),
      ),
    );
  }
}
