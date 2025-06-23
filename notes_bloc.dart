import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notes_by_bloc/db_helper.dart';
import 'package:notes_by_bloc/notes_events.dart';
import 'package:notes_by_bloc/notes_state.dart';

class NotesBloc extends Bloc<AllEvents,NotesState>{
  DBHelper varDb=DBHelper.getInstance();
  NotesBloc():super(NotesState(allData: [])){

    on<InitialFetch>((event,emit)async{
      emit(NotesState(allData:await varDb.fetchNotes()));
    });

    on<AddNote>((event,emit)async{
      varDb.addNote(title: event.title, des: event.des);
      emit(NotesState(allData: await varDb.fetchNotes()));
    });

    on<DeleteNote>((event,emit)async{
      varDb.deleteNote(id: event.id);
      emit(NotesState(allData: await varDb.fetchNotes()));
    });

    on<UpdateNote>((event,emit)async{
      varDb.updateNote(title: event.title, des: event.des, id: event.id);
      emit(NotesState(allData: await varDb.fetchNotes()));
    });
  }
}