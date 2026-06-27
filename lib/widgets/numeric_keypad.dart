import 'package:flutter/material.dart';

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