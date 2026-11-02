
import 'package:flutter/material.dart';

const Color primaryBlue = Color(0xFF2196F3);
const Color lightBlue = Color(0xFFBBDEFB);
const Color boxBlue = Color(0xFFB1C9F2);
const Color darkBlue = Color(0xFF5085E8);

// =====================================================
// MAIN UI
// =====================================================

class GiaoDienUIUX extends StatelessWidget {
  const GiaoDienUIUX({super.key});

  @override
  Widget build(BuildContext context) {
    return const WelcomeScreen();
  }
}

// =====================================================
// 1. WELCOME SCREEN
// =====================================================

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            const Spacer(flex: 3),
            const Icon(
              Icons.view_in_ar_rounded,
              size: 78,
              color: primaryBlue,
            ),
            const SizedBox(height: 76),
            const Text(
              'Jetpack Compose',
              style: TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 108),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 35),
              child: Text(
                'Jetpack Compose is a modern UI toolkit '
                'for building native Android applications.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 14,
                  height: 1.2,
                  color: Colors.grey,
                ),
              ),
            ),
            const Spacer(flex: 3),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 45),
              child: SizedBox(
                width: double.infinity,
                height: 42,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: primaryBlue,
                    foregroundColor: Colors.white,
                    elevation: 0,
                    shape: const StadiumBorder(),
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => const ComponentsScreen(),
                      ),
                    );
                  },
                  child: const Text(
                    "I'm ready",
                    style: TextStyle(fontSize: 12),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 60),
          ],
        ),
      ),
    );
  }
}

// =====================================================
// 2. UI COMPONENTS LIST
// =====================================================

class ComponentsScreen extends StatelessWidget {
  const ComponentsScreen({super.key});

  void openPage(BuildContext context, Widget page) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => page),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.fromLTRB(24, 20, 24, 24),
          children: [
            const Center(
              child: Text(
                'UI Components List',
                style: TextStyle(
                  color: primaryBlue,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: 25),

            const SectionTitle(title: 'Display'),
            ComponentCard(
              title: 'Text',
              description: 'Displays text',
              onTap: () => openPage(
                context,
                const TextDetailScreen(),
              ),
            ),
            ComponentCard(
              title: 'Image',
              description: 'Displays an image',
              onTap: () => openPage(
                context,
                const ImageDetailScreen(),
              ),
            ),

            const SizedBox(height: 2),
            const SectionTitle(title: 'Input'),
            ComponentCard(
              title: 'TextField',
              description: 'Input field for text',
              onTap: () => openPage(
                context,
                const TextFieldDetailScreen(),
              ),
            ),
            ComponentCard(
              title: 'PasswordField',
              description: 'Input field for passwords',
              onTap: () => openPage(
                context,
                const PasswordDetailScreen(),
              ),
            ),

            const SizedBox(height: 2),
            const SectionTitle(title: 'Layout'),
            ComponentCard(
              title: 'Column',
              description: 'Arranges elements vertically',
              onTap: () => openPage(
                context,
                const ColumnDetailScreen(),
              ),
            ),
            ComponentCard(
              title: 'Row',
              description: 'Arranges elements horizontally',
              onTap: () => openPage(
                context,
                const RowDetailScreen(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// =====================================================
// SECTION TITLE
// =====================================================

class SectionTitle extends StatelessWidget {
  final String title;

  const SectionTitle({
    super.key,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 7),
      child: Text(
        title,
        style: const TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 14,
          color: Colors.black,
        ),
      ),
    );
  }
}

// =====================================================
// COMPONENT CARD
// =====================================================

class ComponentCard extends StatelessWidget {
  final String title;
  final String description;
  final VoidCallback onTap;

  const ComponentCard({
    super.key,
    required this.title,
    required this.description,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 14),
      child: Material(
        color: lightBlue,
        borderRadius: BorderRadius.circular(7),
        child: InkWell(
          borderRadius: BorderRadius.circular(7),
          onTap: onTap,
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(
              horizontal: 9,
              vertical: 7,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 17,
                    color: Colors.black,
                  ),
                ),
                Text(
                  description,
                  style: const TextStyle(
                    fontSize: 17,
                    color: Colors.black,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// =====================================================
// REUSABLE DETAIL PAGE
// Các màn hình chi tiết đều có nút quay lại
// =====================================================

class DetailPage extends StatelessWidget {
  final String title;
  final Widget child;

  const DetailPage({
    super.key,
    required this.title,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(
              height: 44,
              child: Align(
                alignment: Alignment.centerLeft,
                child: IconButton(
                  tooltip: 'Quay lại',
                  icon: const Icon(
                    Icons.arrow_back,
                    color: Colors.black87,
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
              ),
            ),
            Text(
              title,
              style: const TextStyle(
                color: primaryBlue,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            Expanded(child: child),
          ],
        ),
      ),
    );
  }
}

// =====================================================
// 3. TEXT DETAIL
// =====================================================

class TextDetailScreen extends StatelessWidget {
  const TextDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DetailPage(
      title: 'Text Detail',
      child: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18),
          child: RichText(
            textAlign: TextAlign.center,
            text: const TextSpan(
              style: TextStyle(
                fontSize: 19,
                color: Colors.black,
              ),
              children: [
                TextSpan(
                  text: 'The ',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                TextSpan(
                  text: 'quick ',
                  style: TextStyle(
                    decoration: TextDecoration.lineThrough,
                  ),
                ),
                TextSpan(
                  text: 'Brown',
                  style: TextStyle(
                    color: Colors.orange,
                    fontSize: 23,
                  ),
                ),
                TextSpan(text: '\nfox '),
                TextSpan(
                  text: 'jumps',
                  style: TextStyle(fontStyle: FontStyle.italic),
                ),
                TextSpan(
                  text: ' over ',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                TextSpan(
                  text: 'the',
                  style: TextStyle(
                    decoration: TextDecoration.underline,
                  ),
                ),
                TextSpan(text: ' lazy dog.'),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// =====================================================
// 4. IMAGE DETAIL - HIỂN THỊ 2 ẢNH TỪ ASSETS
// =====================================================

class ImageDetailScreen extends StatelessWidget {
  const ImageDetailScreen({super.key});

  static const String imageUrl =
      'https://giaothongvantaihcm.edu.vn/wp-content/'
      'uploads/2025/01/Logo-GTVT.png';

  @override
  Widget build(BuildContext context) {
    return DetailPage(
      title: 'Image',
      child: LayoutBuilder(
        builder: (context, constraints) {
          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: [
                  SizedBox(
                    height: constraints.maxHeight * 0.12,
                  ),

                  // Ảnh thứ nhất
                  Image.asset(
                    'assets/campus_1.jpg',
                    width: double.infinity,
                    height: 165,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return const SizedBox(
                        height: 165,
                        child: Center(
                          child: Text('Không tải được ảnh thứ nhất'),
                        ),
                      );
                    },
                  ),

                  const SizedBox(height: 5),

                  // Đường dẫn ảnh như trong Figma
                  GestureDetector(
                    onTap: () {},
                    child: const Text(
                      imageUrl,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 12,
                        decoration: TextDecoration.underline,
                        color: Colors.black,
                      ),
                    ),
                  ),

                  const SizedBox(height: 25),

                  // Ảnh thứ hai
                  Image.asset(
                    'assets/campus_2.jpg',
                    width: double.infinity,
                    height: 165,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return const SizedBox(
                        height: 165,
                        child: Center(
                          child: Text('Không tải được ảnh thứ hai'),
                        ),
                      );
                    },
                  ),

                  const SizedBox(height: 18),

                  const Text(
                    'In app',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.black,
                    ),
                  ),

                  const SizedBox(height: 20),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

// =====================================================
// 5. TEXTFIELD DETAIL
// =====================================================

class TextFieldDetailScreen extends StatefulWidget {
  const TextFieldDetailScreen({super.key});

  @override
  State<TextFieldDetailScreen> createState() =>
      _TextFieldDetailScreenState();
}

class _TextFieldDetailScreenState
    extends State<TextFieldDetailScreen> {
  String inputText = '';

  @override
  Widget build(BuildContext context) {
    return DetailPage(
      title: 'TextField',
      child: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 49),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                onChanged: (value) {
                  setState(() {
                    inputText = value;
                  });
                },
                decoration: InputDecoration(
                  hintText: 'Thông tin nhập',
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 17,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(22),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(22),
                    borderSide: const BorderSide(
                      color: Color(0xFFCCCCCC),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 22),
              Text(
                inputText.isEmpty
                    ? 'Tự động cập nhật dữ liệu theo textfield'
                    : inputText,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: Color(0xFFFF5267),
                  fontSize: 14,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// =====================================================
// 6. PASSWORDFIELD DETAIL
// =====================================================

class PasswordDetailScreen extends StatefulWidget {
  const PasswordDetailScreen({super.key});

  @override
  State<PasswordDetailScreen> createState() =>
      _PasswordDetailScreenState();
}

class _PasswordDetailScreenState
    extends State<PasswordDetailScreen> {
  bool obscure = true;

  @override
  Widget build(BuildContext context) {
    return DetailPage(
      title: 'PasswordField',
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(30),
          child: TextField(
            obscureText: obscure,
            decoration: InputDecoration(
              hintText: 'Nhập mật khẩu',
              border: const OutlineInputBorder(),
              suffixIcon: IconButton(
                icon: Icon(
                  obscure ? Icons.visibility : Icons.visibility_off,
                ),
                onPressed: () {
                  setState(() {
                    obscure = !obscure;
                  });
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}

// =====================================================
// 7. COLUMN DETAIL
// =====================================================

class ColumnDetailScreen extends StatelessWidget {
  const ColumnDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DetailPage(
      title: 'Column Layout',
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: List.generate(
            4,
            (index) => Container(
              width: 100,
              height: 65,
              margin: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: index.isEven ? boxBlue : darkBlue,
                borderRadius: BorderRadius.circular(12),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

// =====================================================
// 8. ROW LAYOUT
// =====================================================

class RowDetailScreen extends StatelessWidget {
  const RowDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DetailPage(
      title: 'Row Layout',
      child: Center(
        child: Container(
          margin: const EdgeInsets.all(14),
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            border: Border.all(
              color: primaryBlue,
              width: 2,
            ),
            color: const Color(0xFFFAFAFA),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: List.generate(
              4,
              (_) => Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: List.generate(
                    3,
                    (index) => Container(
                      width: 83,
                      height: 83,
                      decoration: BoxDecoration(
                        color: index == 1 ? darkBlue : boxBlue,
                        borderRadius: BorderRadius.circular(13),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
