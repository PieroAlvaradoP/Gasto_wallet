import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:gasto_wallet/login_state.dart';
import 'package:gasto_wallet/month_widget.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gasto_wallet/pages/add_page.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int currentPage = DateTime.now().month-1;
  late PageController _controller;
  late Stream<QuerySnapshot> _query;

  @override
  void initState() {
    super.initState();
    _controller = PageController(
      initialPage: currentPage,
      viewportFraction: 0.4,
    );
  }

  Widget _bottomAction(IconData icon, Function callback) {
    return InkWell(
      onTap: () => callback(),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Icon(icon),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<LoginState>(
      builder: (BuildContext context, LoginState state, Widget? child) {
        var user = Provider.of<LoginState>(context).currentUser();
        _query = FirebaseFirestore.instance
            .collection('users')
            .doc(user?.uid)
            .collection('expenses')
            .where("month", isEqualTo: currentPage + 1)
            .snapshots();

        return Scaffold(
          bottomNavigationBar: BottomAppBar(
            notchMargin: 8.0,
            shape: const CircularNotchedRectangle(),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                _bottomAction(FontAwesomeIcons.clockRotateLeft, () {}),
                _bottomAction(FontAwesomeIcons.chartPie, () {}),
                const SizedBox(width: 48.0),
                _bottomAction(FontAwesomeIcons.wallet, () {}),
                _bottomAction(Icons.exit_to_app, () {
                  Provider.of<LoginState>(context, listen: false).logout();
                }),
              ],
            ),
          ),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerDocked,
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (BuildContext context) {
                    return AddPage();
                  },
                ),
              );
            },
            child: const Icon(Icons.add),
          ),
          body: _body(),
        );
      },
    );
  }

  Widget _body() {
    return SafeArea(
      child: Column(
        children: <Widget>[
          _selector(),
          StreamBuilder<QuerySnapshot>(
              stream: _query,
              builder:
                  (BuildContext contex, AsyncSnapshot<QuerySnapshot> data) {
                if (data.hasData) {
                  return MonthWidget(documents: data.data!.docs);
                } else {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
              }),
        ],
      ),
    );
  }

  Widget _pageItem(String name, int position) {
    Alignment alignment;
    const selected = TextStyle(
      fontSize: 20.0,
      fontWeight: FontWeight.bold,
      color: Colors.blueGrey,
    );
    final unselected = TextStyle(
      fontSize: 20.0,
      fontWeight: FontWeight.normal,
      color: Colors.blueGrey.withOpacity(0.4),
    );

    if (position == currentPage) {
      alignment = Alignment.center;
    } else if (position > currentPage) {
      alignment = Alignment.centerRight;
    } else {
      alignment = Alignment.centerLeft;
    }

    return Align(
      alignment: alignment,
      child: Text(
        name,
        style: position == currentPage ? selected : unselected,
      ),
    );
  }

  Widget _selector() {
    return SizedBox.fromSize(
      size: const Size.fromHeight(70.0),
      child: PageView(
        onPageChanged: (newPage) {
          setState(() {
            var user =
                Provider.of<LoginState>(context, listen: false).currentUser();
            currentPage = newPage;
            _query = FirebaseFirestore.instance
                .collection('users')
                .doc(user?.uid)
                .collection('expenses')
                .where('month', isEqualTo: currentPage + 1)
                .snapshots();
          });
        },
        controller: _controller,
        children: <Widget>[
          _pageItem("Enero", 0),
          _pageItem("Febrero", 1),
          _pageItem("Marzo", 2),
          _pageItem("Abril", 3),
          _pageItem("Mayo", 4),
          _pageItem("Junio", 5),
          _pageItem("Julio", 6),
          _pageItem("Agosto", 7),
          _pageItem("Septiembre", 8),
          _pageItem("Octubre", 9),
          _pageItem("Noviembre", 10),
          _pageItem("Diciembre", 11),
        ],
      ),
    );
  }
}
