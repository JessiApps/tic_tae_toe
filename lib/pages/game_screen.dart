import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:tic_tae_toe/utils/responsive.dart';
import 'package:tic_tae_toe/view_model/game_vm.dart';

class GameScreen extends StatefulWidget {
  const GameScreen({Key? key}) : super(key: key);

  @override
  _GameScreenState createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  @override
  Widget build(BuildContext context) {
    final Responsive _responsive = Responsive(context);
    return ChangeNotifierProvider<GamelVM>(
      create: (context) => GamelVM(),
      child: Scaffold(
        body: Center(
          child: Board(responsive: _responsive),
        ),
      ),
    );
  }
}

class Board extends StatelessWidget {
  final Responsive responsive;
  const Board({super.key, required this.responsive});

  @override
  Widget build(BuildContext context) {
    final Responsive responsive = Responsive(context);
    final provider = Provider.of<GamelVM>(context);
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text(
          'Turn',
          style: TextStyle(fontSize: responsive.hp(3)),
        ),
        Text(provider.actualPlayer,
            style: TextStyle(fontSize: responsive.hp(10))),
        SizedBox(height: responsive.hp(7)),
        Container(
          // Main container to hold both background and GridView
          height: responsive.hp(60),
          padding: EdgeInsets.all(responsive.dp(5)),
          child: Stack(
            children: <Widget>[
              // Background container (placed first for behind effect)
              Image.asset("images/Board.png",
                  fit: BoxFit.fill, width: responsive.wp(100)),
              GridView.count(
                // GridView with cells on top of background
                primary: false,
                crossAxisSpacing: responsive.wp(2),
                mainAxisSpacing: responsive.wp(1.9),
                crossAxisCount: 3,
                physics: NeverScrollableScrollPhysics(),
                padding: EdgeInsets.only(
                    top: 0.0, left: 0.0, bottom: 0.0), // Remove top padding
                shrinkWrap: true, // Wrap content vertically
                children: createCells(),
              ),
            ],
          ),
        )
      ],
    );
  }

  List<Cell> createCells() {
    List<Cell> cells = [];
    for (int i = 0; i < 9; i++) {
      cells.add(Cell(id: i));
    }
    return cells;
  }
}

class Cell extends StatelessWidget {
  final int id;
  const Cell({super.key, required this.id});

  pressed(GamelVM provider) {
    print("Pressed $id");
    provider.pressCell(id);
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<GamelVM>(context);
    return GestureDetector(
      onTap: () {
        pressed(provider);
      },
      child: Container(
        decoration: BoxDecoration(
            border: Border.all(color: Colors.transparent),
            color: Colors.transparent),
        child: Center(
          child: Text(
            provider.getCellSymbol(id),
            style: TextStyle(color: Colors.black, fontSize: 35),
          ),
        ),
      ),
    );
  }
}
