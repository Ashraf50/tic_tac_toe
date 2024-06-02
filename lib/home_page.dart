import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<String> players = ['X', 'O'];
  final List<String> boardContent = ['', '', '', '', '', '', '', '', ''];
  String currentPlayer = 'X';
  int filledBox = 0;

  Widget showContent(List<String> content, int index) {
    final contents = content
        .map(
          (e) => InkWell(
            onTap: () {
              changeContent(index, currentPlayer);
            },
            child: Ink(
              child: Container(
                decoration: BoxDecoration(border: Border.all(width: 2)),
                child: Center(
                  child: Text(
                    e,
                    style: const TextStyle(
                      fontSize: 64,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
          ),
        )
        .toList();
    return contents[index];
  }

  changeContent(int index, String playerId) {
    if (boardContent[index] != '') {
      return;
    }
    if (currentPlayer == players[0]) {
      currentPlayer = players[1];
    } else {
      currentPlayer = players[0];
    }
    setState(() {
      boardContent[index] = playerId;
      filledBox = filledBox + 1;
    });
    checkWinner();
  }

  checkWinner() {
    if (boardContent[0] == boardContent[1] &&
        boardContent[0] == boardContent[2] &&
        boardContent[0] != '') {
      showWinner();
    } else if (boardContent[3] == boardContent[4] &&
        boardContent[3] == boardContent[5] &&
        boardContent[3] != '') {
      showWinner();
    } else if (boardContent[6] == boardContent[7] &&
        boardContent[6] == boardContent[8] &&
        boardContent[6] != '') {
      showWinner();
    } else if (boardContent[0] == boardContent[3] &&
        boardContent[0] == boardContent[6] &&
        boardContent[0] != '') {
      showWinner();
    } else if (boardContent[1] == boardContent[4] &&
        boardContent[1] == boardContent[7] &&
        boardContent[1] != '') {
      showWinner();
    } else if (boardContent[2] == boardContent[5] &&
        boardContent[2] == boardContent[8] &&
        boardContent[2] != '') {
      showWinner();
    } else if (boardContent[0] == boardContent[4] &&
        boardContent[0] == boardContent[8] &&
        boardContent[0] != '') {
      showWinner();
    } else if (boardContent[2] == boardContent[4] &&
        boardContent[2] == boardContent[6] &&
        boardContent[2] != '') {
      showWinner();
    } else if (filledBox == 9) {
      showWinner(draw: true);
    }
  }

  showWinner({bool draw = false}) {
    if (currentPlayer == players[0]) {
      currentPlayer = players[1];
    } else {
      currentPlayer = players[0];
    }
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Center(
            child: draw ? const Text('Its Draw') : Text("$currentPlayer wins")),
        content: ElevatedButton(
          onPressed: () {
            for (int i = 0; i < boardContent.length; i++) {
              boardContent[i] = '';
            }
            Navigator.pop(context);
            setState(() {
              filledBox = 0;
            });
          },
          child: const Text("play Again"),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Tick Tack Toe'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Center(
                child: Text(
                  '$currentPlayer-Turn',
                  style: const TextStyle(fontSize: 30),
                ),
              ),
              const SizedBox(
                height: 40,
              ),
              GridView.builder(
                shrinkWrap: true,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                ),
                itemBuilder: (context, index) {
                  return showContent(boardContent, index);
                },
                itemCount: 9,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
