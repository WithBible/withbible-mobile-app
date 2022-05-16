import 'package:flutter/material.dart';
import 'package:withbible_app/common/theme_helper.dart';
import 'package:withbible_app/controller/quiz_history.dart';
import 'package:withbible_app/model/leader_board.dart';

class LeaderBoardsScreen extends StatefulWidget {
  const LeaderBoardsScreen({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _LeaderBoardsScreenState();
}

class _LeaderBoardsScreenState extends State<LeaderBoardsScreen> {
  Future<List<LeaderBoard>>? leaderBoardFuture;

  @override
  void initState() {
    super.initState();
    leaderBoardFuture = loadLeaderBoard();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          decoration: BoxDecoration(color: ThemeHelper.shadowColor),
          child: FutureBuilder(
            future: leaderBoardFuture,
            builder: (
              BuildContext context,
              AsyncSnapshot<List<LeaderBoard>> snapshot,
            ) {
              if (snapshot.hasData == false) {
                return const Center(
                  child: CircularProgressIndicator(
                    strokeWidth: 1.6,
                    color: Color(0xfffbce7b),
                  ),
                );
              }

              return ListView.builder(
                  scrollDirection: Axis.vertical,
                  itemCount: snapshot.data!.length,
                  itemBuilder: (context, index) {
                    return Column(
                      children: [
                        snapshot.data![index].photoPath == ""
                            ? const Text("Don't have")
                            : const Text("Have Image"),
                        Image.network(snapshot.data![index].photoPath)
                      ],
                    );
                  });
            },
          ),
        ),
      ),
    );
  }
}
