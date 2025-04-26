import 'package:flutter/material.dart';

class MatchupsPage extends StatelessWidget {
  const MatchupsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    // Example team data
    final teamA = {
      'name': 'Paul',
      'players': [
        {'position': 'QB', 'name': 'Patrick Mahomes', 'team': 'KC', 'points': 25.5},
        {'position': 'RB', 'name': 'Christian McCaffrey', 'team': 'SF', 'points': 22.1},
        {'position': 'WR', 'name': 'Tyreek Hill', 'team': 'MIA', 'points': 18.7},
      ],
    };

    final teamB = {
      'name': 'Chris',
      'players': [
        {'position': 'QB', 'name': 'Josh Allen', 'team': 'BUF', 'points': 20.3},
        {'position': 'RB', 'name': 'Derrick Henry', 'team': 'TEN', 'points': 15.6},
        {'position': 'WR', 'name': 'Justin Jefferson', 'team': 'MIN', 'points': 19.2},
      ],
    };

    double totalPoints(List players) {
      return players.fold(0, (sum, p) => sum + (p['points'] as double));
    }

    final double teamAScore = totalPoints(teamA['players'] as List<dynamic>);
    final double teamBScore = totalPoints(teamB['players'] as List<dynamic>);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Weekly Matchups'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // VS and Team Names
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        teamA['name'] as String,
                        style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                          color: colors.primary,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        teamAScore.toStringAsFixed(1),
                        style: const TextStyle(fontSize: 18),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 30),
                Column(
                  children: [
                    Text(
                      'VS',
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
                const SizedBox(width: 30),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        teamB['name'] as String,
                        style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                          color: colors.secondary,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        teamBScore.toStringAsFixed(1),
                        style: const TextStyle(fontSize: 18),
                      ),
                    ],
                  ),
                ),
              ],
            ),

            const SizedBox(height: 24),

            // Players List
            Expanded(
              child: Row(
                children: [
                  Expanded(child: buildPlayerListLeft(teamA['players'] as List<dynamic>)),
                  const VerticalDivider(
                    color: Colors.grey,
                    thickness: 1,
                  ),
                  Expanded(child: buildPlayerListRight(teamB['players'] as List<dynamic>)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildPlayerListLeft(List<dynamic> players) {
    return ListView.builder(
      itemCount: players.length,
      itemBuilder: (context, index) {
        final player = players[index];
        return ListTile(
          dense: true,
          contentPadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
          title: Row(
            mainAxisAlignment: MainAxisAlignment.end,  
            crossAxisAlignment: CrossAxisAlignment.center,  
            children: [
              Text(
                player['position'],
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: _getPositionColor(player['position']),
                ),
              ),
              SizedBox(width: 10),  
              Text(
                '${player['name']} ',
                style: const TextStyle(fontSize: 16, color: Colors.white),
              ),
              Text(
                '(${player['team']})',
                style: const TextStyle(fontSize: 14, color: Colors.grey),
              ),
              SizedBox(width: 15), 
              Text(
                '${player['points']}',
                style: const TextStyle(fontSize: 16, color: Colors.white),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget buildPlayerListRight(List<dynamic> players) {
    return ListView.builder(
      itemCount: players.length,
      itemBuilder: (context, index) {
        final player = players[index];
        return ListTile(
          dense: true,
          contentPadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
          title: Row(
            mainAxisAlignment: MainAxisAlignment.start,  
            crossAxisAlignment: CrossAxisAlignment.center,  
            children: [
              Text(
                '${player['points']}',
                style: const TextStyle(fontSize: 16, color: Colors.white),
              ),
              SizedBox(width: 15),
              Text(
                '(${player['team']})',
                style: const TextStyle(fontSize: 14, color: Colors.grey),
              ),
              Text(
                ' ${player['name']}',
                style: const TextStyle(fontSize: 16, color: Colors.white),
              ),
              SizedBox(width: 10), 
              Text(
                player['position'],
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: _getPositionColor(player['position']),
                ),
              ),
            ],
          ),
        );
      },
    );
  }


  Color _getPositionColor(String position) {
    switch (position) {
      case 'QB':
        return Colors.redAccent;
      case 'RB':
        return Colors.greenAccent;
      case 'WR':
        return Colors.lightBlueAccent;
      case 'TE':
        return Colors.purpleAccent;
      case 'K':
        return Colors.orangeAccent;
      case 'DEF':
        return Colors.tealAccent;
      default:
        return Colors.grey;
    }
  }
}
