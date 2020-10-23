import 'package:flutter/material.dart';
import 'package:open_campus_mobile/pages/detail-Profile-page/Agenda.dart';
import 'package:open_campus_mobile/pages/detail-Profile-page/Paramiter.dart';
import 'package:open_campus_mobile/pages/detail-Profile-page/PersonalDoc.dart';

class ProfilePage extends StatefulWidget {
  ProfilePage({Key key}) : super(key: key);
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final Key keyOne = PageStorageKey('Agenda');
  final Key keyTwo = PageStorageKey('Paramiter');
  final Key keyThree = PageStorageKey('PersonalDoc');
  int currentTab = 0;

  Agenda agenda;
  Paramiter paramiter;
  PersonalDoc personalDoc;
  List<Widget> pages;
  Widget currentPage;
  final PageStorageBucket bucket = PageStorageBucket();

  @override
  //inizializzazione delle pagine
  void initState() {
    agenda = Agenda(
      key: keyOne,
    );
    paramiter = Paramiter(
      key: keyTwo,
    );
    personalDoc = PersonalDoc(
      key: keyThree,
    );
    pages = [
      agenda,
      paramiter,
      personalDoc
      
    ];

    currentPage = agenda;

    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      child:PageStorage(
        bucket:bucket,
      child: currentPage,
      )
    );
  }
  
}