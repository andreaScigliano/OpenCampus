import 'package:flutter/material.dart';
import 'package:open_campus_mobile/pages/main-page/ProfilePage.dart';
import 'package:open_campus_mobile/widget/Header.dart';
import 'main-page/SubjectPage.dart';
import 'main-page/UserListPage.dart';

/**
 * Author : Andrea scigliano
 * version : 7/4/2020
 * pagina principale
 */
class HomePage extends StatefulWidget {
  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  final Key keyOne = PageStorageKey('SubjectPage');
  final Key keyTwo = PageStorageKey('ProfilePage');
  final Key keyThree = PageStorageKey('UserListPage');
  int currentTab = 0;

  SubjectPage subjectPage;
  ProfilePage profilePage;
  UserListPage userListPage;
  List<Widget> pages;
  Widget currentPage;
  final PageStorageBucket bucket = PageStorageBucket();

  @override
  //inizializzazione delle pagine
  void initState() {
    subjectPage = SubjectPage(
      key: keyOne,
    );
    profilePage = ProfilePage(
      key: keyTwo,
    );
    userListPage = UserListPage(
      key: keyThree,
    );
    pages = [
      subjectPage,
      profilePage,
      userListPage,
      
    ];

    currentPage = subjectPage;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
          child: Scaffold(
        body: Column(
          children: <Widget>[
            Header(),
            PageStorage(
              // currentPage  sono le pagine che verranno scelte dal menu
              child: currentPage,
              bucket: bucket,
            ),
          ],
        ),
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: currentTab,
          onTap: (int index) {
            setState(() {
              if(index == 1 ){
                print(index);
              }
              currentTab = index;
              currentPage = pages[index];
            });
          },
          items: <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              title: Text('Home'),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.settings),
              title: Text("opzioni"),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.group),
              title: Text("Lista Utenti"),
            ),
          ],
        ),
      ),
    );
  }
}




