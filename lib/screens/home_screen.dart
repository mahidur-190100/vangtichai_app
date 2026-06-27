import 'package:flutter/material.dart';
import '../widgets/amount_display.dart';
import '../widgets/change_table.dart';
import '../widgets/numeric_keypad.dart';

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