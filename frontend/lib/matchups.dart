import 'package:flutter/material.dart';
import 'package:frontend/utils/position_colors.dart';

class MatchupsPage extends StatefulWidget {
  const MatchupsPage({super.key});

  @override
  State<MatchupsPage> createState() => _MatchupsPageState();
}

class _MatchupsPageState extends State<MatchupsPage> {
  int currentWeek = 1;

  // Example data for multiple weeks
  final List<Map<String, dynamic>> weeksData = [
    {
      'week': 1,
      'teamA': {
        'name': 'Paul',
        'players': [
          {'position': 'QB', 'name': 'Patrick Mahomes', 'team': 'KC', 'points': 25.5},
          {'position': 'RB', 'name': 'Christian McCaffrey', 'team': 'SF', 'points': 22.1},
          {'position': 'WR', 'name': 'Tyreek Hill', 'team': 'MIA', 'points': 18.7},
        ],
      },
      'teamB': {
        'name': 'Chris',
        'players': [
          {'position': 'QB', 'name': 'Josh Allen', 'team': 'BUF', 'points': 20.3},
          {'position': 'RB', 'name': 'Derrick Henry', 'team': 'TEN', 'points': 15.6},
          {'position': 'WR', 'name': 'Justin Jefferson', 'team': 'MIN', 'points': 19.2},
        ],
      },
    },
    {
      'week': 2,
      'teamA': {
        'name': 'Paul',
        'players': [
          {'position': 'QB', 'name': 'Joe Burrow', 'team': 'CIN', 'points': 23.1},
          {'position': 'RB', 'name': 'Saquon Barkley', 'team': 'NYG', 'points': 18.4},
          {'position': 'WR', 'name': 'Cooper Kupp', 'team': 'LAR', 'points': 20.2},
        ],
      },
      'teamB': {
        'name': 'Chris',
        'players': [
          {'position': 'QB', 'name': 'Jalen Hurts', 'team': 'PHI', 'points': 24.6},
          {'position': 'RB', 'name': 'Nick Chubb', 'team': 'CLE', 'points': 19.0},
          {'position': 'WR', 'name': 'Stefon Diggs', 'team': 'BUF', 'points': 17.8},
        ],
      },
    },
  ];

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    final currentData = weeksData[currentWeek - 1];
    final teamA = currentData['teamA'];
    final teamB = currentData['teamB'];

    double totalPoints(List players) {
      return players.fold(0, (sum, p) => sum + (p['points'] as double));
    }

    final double teamAScore = totalPoints(teamA['players'] as List<dynamic>);
    final double teamBScore = totalPoints(teamB['players'] as List<dynamic>);

    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            DropdownButton<int>(
              value: currentWeek,
              dropdownColor: Colors.grey[850], // dark background for dropdown
              style: const TextStyle(color: Colors.white, fontSize: 18),
              underline: Container(), // removes underline
              iconEnabledColor: Colors.white,
              items: List.generate(weeksData.length, (index) {
                final week = weeksData[index]['week'] as int;
                return DropdownMenuItem(
                  value: week,
                  child: Text(' Week $week'),
                );
              }),
              onChanged: (value) {
                if (value != null) {
                  setState(() {
                    currentWeek = value;
                  });
                }
              },
            ),
          ],
        ),
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
                  color: getPositionColor(player['position']),
                ),
              ),
              const SizedBox(width: 10),
              Text(
                '${player['name']} ',
                style: const TextStyle(fontSize: 16, color: Colors.white),
              ),
              Text(
                '(${player['team']})',
                style: const TextStyle(fontSize: 14, color: Colors.grey),
              ),
              const SizedBox(width: 15),
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
              const SizedBox(width: 15),
              Text(
                '(${player['team']})',
                style: const TextStyle(fontSize: 14, color: Colors.grey),
              ),
              Text(
                ' ${player['name']}',
                style: const TextStyle(fontSize: 16, color: Colors.white),
              ),
              const SizedBox(width: 10),
              Text(
                player['position'],
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: getPositionColor(player['position']),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
