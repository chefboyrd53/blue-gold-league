import 'package:flutter/material.dart';
import 'package:frontend/utils/position_colors.dart';

class LineupsPage extends StatefulWidget {
  const LineupsPage({super.key});

  @override
  State<LineupsPage> createState() => LineupsPageState();
}

class LineupsPageState extends State<LineupsPage> {
  int currentWeek = 1;

  // Example roster
  final List<Map<String, dynamic>> players = [
    {'position': 'QB', 'name': 'Patrick Mahomes', 'team': 'KC'},
    {'position': 'RB', 'name': 'Christian McCaffrey', 'team': 'SF'},
    {'position': 'WR', 'name': 'Tyreek Hill', 'team': 'MIA'},
    {'position': 'RB', 'name': 'Saquon Barkley', 'team': 'NYG'},
    {'position': 'WR', 'name': 'Justin Jefferson', 'team': 'MIN'},
    {'position': 'TE', 'name': 'Travis Kelce', 'team': 'KC'},
    {'position': 'K', 'name': 'Justin Tucker', 'team': 'BAL'},
    {'position': 'DST', 'name': '49ers Defense', 'team': 'SF'},
    {'position': 'WR', 'name': 'Stefon Diggs', 'team': 'BUF'},
    {'position': 'RB', 'name': 'Austin Ekeler', 'team': 'LAC'},
  ];

  // Define starting spots
  final List<Map<String, dynamic>> lineupSpots = [
    {'label': 'QB', 'allowedPositions': ['QB']},
    {'label': 'RB1', 'allowedPositions': ['RB']},
    {'label': 'RB2', 'allowedPositions': ['RB']},
    {'label': 'WR1', 'allowedPositions': ['WR']},
    {'label': 'WR2', 'allowedPositions': ['WR']},
    {'label': 'WR3', 'allowedPositions': ['WR']},
    {'label': 'TE', 'allowedPositions': ['TE']},
    {'label': 'FLEX', 'allowedPositions': ['RB', 'WR', 'TE']},
    {'label': 'K', 'allowedPositions': ['K']},
    {'label': 'DST', 'allowedPositions': ['DST']},
  ];

  // Store lineup selections per week
  final Map<int, Map<String, String?>> weeklyLineups = {}; // {Week: {Spot: Player Name}}

  @override
  void initState() {
    super.initState();
    initializeLineup(currentWeek);
  }

  void initializeLineup(int week) {
    if (!weeklyLineups.containsKey(week)) {
      weeklyLineups[week] = {
        for (var spot in lineupSpots) spot['label'] as String: null,
      };
    }
  }

  List<Map<String, dynamic>> filterPlayers(List<String> allowedPositions, String currentSpot) {
    // Get all players who match the allowed positions
    final candidates = players.where((p) => allowedPositions.contains(p['position'])).toList();

    // Get all selected player names except for the current spot
    final selectedPlayers = weeklyLineups[currentWeek]!.entries
        .where((entry) => entry.key != currentSpot && entry.value != null)
        .map((entry) => entry.value)
        .toSet();

    // Remove players already selected in other spots
    return candidates.where((player) => !selectedPlayers.contains(player['name'])).toList();
  }


  void selectPlayer(String spot, String? playerName) {
    setState(() {
      weeklyLineups[currentWeek]![spot] = playerName;
    });
  }

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    initializeLineup(currentWeek);

    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            const Text('Set Lineup - '),
            DropdownButton<int>(
              value: currentWeek,
              dropdownColor: Colors.grey[850],
              style: const TextStyle(color: Colors.white, fontSize: 18),
              underline: Container(),
              iconEnabledColor: Colors.white,
              items: List.generate(18, (index) {
                final week = index + 1;
                return DropdownMenuItem(
                  value: week,
                  child: Text(' Week $week'),
                );
              }),
              onChanged: (value) {
                if (value != null) {
                  setState(() {
                    currentWeek = value;
                    initializeLineup(currentWeek);
                  });
                }
              },
            ),
          ],
        ),
      ),
      body: ListView.builder(
        itemCount: lineupSpots.length,
        itemBuilder: (context, index) {
          final spot = lineupSpots[index];
          final label = spot['label'] as String;
          final allowedPositions = spot['allowedPositions'] as List<String>;
          final availablePlayers = filterPlayers(allowedPositions, label);
          final selectedPlayerName = weeklyLineups[currentWeek]![label];

          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: DropdownButtonFormField<String>(
              dropdownColor: Colors.grey[850],
              decoration: InputDecoration(
                labelText: label,
                labelStyle: const TextStyle(color: Colors.white),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(color: colors.primary),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(color: colors.primary),
                ),
              ),
              value: selectedPlayerName,
              items: [
                const DropdownMenuItem(
                  value: null,
                  child: Text(
                    'Select Player',
                    style: TextStyle(color: Colors.grey),
                  ),
                ),
                ...availablePlayers.map((player) {
                  return DropdownMenuItem(
                    value: player['name'] as String,
                    child: Row(
                      children: [
                        Text(
                          player['position'],
                          style: TextStyle(
                            color: getPositionColor(player['position']),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(width: 8),
                        Text(
                          player['name'],
                          style: const TextStyle(color: Colors.white),
                        ),
                        const SizedBox(width: 8),
                        Text(
                          '(${player['team']})',
                          style: const TextStyle(color: Colors.grey, fontSize: 12),
                        ),
                      ],
                    ),
                  );
                }).toList(),
              ],
              onChanged: (value) => selectPlayer(label, value),
            ),
          );
        },
      ),
    );
  }
}
