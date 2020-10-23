import 'package:flutter/material.dart';

class BlogPage extends StatefulWidget {
  var x;
  BlogPage({Key key, @required this.x}) : super(key: key);
  _BlogPageState createState() => _BlogPageState();
}

class _BlogPageState extends State<BlogPage> {
  var now = new DateTime.now();
  @override
  Widget build(BuildContext context) {
    double contHeight = MediaQuery.of(context).size.height;
    double contWidth = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Scaffold(
          appBar: AppBar(
            title: Text(widget.x.subject),
          ),
          body: Container(
              child: ListView.builder(
                  itemCount: 2,
                  physics:
                      ScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
                  itemBuilder: (BuildContext context, int index) {
                    return _blogCard(context, contHeight, contWidth,"Titolo","docente","$now","Ciao ragazzi,\n"
                "le consegne per la settimana prossima:\n"
                "studiare la dispensa APLO_seconda_parte tutta.\n"
                " svolgere le esercitazioni in Opencampus (RISU non fare il compito 4)\nCari saluti dc");
                  }))),
    );
  }

  Widget _blogCard(context, double contHeight, double contWidth, String titolo,
      String docente, String data, String contenuto) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: contWidth * .1),
      child: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
                child: Text(
              "$titolo",
              style: TextStyle(fontSize: 20),
            )),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Icon(Icons.person_pin),
                Text("$docente"),
              ],
            ),
            Text("$now"),
            Divider(
              thickness: 2,
              color: Colors.black,
            ),
            Text("$contenuto")
          ],
        ),
      ),
    );
  }
}
