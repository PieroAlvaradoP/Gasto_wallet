import 'package:cloud_firestore/cloud_firestore.dart';

import 'graph_widget.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class MonthWidget extends StatefulWidget {
  final List<QueryDocumentSnapshot> documents;
  final double total;
  final List<double> perDay;
  final Map<String, double> categories;
  MonthWidget ({Key? key, required this.documents}) :
        total = documents.map((doc) => doc['value']).fold(0.0, (a, b) => a + b),
        perDay = List.generate(30, (int index) {
          return documents
              .where((element) => element['day'] == (index + 1))
              .map((doc) => doc['value'])
              .fold(0.0, (a, b) => a+b);
        }),
        categories = documents.fold({}, (Map<String, double> map, documen) {
          if(!map.containsKey(documen['category'])){
            map[documen['category']] = 0.0;
          }
          map[documen['category']] = map[documen['category']]! + documen['value'];
          return map;
        }),
        super(key: key);

  @override
  State <MonthWidget> createState() => _State();
}

class _State extends State<MonthWidget> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: Column(
          children: <Widget>[
            _expenses(),
            _graph(),
            Container(
              color: Colors.blueAccent.withOpacity(0.15),
              height: 20,
            ),
            _list(),
          ],

      )
    );
  }

  Widget _expenses() {
    return Column(
      children: <Widget>[
        Text(
          "S/ ${widget.total.toStringAsFixed(2)}",
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 40.0,
          ),
        ),
        const Text(
          'Presupuesto del mes',
          style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16.0,
              color: Colors.blueGrey),
        )
      ],
    );
  }

  Widget _graph() {
    return SizedBox(
        height: 250.0,
        child: LinesGraphWidget(data: widget.perDay),
    );
  }


  Widget _itemList(IconData icon, String nombre, int percent, double value) {
    return ListTile(
      leading: Icon(
        icon,
        size: 32.0,
      ),
      title: Text(
        nombre,
        style: const TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 20.0,
        ),
      ),
      subtitle: Text(
        '$percent % del total',
        style: const TextStyle(
          fontSize: 16.0,
          color: Colors.blueGrey,
        ),
      ),
      trailing: Container(
          decoration: BoxDecoration(
            color: Colors.blueAccent.withOpacity(0.2),
            borderRadius: BorderRadius.circular(5.0),
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              'S/.$value',
              style: const TextStyle(
                color: Colors.blueAccent,
                fontWeight: FontWeight.w500,
                fontSize: 16,
              ),
            ),
          )),
    );
  }

  Widget _list() {
    return Expanded(
        child: ListView.separated(
          itemCount: widget.categories.keys.length,
          itemBuilder: (BuildContext context, int index) {
            var key = widget.categories.keys.elementAt(index);
            var data = widget.categories[key];
            return _itemList(FontAwesomeIcons.cartShopping, key, 100 * data !~/widget.total, data);
          },
          separatorBuilder: (BuildContext context, int index) {
            return Container(
              color: Colors.blueAccent.withOpacity(0.15),
              height: 8,
            );
          },
        )
    );
  }
}
