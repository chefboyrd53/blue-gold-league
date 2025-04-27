import 'package:flutter/material.dart';
import 'package:frontend/utils/position_colors.dart';

class RostersPage extends StatelessWidget {
  const RostersPage({super.key});

  // Simulated data
  final List<Map<String, dynamic>> blueDivision = const [
    {
      'name': 'Team Alpha',
      'players': [
        {'position': 'QB', 'name': 'Patrick Mahomes', 'nflTeam': 'KC'},
        {'position': 'WR', 'name': 'Justin Jefferson', 'nflTeam': 'MIN'},
        {'position': 'TE', 'name': 'Travis Kelce', 'nflTeam': 'KC'},
      ]
    },
    {
      'name': 'Team Bravo',
      'players': [
        {'position': 'QB', 'name': 'Jalen Hurts', 'nflTeam': 'PHI'},
        {'position': 'WR', 'name': 'Tyreek Hill', 'nflTeam': 'MIA'},
        {'position': 'RB', 'name': 'Derrick Henry', 'nflTeam': 'TEN'},
      ]
    },
  ];

  final List<Map<String, dynamic>> goldDivision = const [
    {
      'name': 'Team Charlie',
      'players': [
        {'position': 'QB', 'name': 'Josh Allen', 'nflTeam': 'BUF'},
        {'position': 'WR', 'name': 'Stefon Diggs', 'nflTeam': 'BUF'},
        {'position': 'RB', 'name': 'Saquon Barkley', 'nflTeam': 'NYG'},
      ]
    },
    {
      'name': 'Team Delta',
      'players': [
        {'position': 'QB', 'name': 'Lamar Jackson', 'nflTeam': 'BAL'},
        {'position': 'WR', 'name': 'CeeDee Lamb', 'nflTeam': 'DAL'},
        {'position': 'RB', 'name': 'Christian McCaffrey', 'nflTeam': 'SF'},
      ]
    },
  ];

  Widget buildDivision(List<Map<String, dynamic>> teams) {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: teams.length,
      itemBuilder: (context, index) {
        final team = teams[index];
        return Card(
          margin: const EdgeInsets.all(8),
          child: ExpansionTile(
            title: Text(
              team['name'],
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
            children: (team['players'] as List<Map<String, String>>)
                .map((player) => ListTile(
                      title: Row(
                        children: [
                          Text(
                            player['position']!,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: getPositionColor(player['position']!),
                            ),
                          ),
                          const SizedBox(width: 8),
                          Text(
                            player['name']!,
                            style: const TextStyle(fontSize: 16),
                          ),
                          const SizedBox(width: 8),
                          Text(
                            '(${player['nflTeam']!})',
                            style: const TextStyle(
                              fontSize: 14,
                              color: Colors.grey,
                            ),
                          ),
                        ],
                      ),
                    ))
                .toList(),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Rosters'),
      ),
      body: SingleChildScrollView(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // blue division
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Text(
                      'Blue Division',
                      style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: colors.primary),
                    ),
                    buildDivision(blueDivision),
                  ],
                ),
              ),
            ),
            // gold division
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Text(
                      'Gold Division',
                      style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: colors.secondary),
                    ),
                    buildDivision(goldDivision),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
