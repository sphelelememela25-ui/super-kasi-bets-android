
import 'dart:math';
import 'package:flutter/material.dart';

void main() => runApp(const SuperKasiBetsApp());

const Color bg = Color(0xFF090B12);
const Color panel = Color(0xFF171B27);
const Color gold = Color(0xFFFFD700);
const Color lime = Color(0xFFB7F000);

class SuperKasiBetsApp extends StatelessWidget {
  const SuperKasiBetsApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Super Kasi Bets',
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: bg,
        colorScheme: const ColorScheme.dark(
          primary: gold,
          secondary: lime,
        ),
        appBarTheme: const AppBarTheme(
          backgroundColor: bg,
          elevation: 0,
        ),
      ),
      home: const MainScreen(),
    );
  }
}

class SlotGame {
  final String name;
  final String emoji;
  final List<Color> colors;

  const SlotGame(this.name, this.emoji, this.colors);
}

const List<SlotGame> slotGames = [
  SlotGame('Lucky 7', '7️⃣', [Color(0xFF8E1010), Color(0xFFFFB000)]),
  SlotGame('Fruit Spin', '🍇', [Color(0xFF5B168C), Color(0xFFFF4F81)]),
  SlotGame('Super Fruits', '🍒', [Color(0xFFB51E16), Color(0xFFFFA000)]),
  SlotGame('Golden Tiger', '🐅', [Color(0xFF4C2100), Color(0xFFFFB300)]),
  SlotGame('African Safari', '🐘', [Color(0xFF155B39), Color(0xFFB9A34A)]),
  SlotGame('Book of Gold', '📖', [Color(0xFF4C2600), Color(0xFFFFD700)]),
  SlotGame('Diamond Riches', '💎', [Color(0xFF064B8C), Color(0xFF58D8FF)]),
  SlotGame('Mega Pharaoh', '👑', [Color(0xFF713A00), Color(0xFFFFD45A)]),
  SlotGame('Lucky Bells', '🔔', [Color(0xFF8B3A00), Color(0xFFFFD700)]),
  SlotGame('Hot Fire', '🔥', [Color(0xFF8E0909), Color(0xFFFF6B00)]),
  SlotGame('Candy Rush', '🍭', [Color(0xFF9C167B), Color(0xFFFF6F9B)]),
  SlotGame('Wild Buffalo', '🐃', [Color(0xFF633B20), Color(0xFFC58C42)]),
  SlotGame('Dragon Gold', '🐉', [Color(0xFF651010), Color(0xFFFF9B00)]),
  SlotGame('Royal Gems', '💜', [Color(0xFF411080), Color(0xFFDA55FF)]),
  SlotGame('Treasure Chest', '🧰', [Color(0xFF063B83), Color(0xFFFFC400)]),
  SlotGame('Super Jackpot', '🎰', [Color(0xFF8B1010), Color(0xFFFFD700)]),
  SlotGame('Crown Fortune', '👸', [Color(0xFF4C1B75), Color(0xFFFFC84A)]),
  SlotGame('Golden Lion', '🦁', [Color(0xFF653300), Color(0xFFFFD000)]),
  SlotGame('Kasi Spin', '♠️', [Color(0xFF101D65), Color(0xFF8B62FF)]),
  SlotGame('Mega Stars', '⭐', [Color(0xFF4A126D), Color(0xFFFF54B5)]),
];

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int page = 0;
  double wallet = 150.00;
  final List<String> betHistory = [];

  void spendDemoCredit(double amount, String description) {
    if (wallet < amount) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Not enough demo credits.')),
      );
      return;
    }

    setState(() {
      wallet -= amount;
      betHistory.insert(
        0,
        '$description • R${amount.toStringAsFixed(2)} demo',
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    final pages = [
      HomePage(
        wallet: wallet,
        onNavigate: (p) => setState(() => page = p),
        onBet: spendDemoCredit,
      ),
      SlotsPage(
        wallet: wallet,
        onPlay: (name) => spendDemoCredit(1, name),
      ),
      AviatorPage(
        wallet: wallet,
        onPlay: (stake) => spendDemoCredit(stake, 'Aviator demo round'),
      ),
      HistoryPage(history: betHistory),
      const SupportPage(),
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'SUPER KASI BETS',
          style: TextStyle(
            color: gold,
            fontWeight: FontWeight.w900,
            letterSpacing: 1,
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 14),
            child: Center(
              child: Text(
                'R${wallet.toStringAsFixed(2)}',
                style: const TextStyle(
                  color: lime,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
      body: SafeArea(child: pages[page]),
      bottomNavigationBar: NavigationBar(
        backgroundColor: const Color(0xFF111521),
        indicatorColor: gold.withOpacity(.2),
        selectedIndex: page,
        onDestinationSelected: (value) {
          setState(() => page = value);
        },
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.home_outlined),
            selectedIcon: Icon(Icons.home, color: gold),
            label: 'Home',
          ),
          NavigationDestination(
            icon: Icon(Icons.casino_outlined),
            selectedIcon: Icon(Icons.casino, color: gold),
            label: 'Slots',
          ),
          NavigationDestination(
            icon: Icon(Icons.flight),
            selectedIcon: Icon(Icons.flight, color: gold),
            label: 'Aviator',
          ),
          NavigationDestination(
            icon: Icon(Icons.history),
            selectedIcon: Icon(Icons.history, color: gold),
            label: 'My Bets',
          ),
          NavigationDestination(
            icon: Icon(Icons.support_agent),
            selectedIcon: Icon(Icons.support_agent, color: gold),
            label: 'Support',
          ),
        ],
      ),
    );
  }
}

class HomePage extends StatelessWidget {
  final double wallet;
  final ValueChanged<int> onNavigate;
  final void Function(double, String) onBet;

  const HomePage({
    super.key,
    required this.wallet,
    required this.onNavigate,
    required this.onBet,
  });

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(14),
      children: [
        Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [
                Color(0xFF101D32),
                Color(0xFF5A3300),
                Color(0xFF111521),
              ],
            ),
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: gold, width: 1.5),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'WELCOME TO',
                style: TextStyle(
                  color: Colors.white70,
                  letterSpacing: 3,
                ),
              ),
              const Text(
                'SUPER KASI BETS',
                style: TextStyle(
                  fontSize: 27,
                  fontWeight: FontWeight.w900,
                  color: gold,
                ),
              ),
              const SizedBox(height: 15),
              const Text(
                'DEMO WALLET',
                style: TextStyle(color: Colors.white70),
              ),
              Text(
                'R${wallet.toStringAsFixed(2)}',
                style: const TextStyle(
                  fontSize: 32,
                  color: lime,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const Text(
                'Virtual credits only • No cash value',
                style: TextStyle(
                  color: Colors.white70,
                  fontSize: 12,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 18),
        Row(
          children: [
            Expanded(
              child: _quickButton(
                '20 SLOT GAMES',
                '🎰',
                () => onNavigate(1),
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: _quickButton(
                'AVIATOR DEMO',
                '✈️',
                () => onNavigate(2),
              ),
            ),
          ],
        ),
        const SizedBox(height: 22),
        const SectionTitle('FOOTBALL DEMO MATCHES'),
        MatchCard(
          home: 'Arsenal',
          away: 'Chelsea',
          odds: ['2.10', '3.20', '2.80'],
          onSelect: (v) => onBet(2, 'Arsenal vs Chelsea: $v'),
        ),
        MatchCard(
          home: 'Real Madrid',
          away: 'Barcelona',
          odds: ['2.00', '3.40', '2.90'],
          onSelect: (v) => onBet(2, 'Real Madrid vs Barcelona: $v'),
        ),
        const SizedBox(height: 14),
        const Text(
          'All matches and odds are examples for demonstration, not live betting markets.',
          style: TextStyle(
            color: Colors.white54,
            fontSize: 12,
          ),
        ),
      ],
    );
  }

  Widget _quickButton(String label, String emoji, VoidCallback tap) {
    return InkWell(
      onTap: tap,
      borderRadius: BorderRadius.circular(14),
      child: Container(
        padding: const EdgeInsets.symmetric(
          vertical: 18,
          horizontal: 8,
        ),
        decoration: BoxDecoration(
          color: panel,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: gold.withOpacity(.6)),
        ),
        child: Column(
          children: [
            Text(emoji, style: const TextStyle(fontSize: 30)),
            const SizedBox(height: 7),
            Text(
              label,
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: gold,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class MatchCard extends StatelessWidget {
  final String home;
  final String away;
  final List<String> odds;
  final ValueChanged<String> onSelect;

  const MatchCard({
    super.key,
    required this.home,
    required this.away,
    required this.odds,
    required this.onSelect,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: panel,
      margin: const EdgeInsets.only(top: 10),
      child: Padding(
        padding: const EdgeInsets.all(14),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    home,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                ),
                const Text(
                  'VS',
                  style: TextStyle(
                    color: gold,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Expanded(
                  child: Text(
                    away,
                    textAlign: TextAlign.end,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                for (int i = 0; i < 3; i++)
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 4),
                      child: OutlinedButton(
                        onPressed: () {
                          onSelect(['Home win', 'Draw', 'Away win'][i]);
                        },
                        style: OutlinedButton.styleFrom(
                          foregroundColor: gold,
                          side: const BorderSide(color: gold),
                        ),
                        child: Text(
                          '${['1', 'X', '2'][i]}\n${odds[i]}',
                          textAlign: TextAlign.center,
                        ),
                      ),
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

class SlotsPage extends StatelessWidget {
  final double wallet;
  final ValueChanged<String> onPlay;

  const SlotsPage({
    super.key,
    required this.wallet,
    required this.onPlay,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(14),
          child: Row(
            children: [
              const Expanded(
                child: SectionTitle('20 AMAZING SLOT GAMES'),
              ),
              Text(
                'R${wallet.toStringAsFixed(2)}',
                style: const TextStyle(
                  color: lime,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
        Expanded(
          child: GridView.builder(
            padding: const EdgeInsets.fromLTRB(12, 0, 12, 16),
            itemCount: slotGames.length,
            gridDelegate:
                const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 1.25,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
            ),
            itemBuilder: (context, index) {
              final game = slotGames[index];

              return InkWell(
                onTap: () => _showSlotDialog(context, game, onPlay),
                borderRadius: BorderRadius.circular(16),
                child: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: game.colors,
                    ),
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: gold, width: 1.5),
                    boxShadow: [
                      BoxShadow(
                        color: game.colors.first.withOpacity(.35),
                        blurRadius: 8,
                      ),
                    ],
                  ),
                  child: Stack(
                    children: [
                      Positioned(
                        left: 8,
                        top: 7,
                        child: Text(
                          '${index + 1}'.padLeft(2, '0'),
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Center(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              game.emoji,
                              style: const TextStyle(fontSize: 42),
                            ),
                            Text(
                              game.name,
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.w900,
                                shadows: [
                                  Shadow(
                                    color: Colors.black,
                                    blurRadius: 5,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      const Positioned(
                        right: 8,
                        bottom: 7,
                        child: Text(
                          'PLAY DEMO',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 9,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}

void _showSlotDialog(
  BuildContext context,
  SlotGame game,
  ValueChanged<String> onPlay,
) {
  showDialog(
    context: context,
    builder: (context) => AlertDialog(
      backgroundColor: panel,
      title: Text(
        game.name,
        style: const TextStyle(color: gold),
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            game.emoji,
            style: const TextStyle(fontSize: 65),
          ),
          const Text(
            'Play one free demo spin for 1 virtual credit?',
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('CANCEL'),
        ),
        ElevatedButton(
          onPressed: () {
            Navigator.pop(context);
            onPlay(game.name);
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('${game.name}: demo spin started.'),
              ),
            );
          },
          child: const Text('PLAY DEMO'),
        ),
      ],
    ),
  );
}

class AviatorPage extends StatefulWidget {
  final double wallet;
  final ValueChanged<double> onPlay;

  const AviatorPage({
    super.key,
    required this.wallet,
    required this.onPlay,
  });

  @override
  State<AviatorPage> createState() => _AviatorPageState();
}

class _AviatorPageState extends State<AviatorPage> {
  final TextEditingController stake =
      TextEditingController(text: '5');

  String status = 'READY FOR DEMO';
  double multiplier = 1.00;
  bool running = false;

  void play() {
    final amount = double.tryParse(stake.text);

    if (amount == null || amount <= 0 || amount > widget.wallet) {
      setState(() {
        status = 'Enter a valid stake within your demo balance.';
      });
      return;
    }

    widget.onPlay(amount);

    setState(() {
      running = true;
      multiplier = 1.00 + Random().nextDouble() * 4.0;
      status = 'DEMO ROUND RESULT';
    });
  }

  @override
  void dispose() {
    stake.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        Container(
          height: 260,
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [
                Color(0xFF101B35),
                Color(0xFF7B102B),
                Color(0xFF090B12),
              ],
            ),
            borderRadius: BorderRadius.circular(22),
            border: Border.all(color: gold, width: 1.5),
          ),
          child: Stack(
            children: [
              const Positioned(
                left: 18,
                top: 18,
                child: Text(
                  'AVIATOR',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 27,
                    fontWeight: FontWeight.w900,
                    fontStyle: FontStyle.italic,
                  ),
                ),
              ),
              Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Text(
                      '✈️',
                      style: TextStyle(fontSize: 70),
                    ),
                    Text(
                      running
                          ? '${multiplier.toStringAsFixed(2)}x'
                          : '1.00x',
                      style: const TextStyle(
                        color: gold,
                        fontSize: 42,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                    Text(
                      status,
                      textAlign: TextAlign.center,
                      style: const TextStyle(color: Colors.white70),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 18),
        const Text(
          'DEMO STAKE',
          style: TextStyle(
            color: gold,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 8),
        TextField(
          controller: stake,
          keyboardType: TextInputType.number,
          decoration: const InputDecoration(
            prefixText: 'R ',
            filled: true,
            fillColor: panel,
            border: OutlineInputBorder(),
          ),
        ),
        const SizedBox(height: 12),
        ElevatedButton(
          onPressed: play,
          style: ElevatedButton.styleFrom(
            backgroundColor: gold,
            foregroundColor: Colors.black,
            padding: const EdgeInsets.all(16),
          ),
          child: const Text(
            'PLAY AVIATOR DEMO',
            style: TextStyle(fontWeight: FontWeight.w900),
          ),
        ),
        const SizedBox(height: 14),
        const Text(
          'This is a simple random demo animation only. '
          'It is not connected to a real game, betting service '
          'or cash-out system.',
          style: TextStyle(
            color: Colors.white60,
            height: 1.5,
          ),
        ),
      ],
    );
  }
}

class HistoryPage extends StatelessWidget {
  final List<String> history;

  const HistoryPage({
    super.key,
    required this.history,
  });

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        const SectionTitle('MY DEMO ACTIVITY'),
        if (history.isEmpty)
          const Padding(
            padding: EdgeInsets.only(top: 30),
            child: Center(
              child: Text(
                'No demo activity yet.',
                style: TextStyle(color: Colors.white60),
              ),
            ),
          )
        else
          ...history.map(
            (item) => Card(
              color: panel,
              child: ListTile(
                leading: const Icon(
                  Icons.receipt_long,
                  color: gold,
                ),
                title: Text(
                  item,
                  style: const TextStyle(fontSize: 13),
                ),
                subtitle: const Text('Virtual demo only'),
              ),
            ),
          ),
      ],
    );
  }
}

class SupportPage extends StatelessWidget {
  const SupportPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.all(18),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SectionTitle('SUPPORT'),
          SizedBox(height: 14),
          Text(
            'Welcome to Super Kasi Bets demo support.',
            style: TextStyle(fontSize: 17),
          ),
          SizedBox(height: 12),
          Text(
            'For help with this prototype, contact the app administrator. '
            'Do not send passwords, OTP codes or banking details.',
          ),
          SizedBox(height: 20),
          Text(
            'This app is currently a demonstration. '
            'It does not accept deposits or process withdrawals.',
            style: TextStyle(
              color: gold,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}

class SectionTitle extends StatelessWidget {
  final String text;

  const SectionTitle(this.text, {super.key});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: const TextStyle(
        color: gold,
        fontSize: 17,
        fontWeight: FontWeight.w900,
        letterSpacing: .5,
      ),
    );
  }
}
