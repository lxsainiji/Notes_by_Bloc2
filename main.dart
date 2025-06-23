import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notes_by_bloc/notes_bloc.dart';
import 'home.dart';

void main(){
  runApp(BlocProvider(create: (_)=>NotesBloc(),child: Myapp()));
}

class Myapp extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomePage(),
    );
  }
}