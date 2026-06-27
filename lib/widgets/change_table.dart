import 'package:flutter/material.dart';
import '../models/change_calculator.dart';

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