abstract class Human {
  String get name;

  void myNameIs() => print('Привет, я $name!');

  @override
  String toString() => name;
}

class Player extends Human implements Role {
  @override
  final String name;

  @override
  RoleType role;

  int _countMatches = 0;

  Player({required this.name, required this.role});

  @override
  void changeRole(RoleType newRole) => role = newRole;

  void playMatch() {
    print('$name сыграл матч\n');
    _countMatches++;
  }

  @override
  String toString() => '''${super.toString()} — игрок
${getRoleGamer(role)}
Сыграно матчей: $_countMatches
===  ===  ===  \n''';
}

String getRoleGamer(RoleType role) {
  return switch (role) {
    RoleType.goalkeeper => 'Играет на воротах',
    RoleType.leftDefenseMan => 'Играет слева в защите',
    RoleType.rightDefenseMan => 'Играет справа в защите',
    RoleType.leftWinger => 'Играет слева в нападении',
    RoleType.centerWinger => 'Играет по центру в нападении',
    RoleType.rightWinger => 'Играет справа в нападении',
  };
}

class Coach extends Human {
  @override
  final String name;

  int trophies = 0;

  Coach({required this.name});

  Coach.hasTrophies({required this.name, required this.trophies});

  void addTrophies(int value) {
    print('$name получил $value трофеев за турнир\n');
    trophies += value;
  }

  @override
  String toString() =>
      '${super.toString()} — тренер \nПолучил трофеев: $trophies\n===  ===  ===  \n';
}

enum RoleType { goalkeeper, leftDefenseMan, rightDefenseMan, leftWinger, rightWinger, centerWinger }

abstract interface class Role {
  RoleType role;
  Role({required this.role});

  void changeRole(RoleType newRole);
}

class Team {
  final String name;
  final Coach coach;
  final List<Player> players;

  Team({required this.name, required this.coach,  required this.players});

  void addPlayer(Player gamer) => players.add(gamer);
  void deletePlayer(Player gamer) => players.remove(gamer);

  @override
  String toString() {
    return '''Команда "$name"
Тренер: $coach
Игроки: $players''';
  }
}

void main() {
  final pG = Player(name: 'Хабиб', role: RoleType.goalkeeper);
  final pLd = Player(name: 'Опопко', role: RoleType.leftDefenseMan);
  final pRd = Player(name: 'Евсеев', role: RoleType.rightDefenseMan);
  final pLw = Player(name: 'Керж', role: RoleType.leftWinger);
  final pCw = Player(name: 'Дзюба', role: RoleType.centerWinger);
  final pRw = Player(name: 'Овечка', role: RoleType.rightWinger);
  pG.playMatch();
  pLd.playMatch();
  pRd.playMatch();
  pLw.playMatch();
  pCw.playMatch();
  pRw.playMatch();

  pCw.changeRole(RoleType.rightWinger);
  pRw.changeRole(RoleType.centerWinger);

  final coach = Coach(name: 'Дмитрий Анатольевич');

  final team = Team(name: 'ЦКРФ', coach: coach, players: [pG, pLd, pRd]);
  team.addPlayer(pLw);
  team.addPlayer(pCw);
  team.addPlayer(pRw);
  print(team);

  pG.playMatch();
  pLd.playMatch();
  pRd.playMatch();
  pLw.playMatch();
  pCw.playMatch();
  pRw.playMatch();

  coach.addTrophies(1);

  final coachMain = Coach.hasTrophies(name: 'Олег Валерьевич', trophies: 20);
  print(coachMain);

  print(team);
}