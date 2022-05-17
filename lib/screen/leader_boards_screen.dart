import 'package:flutter/material.dart';
import 'package:withbible_app/common/theme_helper.dart';
import 'package:withbible_app/controller/quiz_history.dart';
import 'package:withbible_app/model/leader_board.dart';
import 'package:flutter_svg/flutter_svg.dart';

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
      appBar: AppBar(
        elevation: 0,
        title: const Text('리더보드'),
      ),
      body: SafeArea(
        child: Container(
          decoration: BoxDecoration(color: ThemeHelper.shadowColor),
          padding: const EdgeInsets.all(16),
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
                    return index == 0
                        ? Container(
                            padding: const EdgeInsets.all(10),
                            decoration: const BoxDecoration(
                                color: Color(0xff8d5ac4),
                                borderRadius: BorderRadius.only(
                                    bottomLeft: Radius.circular(4),
                                    bottomRight: Radius.circular(4))),
                            child: buildTopLeaderBoardItem(snapshot.data))
                        : buildLeaderBoardItem(index, snapshot.data);
                  });
            },
          ),
        ),
      ),
    );
  }

  Widget buildTopLeaderBoardItem(List<LeaderBoard>? data) {
    const int index = 0;

    return Align(
      alignment: Alignment.center,
      child: Column(
        children: [
          Stack(
            children: [
              Center(
                child: buildLeaderBoardSizeBadge(data![index].photoPath),
              ),
              const Center(
                  child: Padding(
                padding: EdgeInsets.all(5),
                child: Text(
                  '1',
                  style: TextStyle(color: Colors.white, fontSize: 16),
                  textAlign: TextAlign.center,
                ),
              ))
            ],
          ),
          Row(
            children: [
              Text(
                data[index].username,
                style: const TextStyle(color: Colors.white, fontSize: 24),
              ),
              const Spacer(),
              Text(
                '✨ ${data[index].score} ✨',
                style: const TextStyle(color: Colors.white, fontSize: 24),
              ),
            ],
          )
        ],
      ),
    );
  }

  Widget buildLeaderBoardItem(int index, List<LeaderBoard>? data) {
    return Row(
      children: [
        Text(
          '${index + 1}',
          style: const TextStyle(color: Colors.black, fontSize: 16),
        ),
        data![index].username == ""
            ? const ClipRRect() // TODO: Need no image
            : buildLeaderBoardSizeBadge(data[index].photoPath),
        Text(
          data[index].username,
          style: const TextStyle(color: Colors.black, fontSize: 14),
        ),
        const Spacer(),
        Text(
          data[index].score,
          style: const TextStyle(color: Colors.black, fontSize: 14),
        ),
      ],
    );
  }

  Widget buildLeaderBoardSizeBadge(String photoPath) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(100),
      child: SvgPicture.network(
        photoPath,
        fit: BoxFit.cover,
        width: 70,
        height: 70,
      ),
    );
  }
}
