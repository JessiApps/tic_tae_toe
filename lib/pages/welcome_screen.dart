import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tic_tae_toe/utils/responsive.dart';
import 'package:tic_tae_toe/view_model/game_vm.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  @override
  Widget build(BuildContext context) {
    final Responsive responsive = Responsive(context);
    final provider = Provider.of<GameVM>(context);
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(responsive.dp(5)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(height: responsive.hp(1)),
            Text("The Tic Tac Toe Game",
                style: TextStyle(
                  fontSize: responsive.hp(6),
                  fontWeight: FontWeight.bold,
                  color: const Color.fromARGB(255, 18, 44, 66),
                )),
            SizedBox(height: responsive.hp(3)),
            Text("Select your level",
                style: TextStyle(fontSize: responsive.hp(4))),
            SizedBox(height: responsive.hp(1)),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                levelButton(3, provider, responsive),
                levelButton(4, provider, responsive),
                levelButton(5, provider, responsive),
              ],
            ),
            SizedBox(height: responsive.hp(4)),
          ],
        ),
      ),
    );
  }

  Widget levelButton(int level, GameVM provider, Responsive responsive) {
    return ElevatedButton(
      onPressed: () {
        provider.setGameDifficulty(level);
      },
      child: Text(
        "${level}x${level}",
        style: TextStyle(fontSize: responsive.hp(2)),
      ),
    );
  }
}
