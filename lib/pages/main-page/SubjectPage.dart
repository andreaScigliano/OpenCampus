import 'package:flutter/material.dart';
import 'package:open_campus_mobile/models/SchoolClass.dart';
import 'package:open_campus_mobile/pages/detail-subject-page/BlogPage.dart';
import 'package:open_campus_mobile/pages/detail-subject-page/DocumentPage.dart';
import 'package:open_campus_mobile/pages/detail-subject-page/GradePage.dart';


class SubjectPage extends StatefulWidget {
  SubjectPage({Key key}) : super(key: key);
  @override
  _SubjectPageState createState() => _SubjectPageState();
}

class _SubjectPageState extends State<SubjectPage> {
  List<SchoolClass> materie = List();
  List<SchoolClass> filterSubject = List();
  final List<String> day = new List();

  @override
  void initState() {
    super.initState();
    SchoolClass primo = new SchoolClass(2, "Martedi", "Gianluigi Zanolli",
        "Marketing", "8.20-11.30", "308");
    SchoolClass secondo = new SchoolClass(4, "Giovedi", "Debora Colarusso",
        "Risorse Umane", "14.20-15.30", "307");
    SchoolClass terzo = new SchoolClass(1, "Lunedì", "Debora Colarusso",
        "Risorse Umane", "14.20-15.30", "307");
    SchoolClass quarto = new SchoolClass(
        6, "sabato", "Ivan Zivzo", "Matematica", "10.10-11.45", "307");
    SchoolClass quinta = new SchoolClass(
        3, "Mercoledi", "Ivan Zivzo", "Matematica", "10.10-11.45", "307");
    SchoolClass sesto = new SchoolClass(2, "Martedi", "Robero otupacca",
        "progetto informatico", "8.20-11.30", "309");
    materie.add(primo);
    materie.add(secondo);
    materie.add(terzo);
    materie.add(quarto);
    materie.add(quinta);
    materie.add(sesto);
    filterSubject = materie;
    day.add("tutti");
    day.add("Lunedì");
    day.add("martedì");
    day.add("mercoledì");
    day.add("giovedì");
    day.add("venerdì");
    day.add("sabato");
  }

  void _filter(value) {
    setState(() {
      filterSubject = materie;
      if (value != 0) {
        filterSubject = materie.where((element) => element.dayId == value).toList();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Column(
      children: <Widget>[_days(context), _sobjectList(context)],
    ));
  }

/**
 * componente 
 */
  Widget _days(context) {
    double contHeight = MediaQuery.of(context).size.height;
    double contWidth = MediaQuery.of(context).size.width;
    return Container(
      height: contHeight * .075,
      child: ListView.builder(
        itemCount: day.length,
        physics: ScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
        scrollDirection: Axis.horizontal,
        itemBuilder: (BuildContext context, int index) {
          return Container(
            decoration: BoxDecoration(
                border: Border.all(color: Colors.black), color: Colors.blue),
            width: contWidth * .4,
            child: RawMaterialButton(
              onPressed: () {
                _filter(index);
              },
              child: Center(
                child: Text(
                  "${day[index]}",
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _sobjectList(context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * .63,
      child: ListView.builder(
        addAutomaticKeepAlives: false,
        padding: EdgeInsets.only(top: 25),
        itemCount: filterSubject.length,
        itemBuilder: (BuildContext context, int index) {
          return Padding(
              padding: const EdgeInsets.symmetric(vertical: 16.0),
              child: ListTile(
                onTap: () {
                  _mainBottomSheet(context, index);
                },
                title: _sobject(
                    filterSubject[index].dayId,
                    filterSubject[index].subject,
                    filterSubject[index].teacher,
                    filterSubject[index].time,
                    filterSubject[index].room,
                    filterSubject[index].day,
                    context),
              ));
        },
      ),
    );
  }

  // index provvisorio
  Widget _sobject(int index, String nomeMateria, String docente, String ore,
      String room, String day, context) {
    double contHeight = MediaQuery.of(context).size.height;
    double contWidth = MediaQuery.of(context).size.width;
    return Center(
      child: Container(
        width: contWidth * .85,
        height: contHeight * .16,
        decoration: BoxDecoration(
            //shadow
            boxShadow: [
              BoxShadow(
                color: Colors.grey,
                blurRadius: 15.0,
                spreadRadius: 1.0,
                offset: Offset(
                  30.0,
                  10.0,
                ),
              )
            ],
            color: Colors.white,
            //border: Border.all(color: Colors.black),
            borderRadius: BorderRadius.all(Radius.circular(20))),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              child: Column(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(top: 5.0),
                    child: Text(
                      nomeMateria,
                      style: TextStyle(fontSize: 18),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 7.0),
                    child: Text(
                      "Docente: $docente",
                      style: TextStyle(fontSize: 15),
                    ),
                  ),
                  Divider(
                    color: Colors.black,
                    thickness: 1.3,
                  ),
                  Row(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(left: 40.0),
                        child: Text(
                          "$ore",
                          style: TextStyle(fontSize: 15),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 20.0),
                        child: Text(
                          "aula: $room",
                          style: TextStyle(fontSize: 15),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 20.0),
                        child: Text(
                          "$day",
                          style: TextStyle(fontSize: 15),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  _mainBottomSheet(BuildContext context, int index) {
    String subject = filterSubject[index].subject; 
    return showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return Column(
            children: <Widget>[
              _actionItem(
                  context,
                  "Documeti-$subject",
                  Icons.archive,
                  DocumentPage(
                    x: filterSubject[index],
                  )),
              _actionItem(
                  context,
                  "Blog-$subject",
                  Icons.forum,
                  BlogPage(
                    x: filterSubject[index],
                  )),
              _actionItem(
                  context,
                  "Forum-$subject",
                  Icons.mode_comment,
                  DocumentPage(
                    x: filterSubject[index],
                  )),
              _actionItem(
                  context,
                  "Avvisi-$subject",
                  Icons.announcement,
                  DocumentPage(
                    x: filterSubject[index],
                  )),
                  _actionItem(
                  context,
                  "valutazioni-$subject",
                  Icons.announcement,
                  GradePage(
                    x: filterSubject[index],
                  ))
            ],
          );
        });
  }

  ListTile _actionItem(
      BuildContext context, String name, IconData icon, Widget pushPage) {
    return ListTile(
      leading: Icon(icon),
      title: Text(name),
      onTap: () {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => pushPage));
      },
    );
  }
}
