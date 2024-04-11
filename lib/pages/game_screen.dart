import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:tic_tae_toe/utils/responsive.dart';

class GameScreen extends StatefulWidget {
  const GameScreen({Key? key}) : super(key: key);

  @override
  _GameScreenState createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  String _turn = 'X';

  @override
  Widget build(BuildContext context) {
    final Responsive _responsive = Responsive(context);

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Turn',
              style: TextStyle(fontSize: _responsive.hp(3)),
            ),
            Text(_turn, style: TextStyle(fontSize: _responsive.hp(10))),
            SizedBox(height: _responsive.hp(7)),
            Board()

            // Expanded(
            //   // Creating the Board for Tic tac toe
            //   flex: 4,
            //   child: GridView.builder(
            //       itemCount: 9,
            //       gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            //           crossAxisCount: 3),
            //       itemBuilder: (BuildContext context, int index) {
            //         return GestureDetector(
            //           onTap: () {},
            //           child: Container(
            //             decoration: BoxDecoration(
            //                 border: Border.all(color: Colors.black)),
            //             child: Center(
            //               child: Text(
            //                 "x",
            //                 style: TextStyle(color: Colors.white, fontSize: 35),
            //               ),
            //             ),
            //           ),
            //         );
            //       }),
            // ),

            // Container(
            //     height: _responsive.hp(60),
            //     color: Colors.grey,
            //     padding: EdgeInsets.all(_responsive.dp(5)),
            //     child: GridView.count(
            //       primary: false,
            //       crossAxisSpacing: 10,
            //       mainAxisSpacing: 10,
            //       crossAxisCount: 3,
            //       children: <Widget>[
            //         Container(
            //           padding: const EdgeInsets.all(8),
            //           color: Colors.teal[100],
            //           child: const Text("He'd have you all unravel at the"),
            //         ),
            //         Container(
            //           padding: const EdgeInsets.all(8),
            //           color: Colors.teal[200],
            //           child: const Text('Heed not the rabble'),
            //         ),
            //         Container(
            //           padding: const EdgeInsets.all(8),
            //           color: Colors.teal[300],
            //           child: const Text('Sound of screams but the'),
            //         ),
            //         Container(
            //           padding: const EdgeInsets.all(8),
            //           color: Colors.teal[400],
            //           child: const Text('Who scream'),
            //         ),
            //         Container(
            //           padding: const EdgeInsets.all(8),
            //           color: Colors.teal[500],
            //           child: const Text('Revolution is coming...'),
            //         ),
            //         Container(
            //           padding: const EdgeInsets.all(8),
            //           color: Colors.teal[600],
            //           child: const Text('Revolution, they...'),
            //         ),
            //       ],
            //     ))
          ],
        ),
      ),
    );
  }
}

class Board extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final Responsive _responsive = Responsive(context);

    return Container(
      // Main container to hold both background and GridView
      height: _responsive.hp(60),
      padding: EdgeInsets.all(_responsive.dp(5)),
      child: Stack(
        children: <Widget>[
          // Background container (placed first for behind effect)
          Image.asset("images/Board.png",
              fit: BoxFit.fill, width: _responsive.wp(100)),
          GridView.count(
            // GridView with cells on top of background
            primary: false,
            crossAxisSpacing: _responsive.wp(2),
            mainAxisSpacing: _responsive.wp(1.9),
            crossAxisCount: 3,
            physics: NeverScrollableScrollPhysics(),
            padding: EdgeInsets.only(
                top: 0.0, left: 0.0, bottom: 0.0), // Remove top padding
            shrinkWrap: true, // Wrap content vertically
            children: createCells(),
          ),
        ],
      ),
    );
  }

  List<Cell> createCells() {
    List<Cell> cells = [];
    for (int i = 1; i < 10; i++) {
      cells.add(Cell(id: i));
    }
    return cells;
  }
}

class Cell extends StatelessWidget {
  final int id;
  const Cell({super.key, required this.id});

  pressed() {
    print("Pressed $id");
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        pressed();
      },
      child: Container(
        decoration: BoxDecoration(
            border: Border.all(color: Colors.transparent),
            color: Colors.transparent),
        child: Center(
          child: Text(
            "x",
            style: TextStyle(color: Colors.black, fontSize: 35),
          ),
        ),
      ),
    );
  }
}
