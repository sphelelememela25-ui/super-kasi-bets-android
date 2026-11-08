import 'package:flutter/material.dart';

void main() {
  runApp(const SuperKasiBetsApp());
}

class SuperKasiBetsApp extends StatelessWidget {
  const SuperKasiBetsApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Super Kasi Bets',
      theme: ThemeData(
        brightness: Brightness.dark,
        scaffoldBackgroundColor: const Color(0xFF071B13),
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFFFFD700),
          brightness: Brightness.dark,
        ),
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF103D28),
        title: const Text(
          'SUPER KASI BETS',
          style: TextStyle(
            color: Color(0xFFFFD700),
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          const Card(
            color: Color(0xFF145333),
            child: Padding(
              padding: EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('DEMO WALLET',
                      style: TextStyle(color: Colors.white70)),
                  SizedBox(height: 8),
                  Text(
                    'R150.00',
                    style: TextStyle(
                      color: Color(0xFFFFD700),
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 5),
                  Text('Virtual credits only — no cash value'),
                ],
              ),
            ),
          ),
          const SizedBox(height: 20),
          const Text(
            'Football matches',
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 10),
          matchCard('Arsenal', 'Chelsea', '2.10', '3.20', '2.80'),
          matchCard('Real Madrid', 'Barcelona', '2.00', '3.40', '2.90'),
          const SizedBox(height: 20),
          const Card(
            color: Color(0xFF103D28),
            child: ListTile(
              leading: Icon(Icons.casino, color: Color(0xFFFFD700)),
              title: Text('Free-play games'),
              subtitle: Text('Demo games coming soon'),
            ),
          ),
          const SizedBox(height: 12),
          const Center(
            child: Text(
              'SUPER KASI BETS • DEMO VERSION',
              style: TextStyle(color: Colors.white54),
            ),
          ),
        ],
      ),
    );
  }

  Widget matchCard(
    String home,
    String away,
    String homeOdds,
    String drawOdds,
    String awayOdds,
  ) {
    return Card(
      color: const Color(0xFF103D28),
      child: Padding(
        padding: const EdgeInsets.all(14),
        child: Column(
          children: [
            Text('$home  vs  $away',
                style: const TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                oddsButton('1', homeOdds),
                oddsButton('X', drawOdds),
                oddsButton('2', awayOdds),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget oddsButton(String label, String odds) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      decoration: BoxDecoration(
        color: const Color(0xFFFFD700),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        '$label\n$odds',
        textAlign: TextAlign.center,
        style: const TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
