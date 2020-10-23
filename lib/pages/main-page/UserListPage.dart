import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:open_campus_mobile/models/User.dart';
import 'package:http/http.dart' as http;

/**
 * Author : Andrea scigliano
 * version : 7/4/2020
 * pagina lista degli utenti
 */
class UserListPage extends StatefulWidget {
  UserListPage({Key key}) : super(key: key);
  @override
  _UserListPageState createState() => _UserListPageState();
}

class _UserListPageState extends State<UserListPage> {
  List<User> _users = List<User>();
  List<User> _filterUsers = List<User>();
  List<String> _typeUsers = List();
  @override
  void initState() {
    super.initState();
    _typeUsers.add("tutti");
    _typeUsers.add("Student");
    _typeUsers.add("Teacher");

    _fetchUsers().then((value) {
      _users.addAll(value);
    });
    _filterUsers = _users;
  }

  Future<List<User>> _fetchUsers() async {
    var response = await http.get("https://opencampustest.edu.ti.ch/api/user");
    var users = List<User>();
    if (response.statusCode == 200) {
      Map<String, dynamic> usersJson = json.decode(response.body);

      for (var userJson in usersJson['data']) {
        User user = User(userJson['firstname'], userJson['lastname'],
            userJson['email'], userJson['code']);
        users.add(user);
      }
      /* test 2
      for (var u in users){
        print("${u.firstName} ${u.lastName} ${u.email}");
      }
      */
      /*test
      print(usersJson['data']);
      User x = User.fromJson(usersJson['data'][0]);
      print("${x.firstName} ${x.lastName} ${x.email}");
      */
    }else{

    }
    return users;
  }

/**
 * value è il valore con cui l altributo della role della classe user viene confrontato.
 */
  void _filter(value) {
    setState(() {
      _filterUsers = _users;
      if (value != "tutti") {
        _filterUsers = _users.where((element) => element.role == value).toList();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    double contHeight = MediaQuery.of(context).size.height;
    double contWidth = MediaQuery.of(context).size.width;
    return Column(
      children: <Widget>[
        _typeUsersMethod(context),
        _userList(context, contHeight, contWidth)
      ],
    );
  }
/**
 * componente per la selezione del tipo di utente
 */
  Widget _typeUsersMethod(context) {
    double contHeight = MediaQuery.of(context).size.height;
    double contWidth = MediaQuery.of(context).size.width;
    return Container(
      height: contHeight * .075,
      child: ListView.builder(
        itemCount: _typeUsers.length,
        physics: ScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
        scrollDirection: Axis.horizontal,
        itemBuilder: (BuildContext context, int index) {
          return Container(
            decoration: BoxDecoration(
                border: Border.all(color: Colors.black), color: Colors.blue),
            width: contWidth * .4,
            child: RawMaterialButton(
              onPressed: () {
                _filter(_typeUsers[index]);
              },
              child: Center(
                child: Text(
                  "${_typeUsers[index]}",
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _userList(context, double contHeight, double contWidth) {
    return SizedBox(
      height: contHeight * .63,
      child: ListView.builder(
        addAutomaticKeepAlives: false,
        padding: EdgeInsets.only(top: 25),
        itemCount: _filterUsers.length,
        itemBuilder: (BuildContext context, int index) {
          return Padding(
              padding: const EdgeInsets.symmetric(vertical: 16.0),
              child: ListTile(
                  title: _userCard(
                      context,
                      _filterUsers[index].firstName,
                      _filterUsers[index].lastName,
                      _filterUsers[index].email,
                      "",
                      contHeight,
                      contWidth)));
        },
      ),
    );
  }

  Widget _userCard(context, String nome, String cognome, String email,
      String immagine, double contHeight,double contWidth) {
    return Row(
      children: <Widget>[
        Text(
          "$nome  $cognome",
          style: TextStyle(fontSize: 13),
        ),
        Padding(padding: EdgeInsets.only(left: contWidth * .01)),
        Text(
          "$email",
          style: TextStyle(fontSize: 13),
        ),
        // troppo spazio per l immagine
        /*
        Padding(padding: EdgeInsets.only(left: contWidth * .04)),
        SizedBox(
          height: contHeight * .06,
          child: Image.network(immagine),
        )
        */
      ],
    );
  }
}
