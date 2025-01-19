import 'package:flutter/material.dart';
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
    final Responsive responsive = Responsive(context);
    return ChangeNotifierProvider<GamelVM>(
      create: (context) => GamelVM(),
      child: Scaffold(
        body: Center(
          child: Board(responsive: responsive),
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
                physics: const NeverScrollableScrollPhysics(),
                padding: const EdgeInsets.only(
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

  bool pressed(GamelVM provider) {
    print("Pressed $id");
    provider.pressCell(id);
    return provider.isWinner();
  }

  Future<void> _showWinnerDialog(BuildContext context, GamelVM provider) async {
    String title = provider.isWinner() ? "${provider.winner} wins!" : "Draw";

    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: const SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                // Text('Noughts ${provider.}'),
                // Text('Would you like to approve of this message?'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Reset game'),
              onPressed: () {
                provider.resetGame();
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<GamelVM>(context);

    return GestureDetector(
      onTap: () {
        bool isWinner = pressed(provider);
        if (isWinner) {
          _showWinnerDialog(context, provider);
        }
      },
      child: Container(
        decoration: BoxDecoration(
            border: Border.all(color: Colors.transparent),
            color: Colors.transparent),
        child: Center(
          child: Text(
            provider.getCellSymbol(id),
            style: const TextStyle(color: Colors.black, fontSize: 35),
          ),
        ),
      ),
    );
  }
}
