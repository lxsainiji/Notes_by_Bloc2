import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notes_by_bloc/notes_bloc.dart';
import 'package:notes_by_bloc/notes_events.dart';
import 'package:notes_by_bloc/notes_view_bloc.dart';
import 'db_helper.dart';

class EditPage extends StatefulWidget{
  int? id;
  EditPage({required this.id});

  @override
  State<EditPage> createState() => _EditPageState();
}

class _EditPageState extends State<EditPage> {
  var editNoteTitle=TextEditingController();
  var editNoteDes=TextEditingController();
  @override
  void initState() {
    super.initState();
    context.read<NotesBloc>().add(InitialFetch());
  }

  @override
  Widget build(BuildContext context) {
    final state = context.watch<NotesBloc>().state;
    if (state.allData.isNotEmpty) {
      editNoteTitle.text = state.allData[widget.id!][DBHelper.columnNoteTitle] ?? '';
      editNoteDes.text = state.allData[widget.id!][DBHelper.columnNoteDes] ?? '';
    }

    return Scaffold(
        backgroundColor: Color(0xff252525),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18),
          child: Column(
            children: [
              SizedBox(
                height: 45,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  InkWell(
                    onTap: (){
                      Navigator.pop(context);
                    },
                    child: Container(
                      padding: EdgeInsets.all(5),
                      decoration: BoxDecoration(
                          color: Color(0xff3b3b3b),
                          borderRadius: BorderRadius.circular(7)
                      ),
                      child: Icon(Icons.keyboard_backspace,size: 30,color: Colors.white,),
                    ),
                  ),
                  InkWell(
                    onTap: (){
                      var newId=state.allData[widget.id!][DBHelper.columnNoteId];
                      context.read<NotesBloc>().add(UpdateNote(title: editNoteTitle.text, des: editNoteDes.text, id:newId ));
                      Navigator.pop(context);
                    },
                    child: Container(
                      padding: EdgeInsets.all(5),
                      decoration: BoxDecoration(
                          color: Color(0xff3b3b3b),
                          borderRadius: BorderRadius.circular(7)
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: Text("Save",style: TextStyle(
                          fontSize: 20,
                          color: Colors.white,
                          fontWeight: FontWeight.w700
                        ),),
                      ),
                    ),
                  )
                ],
              ),
              SizedBox(
                height: 25,
              ),
              Expanded(
                child: Column(
                  children: [
                    TextField(
                      controller: editNoteTitle,
                      autofocus: true,
                      style: TextStyle(color: Colors.white,fontSize: 32),
                      keyboardType: TextInputType.multiline,
                      decoration: InputDecoration(
                        hintText: 'Title...',
                        hintStyle: TextStyle(color: Colors.white54),
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.symmetric(vertical: 18),
                      ),
                      cursorColor: Colors.white54,
                    ),
                    TextField(
                      controller: editNoteDes,
                      autofocus: false,
                      style: TextStyle(color: Colors.white,fontSize: 22),
                      keyboardType: TextInputType.multiline,
                      maxLines: null,
                      minLines: 1,
                      decoration: InputDecoration(
                        hintText: 'Type something...',
                        hintStyle: TextStyle(color: Colors.white54),
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.symmetric(vertical: 18),
                      ),
                      cursorColor: Colors.white54,
                    ),
                  ],
                ),
              ),
            ],
          ),
        )
    );
  }
}