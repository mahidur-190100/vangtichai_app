import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'VangtiChai',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        useMaterial3: true,
      ),
      home: const HomeScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}


class ChangeCalculator {
  static const List<int> noteDenominations = [500, 100, 50, 20, 10, 5, 2, 1];

  static Map<int, int> calculateChange(int amount) {
    Map<int, int> change = {};
    int remaining = amount;

    for (int denom in noteDenominations) {
      if (remaining >= denom) {
        int count = remaining ~/ denom;  // Integer division
        change[denom] = count;
        remaining -= count * denom;
      }
    }
    return change;
  }
}


class AmountDisplay extends StatelessWidget {
  final int amount;

  const AmountDisplay({Key? key, required this.amount}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            'Taka: ',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          Text(
            amount.toString(),
            style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}


class ChangeTable extends StatelessWidget {
  final int amount;

  const ChangeTable({Key? key, required this.amount}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Map<int, int> change = ChangeCalculator.calculateChange(amount);

    return Container(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          const Text(
            'Notes',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          Expanded(
            child: ListView.builder(
              itemCount: ChangeCalculator.noteDenominations.length,
              itemBuilder: (context, index) {
                int denom = ChangeCalculator.noteDenominations[index];
                int count = change[denom] ?? 0;
                if (count > 0) {
                  return ListTile(
                    title: Text('Tk. $denom'),
                    trailing: Text('x$count'),
                  );
                }
                return const SizedBox.shrink();
              },
            ),
          ),
        ],
      ),
    );
  }
}


class NumericKeypad extends StatelessWidget {
  final Function(int) onDigitPressed;
  final VoidCallback onClearPressed;
  final bool isLandscape;

  const NumericKeypad({
    Key? key,
    required this.onDigitPressed,
    required this.onClearPressed,
    this.isLandscape = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Widget> buttons = [];


    for (int i = 1; i <= 9; i++) {
      buttons.add(
        _buildKeypadButton(
          label: i.toString(),
          onPressed: () => onDigitPressed(i),
        ),
      );
    }


    buttons.add(
      _buildKeypadButton(
        label: 'C',
        onPressed: onClearPressed,
        color: Colors.red,
      ),
    );


    buttons.add(
      _buildKeypadButton(
        label: '0',
        onPressed: () => onDigitPressed(0),
      ),
    );


    return GridView.count(
      crossAxisCount: 3,
      childAspectRatio: 1.5,
      padding: const EdgeInsets.all(8.0),
      mainAxisSpacing: 4.0,
      crossAxisSpacing: 4.0,
      children: buttons,
    );
  }

  Widget _buildKeypadButton({
    required String label,
    required VoidCallback onPressed,
    Color? color,
  }) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: color ?? Colors.blue,
        foregroundColor: Colors.white,
        minimumSize: const Size(double.infinity, 50),
      ),
      child: Text(
        label,
        style: const TextStyle(fontSize: 24),
      ),
    );
  }
}


class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentAmount = 0;


  void _addDigit(int digit) {
    setState(() {
      _currentAmount = _currentAmount * 10 + digit;
      if (_currentAmount > 99999) {
        _currentAmount = 99999;
      }
    });
  }


  void _clearAmount() {
    setState(() {
      _currentAmount = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('VangtiChai'),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
      ),
      body: OrientationBuilder(
        builder: (context, orientation) {
          if (orientation == Orientation.portrait) {
            return _buildPortraitLayout();
          } else {
            return _buildLandscapeLayout();
          }
        },
      ),
    );
  }


  Widget _buildPortraitLayout() {
    return Column(
      children: [
        AmountDisplay(amount: _currentAmount),
        const Divider(height: 1),
        Expanded(
          child: Row(
            children: [
              Expanded(
                flex: 4,
                child: ChangeTable(amount: _currentAmount),
              ),
              Expanded(
                flex: 6,
                child: NumericKeypad(
                  onDigitPressed: _addDigit,
                  onClearPressed: _clearAmount,
                  isLandscape: false,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildLandscapeLayout() {
    return Row(
      children: [
        Expanded(
          flex: 6,
          child: Column(
            children: [
              AmountDisplay(amount: _currentAmount),
              Expanded(
                child: NumericKeypad(
                  onDigitPressed: _addDigit,
                  onClearPressed: _clearAmount,
                  isLandscape: true,
                ),
              ),
            ],
          ),
        ),
        Expanded(
          flex: 4,
          child: ChangeTable(amount: _currentAmount),
        ),
      ],
    );
  }
}