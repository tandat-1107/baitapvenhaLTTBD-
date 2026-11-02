import 'package:flutter/material.dart';

void main() {
  runApp(const IfElseApp());
}

class IfElseApp extends StatelessWidget {
  const IfElseApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: IfElsePage(),
    );
  }
}

class IfElsePage extends StatefulWidget {
  const IfElsePage({super.key});

  @override
  State<IfElsePage> createState() => _IfElsePageState();
}

class _IfElsePageState extends State<IfElsePage> {
  final TextEditingController scoreController =
      TextEditingController(text: '8.5');

  double score = 8.5;

  String classifyScore(double score) {
    if (score < 0 || score > 10) {
      return 'Không hợp lệ';
    } else if (score >= 8.0) {
      return 'Giỏi';
    } else if (score >= 6.5) {
      return 'Khá';
    } else if (score >= 5.0) {
      return 'Trung bình';
    } else {
      return 'Yếu';
    }
  }

  Color getResultColor(String result) {
    if (result == 'Giỏi') {
      return Colors.green;
    } else if (result == 'Khá') {
      return Colors.blue;
    } else if (result == 'Trung bình') {
      return Colors.orange;
    } else if (result == 'Yếu') {
      return Colors.red;
    } else {
      return Colors.grey;
    }
  }

  void updateScore(String value) {
    final double? newScore = double.tryParse(value);

    if (newScore != null) {
      setState(() {
        score = newScore;
      });
    }
  }

  String formatScore(double value) {
    if (value == value.toInt()) {
      return value.toInt().toString();
    }
    return value.toString();
  }

  @override
  void dispose() {
    scoreController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final String mainResult = classifyScore(score);
    final Color mainColor = getResultColor(mainResult);

    final List<double> testScores = [
      9,
      7,
      5.5,
      3,
      11,
    ];

    return Scaffold(
      backgroundColor: const Color(0xFFEDEDED),
      body: Center(
        child: Container(
          width: 360,
          height: 740,
          decoration: BoxDecoration(
            color: Colors.black,
            borderRadius: BorderRadius.circular(48),
          ),
          padding: const EdgeInsets.all(10),
          child: Container(
            decoration: BoxDecoration(
              color: const Color(0xFFF6F6FA),
              borderRadius: BorderRadius.circular(38),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(38),
              child: Column(
                children: [
                  Container(
                    color: const Color(0xFF35568D),
                    padding: const EdgeInsets.fromLTRB(
                      16,
                      12,
                      16,
                      8,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          '9:41',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Row(
                          children: const [
                            Icon(
                              Icons.signal_cellular_alt,
                              color: Colors.white,
                              size: 16,
                            ),
                            SizedBox(width: 4),
                            Icon(
                              Icons.wifi,
                              color: Colors.white,
                              size: 16,
                            ),
                            SizedBox(width: 4),
                            Icon(
                              Icons.battery_full,
                              color: Colors.white,
                              size: 17,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),

                  Container(
                    width: double.infinity,
                    color: const Color(0xFF35568D),
                    padding: const EdgeInsets.fromLTRB(
                      16,
                      8,
                      16,
                      14,
                    ),
                    child: const Text(
                      'Xếp loại học lực',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 19,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),

                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(14),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            width: double.infinity,
                            padding: const EdgeInsets.all(18),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Column(
                              children: [
                                const Text(
                                  'Điểm trung bình',
                                  style: TextStyle(
                                    fontSize: 13,
                                    color: Colors.grey,
                                  ),
                                ),

                                const SizedBox(height: 10),

                                SizedBox(
                                  width: 110,
                                  child: TextField(
                                    controller: scoreController,
                                    textAlign: TextAlign.center,
                                    keyboardType:
                                        const TextInputType.numberWithOptions(
                                      decimal: true,
                                    ),
                                    style: const TextStyle(
                                      fontSize: 42,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    decoration: const InputDecoration(
                                      border: InputBorder.none,
                                    ),
                                    onChanged: updateScore,
                                  ),
                                ),

                                const SizedBox(height: 12),

                                Container(
                                  width: double.infinity,
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 10,
                                  ),
                                  decoration: BoxDecoration(
                                    color: mainColor.withOpacity(0.12),
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: Text(
                                    mainResult,
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      color: mainColor,
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),

                          const SizedBox(height: 18),

                          const Text(
                            'KIỂM TRA THÊM',
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.grey,
                              fontWeight: FontWeight.bold,
                            ),
                          ),

                          const SizedBox(height: 8),

                          Container(
                            width: double.infinity,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Column(
                              children: [
                                for (int i = 0;
                                    i < testScores.length;
                                    i++)
                                  buildScoreRow(
                                    testScores[i],
                                    i == testScores.length - 1,
                                  ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  Container(
                    padding: const EdgeInsets.only(
                      top: 8,
                      bottom: 8,
                    ),
                    child: Container(
                      width: 100,
                      height: 4,
                      decoration: BoxDecoration(
                        color: Colors.black87,
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget buildScoreRow(double score, bool isLast) {
    final String result = classifyScore(score);
    final Color color = getResultColor(result);

    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 12,
        vertical: 12,
      ),
      decoration: BoxDecoration(
        border: isLast
            ? null
            : const Border(
                bottom: BorderSide(
                  color: Color(0xFFEAEAEA),
                ),
              ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'Điểm ${formatScore(score)}',
          ),
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 10,
              vertical: 4,
            ),
            decoration: BoxDecoration(
              color: color.withOpacity(0.12),
              borderRadius: BorderRadius.circular(5),
            ),
            child: Text(
              result,
              style: TextStyle(
                color: color,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }
}