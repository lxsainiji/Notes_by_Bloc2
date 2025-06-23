abstract class AllEvents {}

class InitialFetch extends AllEvents{}

class AddNote extends AllEvents{
  String title;
  String des;

  AddNote({required this.title,required this.des});
}

class DeleteNote extends AllEvents{
  int id;
  DeleteNote({required this.id});
}

class InitialEditView extends AllEvents{
  int id;
  InitialEditView({required this.id});
}

class UpdateNote extends AllEvents{
  String title;
  String des;
  int  id;
  UpdateNote({required this.title,required this.des,required this.id});
}