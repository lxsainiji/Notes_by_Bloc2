import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:notes_by_bloc/notes_bloc.dart';
import 'package:notes_by_bloc/notes_events.dart';
import 'db_helper.dart';
import 'edit.dart';

class ViewPage extends StatefulWidget{
  int? ind;
  ViewPage({required this.ind});

  @override
  State<ViewPage> createState() => _ViewPageState();
}

class _ViewPageState extends State<ViewPage> {
  DBHelper varDb=DBHelper.getInstance();
  DateFormat df=DateFormat.yMMMd();
  @override
  void initState() {
    super.initState();
    context.read<NotesBloc>().add(InitialFetch());
  }

  @override
  Widget build(BuildContext context) {
    if (context.read<NotesBloc>().state.allData.isEmpty){
      return Scaffold(
        backgroundColor: Color(0xff252525),
        body: Center(child: CircularProgressIndicator()),
      );
    }
    return Scaffold(
        backgroundColor: Color(0xff252525),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
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
                          color: Colors.grey,
                          borderRadius: BorderRadius.circular(7)
                      ),
                      child: Icon(Icons.keyboard_backspace,size: 30,),
                    ),
                  ),
                  Row(
                    children: [
                      InkWell(
                        onTap: (){
                          final noteId = context.read<NotesBloc>().state.allData[widget.ind!][DBHelper.columnNoteId];
                          context.read<NotesBloc>().add(DeleteNote(id: noteId));
                          Navigator.pop(context);
                        },
                        child: Container(
                          padding: EdgeInsets.all(5),
                          decoration: BoxDecoration(
                              color: Colors.grey,
                              borderRadius: BorderRadius.circular(7)
                          ),
                          child: Icon(Icons.delete_forever,size: 30,),
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      InkWell(
                        onTap: (){
                          Navigator.push(context, MaterialPageRoute(builder: (_){
                            final noteId = context.read<NotesBloc>().state.allData[widget.ind!][DBHelper.columnNoteId];
                            return EditPage(id: widget.ind);
                          }));
                        },
                        child: Container(
                          padding: EdgeInsets.all(5),
                          decoration: BoxDecoration(
                              color: Colors.grey,
                              borderRadius: BorderRadius.circular(7)
                          ),
                          child: Icon(Icons.edit_note,size: 30,),
                        ),
                      ),
                    ],
                  )
                ],
              ),
              SizedBox(
                height: 25,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    context.read<NotesBloc>().state.allData.isEmpty ? Text("Loading...."):Text(context.watch<NotesBloc>().state.allData[widget.ind!][DBHelper.columnNoteTitle],maxLines: 2,overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                          fontSize: 33
                      ),),
                    context.read<NotesBloc>().state.allData.isEmpty ? Text("Loading...."):Text(df.format(DateTime.fromMillisecondsSinceEpoch(int.parse(context.watch<NotesBloc>().state.allData[widget.ind!][DBHelper.columnCreatedAt]))),maxLines: 2,
                      style: TextStyle(
                          color: Colors.grey,
                          fontWeight: FontWeight.w300,
                          fontSize: 21
                      ),),
                    context.read<NotesBloc>().state.allData.isEmpty ? Text("Loading...."):Text(context.watch<NotesBloc>().state.allData[widget.ind!][DBHelper.columnNoteDes],
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w400,
                          fontSize: 24
                      ),),
                  ],
                ),
              ),
            ],
          ),
        )
    );
  }
}