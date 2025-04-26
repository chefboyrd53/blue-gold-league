import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Blue-Gold League'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Welcome to the Blue-Gold Fantasy League!',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 40),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/rosters');
              },
              child: const Text('View Rosters'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/matchups');
              },
              child: const Text('View Matchup'),
),
          ],
        ),
      ),
    );
  }
}
