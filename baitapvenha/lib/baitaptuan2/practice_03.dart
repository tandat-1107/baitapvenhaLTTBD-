import 'package:flutter/material.dart';

void main() {
  runApp(const Practice03App());
}

class Practice03App extends StatelessWidget {
  const Practice03App({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Practice03Page(),
    );
  }
}

class Practice03Page extends StatefulWidget {
  const Practice03Page({super.key});

  @override
  State<Practice03Page> createState() => _Practice03PageState();
}

class _Practice03PageState extends State<Practice03Page> {
  final TextEditingController number1Controller = TextEditingController();
  final TextEditingController number2Controller = TextEditingController();

  String selectedOperator = '+';
  double result = 0;

  void calculate(String operator) {
    final double number1 =
        double.tryParse(number1Controller.text) ?? 0;

    final double number2 =
        double.tryParse(number2Controller.text) ?? 0;

    double newResult = 0;

    if (operator == '+') {
      newResult = number1 + number2;
    } else if (operator == '-') {
      newResult = number1 - number2;
    } else if (operator == '*') {
      newResult = number1 * number2;
    } else if (operator == '/') {
      if (number2 != 0) {
        newResult = number1 / number2;
      } else {
        newResult = 0;
      }
    }

    setState(() {
      selectedOperator = operator;
      result = newResult;
    });
  }

  String formatResult(double value) {
    if (value == value.toInt()) {
      return value.toInt().toString();
    }

    return value.toStringAsFixed(2);
  }

  @override
  void dispose() {
    number1Controller.dispose();
    number2Controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFEDEDED),

      body: Center(
        child: Container(
          width: 360,
          height: 740,

          decoration: BoxDecoration(
            color: Colors.black,
            borderRadius: BorderRadius.circular(48),
            boxShadow: const [
              BoxShadow(
                color: Colors.black26,
                blurRadius: 20,
                offset: Offset(0, 8),
              ),
            ],
          ),

          padding: const EdgeInsets.all(10),

          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(38),
            ),

            padding: const EdgeInsets.symmetric(
              horizontal: 20,
              vertical: 20,
            ),

            child: Column(
              children: [
                // Thanh trạng thái giả
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      '9:41',
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                      ),
                    ),

                    Row(
                      children: const [
                        Icon(
                          Icons.signal_cellular_alt,
                          size: 16,
                        ),
                        SizedBox(width: 4),
                        Icon(
                          Icons.wifi,
                          size: 16,
                        ),
                        SizedBox(width: 4),
                        Icon(
                          Icons.battery_full,
                          size: 18,
                        ),
                      ],
                    ),
                  ],
                ),

                const SizedBox(height: 95),

                const Text(
                  'Thực hành 03',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                ),

                const SizedBox(height: 55),

                // Số thứ nhất
                TextField(
                  controller: number1Controller,
                  keyboardType: const TextInputType.numberWithOptions(
                    decimal: true,
                  ),
                  decoration: InputDecoration(
                    hintText: 'Nhập số thứ nhất',
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 14,
                      vertical: 12,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),

                const SizedBox(height: 20),

                // Các phép toán
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    operationButton(
                      symbol: '+',
                      backgroundColor: Colors.red,
                    ),
                    operationButton(
                      symbol: '-',
                      backgroundColor: Colors.orange,
                    ),
                    operationButton(
                      symbol: '*',
                      backgroundColor: Colors.deepPurple,
                    ),
                    operationButton(
                      symbol: '/',
                      backgroundColor: Colors.black,
                    ),
                  ],
                ),

                const SizedBox(height: 20),

                // Số thứ hai
                TextField(
                  controller: number2Controller,
                  keyboardType: const TextInputType.numberWithOptions(
                    decimal: true,
                  ),
                  decoration: InputDecoration(
                    hintText: 'Nhập số thứ hai',
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 14,
                      vertical: 12,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),

                const SizedBox(height: 14),

                // Kết quả
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Kết quả: ${formatResult(result)}',
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),

                const Spacer(),

                // Thanh home giả
                Container(
                  width: 110,
                  height: 4,
                  decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget operationButton({
    required String symbol,
    required Color backgroundColor,
  }) {
    final bool selected = selectedOperator == symbol;

    return GestureDetector(
      onTap: () {
        calculate(symbol);
      },

      child: Container(
        width: 48,
        height: 48,

        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(8),
          border: selected
              ? Border.all(
                  color: Colors.black,
                  width: 3,
                )
              : null,
        ),

        alignment: Alignment.center,

        child: Text(
          symbol,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}