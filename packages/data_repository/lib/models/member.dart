// ignore_for_file: unnecessary_null_comparison

import 'package:data_repository/models/models.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class Member extends Equatable {
  const Member({
    required this.id,
    required this.playerId,
    required this.nick,
    this.secretVote,
  });

  final String id;
  final String playerId;
  final String nick;
  final bool? secretVote;

  /// Empty member which represents that user is currently not in any member.
  static const empty = Member(id: '', playerId: '', nick: '');

  /// Convenience getter to determine whether the current member is empty.
  bool get isEmpty => this == Member.empty;

  /// Convenience getter to determine whether the current member is not empty.
  bool get isNotEmpty => this != Member.empty;

  @override
  List<Object?> get props => [id, playerId, nick, secretVote];

  factory Member.fromFirestore(DocumentSnapshot<Map<String, dynamic>> doc) {
    final data = doc.data();
    return Member(
      id: doc.id,
      playerId: data?["player_id"],
      nick: data?['nick'],
      secretVote: data?['secret_vote'],
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      "player_uid": playerId,
      "nick": nick,
      if (secretVote != null) "secret_vote": secretVote,
    };
  }
}
