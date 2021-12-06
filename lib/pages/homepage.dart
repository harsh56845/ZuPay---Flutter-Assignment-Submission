
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:moviesapp_zu/pages/login.dart';
import 'package:moviesapp_zu/providers/auth_view_model.dart';
import 'package:moviesapp_zu/providers/movies_provider.dart';
import 'package:moviesapp_zu/pages/movie_add.dart';


import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final firebaseUser = context.watch<User?>();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue[900],
        title: const Text("My favorites  Movies List"),
        automaticallyImplyLeading: false,
        centerTitle: true,
        actions: [
          firebaseUser != null
              ? IconButton(
                  onPressed: () {
                    Provider.of<AuthViewModel>(context, listen: false)
                        .signOutUser(context);
                  },
                  icon: const Icon(Icons.logout))
              : Center(
                  child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: GestureDetector(
                      onTap: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) => Login()));
                      },
                      child: const Text(
                        "Login",
                        style: TextStyle(fontSize: 20),
                      )),
                ))
        ],
      ),
      body: Provider.of<MoviesData>(context).movieList.isNotEmpty
          ? GridView.builder(
              padding: const EdgeInsets.all(20),
              itemCount: Provider.of<MoviesData>(context).movieList.length,
              gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                maxCrossAxisExtent: 200,
                crossAxisSpacing: 20.0,
                mainAxisSpacing: 20.0,
              ),
              itemBuilder: (context, index) => GestureDetector(
                onLongPress: () {},
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.blue[100],
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Provider.of<MoviesData>(context).movieList[index].image !=
                              null
                          ? Image.file(
                              Provider.of<MoviesData>(context)
                                  .movieList[index]
                                  .image!,
                              fit: BoxFit.cover,
                              height: 100,
                              width: 140,
                            )
                          : const Text("NO Image"),
                       
                      Row(mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Column(
                            children: [  
                              Text(
                                Provider.of<MoviesData>(context)
                                    .movieList[index]
                                    .movieTitle
                                    .toString(),
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 20),
                              ),
                              Text(
                                "Director: " +
                                    Provider.of<MoviesData>(context)
                                        .movieList[index]
                                        .movieDirector
                                        .toString(),
                                style: const TextStyle(fontSize: 15),
                              )
                            ],
                          ),
                        
                           IconButton(onPressed: (){
                             
                             Provider.of<MoviesData>(context, listen: false).deleteMovie(Provider.of<MoviesData>(context,listen: false)
                                        .movieList[index]);  
                                         ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
              content: Text(' Movie deleted'),
            ));
                       
                           }, icon: Icon(Icons.delete,color: Colors.red[700],))
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            )
          : const Center(
              child: Text("NO Fav Movies Yet ,Please Add Your fav Movies"),
            ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blue[900],
        onPressed: () {
          if (firebaseUser != null) {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => const MovieAdd()));
          }
          if (firebaseUser == null) {
            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
              content: Text('You need to Login to add new Movie added'),
            ));
          }
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}

//  void deleteMovie(BuildContext context) {
//   Provider.of<MoviesData>(context, listen: false).deleteMovie();
//   ScaffoldMessenger.of(context).showSnackBar(SnackBar(
//               content: Text('Movie list item Deleted'),
//             ));

//   }
