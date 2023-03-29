import 'package:data_repository/data_repository.dart';
import 'package:data_repository/models/member.dart';
import 'package:fluttartur/game/cubit/game_cubit.dart';
import 'package:flutter/material.dart';
import 'package:fluttartur/pages_old/view/mission_page.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

//TODO make player list as one list(table) with highliting

class GameForm extends StatelessWidget {
  const GameForm({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        _QuestTiles(),
        Expanded(
          child: _TeamWrap(),
        ),
        //_VotingButtons(), // TODO put on stack
      ],
    );
  }
}

class _QuestTiles extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: const Color.fromARGB(172, 63, 63, 63),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: const <Widget>[
            _QuestTile(questNumber: 1),
            _QuestTile(questNumber: 1),
            _QuestTile(questNumber: 1),
            _QuestTile(questNumber: 1),
            _QuestTile(questNumber: 1),
          ],
        ),
      ),
    );
  }
}

class _QuestTile extends StatelessWidget {
  const _QuestTile({required this.questNumber});

  final int questNumber;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<bool?>(
      stream:
          context.read<GameCubit>().streamQuestResult(questNumber: questNumber),
      builder: (context, snapshot) {
        var result = snapshot.data;
        return CircleAvatar(
          radius: 30,
          backgroundColor: result == null
              ? const Color.fromARGB(255, 35, 35, 35)
              : result == false
                  ? Colors.red
                  : Colors.green,
          child: IconButton(
            iconSize: 40,
            color: const Color.fromARGB(255, 255, 226, 181),
            icon: const Icon(Icons.location_on),
            onPressed: () {},
          ),
        );
      },
    );
  }
}

class _TeamWrap extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Center(
        child: Row(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text("Court:", style: TextStyle(fontSize: 30)),
                Expanded(
                  child: SingleChildScrollView(
                    child: _PlayerListView(),
                  ),
                ),
              ],
            ),
            const Spacer(),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                const Text("Squad:", style: TextStyle(fontSize: 30)),
                Expanded(
                  child: SingleChildScrollView(
                    child: _SquadListView(),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _PlayerListView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<Player>>(
      stream: context.read<DataRepository>().streamPlayersList(),
      builder: (context, snapshot) {
        var players = snapshot.data;
        return players == null
            ? const Text("Court is empty")
            : Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  ...players.map(
                    (player) => _PlayerCard(player: player),
                  ),
                ],
              );
      },
    );
  }
}

class _PlayerCard extends StatelessWidget {
  // TODO ! make it a hero widget between two lists
  const _PlayerCard({
    required this.player,
  });

  final Player player;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Add player to squad
      },
      child: Card(
        margin: const EdgeInsets.all(1.0),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              player.isLeader
                  ? const Icon(Icons.star)
                  : const SizedBox.shrink(),
              Text(player.nick, style: const TextStyle(fontSize: 23)),
            ],
          ),
        ),
      ),
    );
  }
}

class _SquadListView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<Member>>(
      stream: context.read<DataRepository>().streamMembersList(questNumber: 1),
      builder: (context, snapshot) {
        var members = snapshot.data;
        return members == null
            ? const Text('Squad is empty')
            : Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: <Widget>[
                  ...members.map(
                    (member) => _MemberCard(member: member),
                  ),
                ],
              );
      },
    );
  }
}

class _MemberCard extends StatelessWidget {
  // TODO ! make it a hero widget between two lists
  const _MemberCard({
    required this.member,
  });

  final Member member;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // remove member from squad
      },
      child: Card(
        margin: const EdgeInsets.all(1.0),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            member.nick,
            style: const TextStyle(fontSize: 23),
          ),
        ),
      ),
    );
  }
}

class _VotingButtons extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: const Color.fromARGB(172, 63, 63, 63),
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            CircleAvatar(
              radius: 40,
              backgroundColor: Colors.red,
              child: IconButton(
                iconSize: 60,
                color: Colors.white,
                icon: const Icon(Icons.close),
                onPressed: () {},
              ),
            ),
            CircleAvatar(
              radius: 40,
              backgroundColor: Colors.green,
              child: IconButton(
                iconSize: 60,
                color: Colors.white,
                icon: const Icon(Icons.check),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const MissionPage()),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
