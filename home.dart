import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:notes_by_bloc/notes_bloc.dart';
import 'package:notes_by_bloc/notes_events.dart';
import 'package:notes_by_bloc/notes_state.dart';
import 'package:notes_by_bloc/view.dart';
import 'add.dart';
import 'db_helper.dart';

class HomePage extends StatefulWidget{
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>{
  DateFormat df=DateFormat.yMMMd();

  @override
  void initState() {
    super.initState();
    context.read<NotesBloc>().add(InitialFetch());
  }

  @override
  Widget build(BuildContext context){
    return Scaffold(
      backgroundColor: Color(0xff131212FF),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 18),
        child: Column(
          children: [
            SizedBox(
              height: 40,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Notes",style: TextStyle(
                  color: Colors.white,
                  fontSize: 32
                ),),
                Row(
                  children:[
                    InkWell(
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (_){
                          return AddPage();
                        }));
                      },
                      child: Container(
                        padding: EdgeInsets.all(5),
                        decoration: BoxDecoration(
                            color: Color(0xff3b3b3b),
                            borderRadius: BorderRadius.circular(7)
                        ),
                        child: Icon(Icons.add,size: 30,color: Colors.white,),
                      ),
                    ),
                    SizedBox(
                      width: 13,
                    ),
                    Container(
                      padding: EdgeInsets.all(5),
                      decoration: BoxDecoration(
                          color: Color(0xff3b3b3b),
                          borderRadius: BorderRadius.circular(7)
                      ),
                      child: Icon(Icons.search,size: 30,color: Colors.white,),
                    ),
                  ]
                )
              ],
            ),
            Expanded(
              child: BlocBuilder<NotesBloc, NotesState>(
                builder: (context, state) {
                  if (state.allData.isEmpty){
                    return Center(
                      child: Text(
                        "No Data Yet!!",
                        style: TextStyle(fontSize: 28, color: Colors.white),
                      ),
                    );
                  } else {
                    return GridView.builder(
                      gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                        maxCrossAxisExtent: 200,
                        crossAxisSpacing: 10,
                        mainAxisSpacing: 10,
                      ),
                      itemCount: state.allData.length,
                      itemBuilder: (_, index) {
                        return InkWell(
                          onTap: () {
                            Navigator.push(context,
                                MaterialPageRoute(builder: (_) => ViewPage(ind: index)));
                          },
                          child: Container(
                            padding: EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              color: Colors.cyanAccent,
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      state.allData[index][DBHelper.columnNoteTitle],
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                          fontSize: 21,
                                          fontWeight: FontWeight.w700,
                                          color: Colors.red.shade400),
                                    ),
                                    Text(
                                      state.allData[index][DBHelper.columnNoteDes],
                                      maxLines: 4,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                          fontSize: 17, fontWeight: FontWeight.w700),
                                    ),
                                  ],
                                ),
                                Center(
                                  child: Text(
                                    df.format(DateTime.fromMillisecondsSinceEpoch(
                                        int.parse(state.allData[index]
                                        [DBHelper.columnCreatedAt]))),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                        color: Colors.grey,
                                        fontSize: 17,
                                        fontWeight: FontWeight.w900),
                                  ),
                                )
                              ],
                            ),
                          ),
                        );
                      },
                    );
                  }
                },
              ),
            ),
          ],
        ),
      )
    );
  }
}