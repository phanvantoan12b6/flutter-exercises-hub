// ignore_for_file: prefer_const_constructors, library_private_types_in_public_api

import 'package:flutter/material.dart';

// Import các bài tập
import 'exercises/ex01_classroom_ui.dart';
import 'exercises/ex02_travel_ui.dart';
import 'exercises/ex03_countdown_timer.dart';
import 'exercises/ex04_counter_app.dart';
import 'exercises/ex05_change_color.dart';
import 'exercises/ex06_register_form.dart';
import 'exercises/ex07_login_form.dart';
import 'exercises/ex08_bmi_calculator.dart';
import 'exercises/ex09_feedback_form.dart';
import 'exercises/ex10_product_list.dart';
import 'exercises/ex11_ecommerce/screens/product_list_screen.dart';
import 'exercises/ex12_login_profile.dart';

void main() {
  runApp(const FlutterExercisesHub());
}

class FlutterExercisesHub extends StatelessWidget {
  const FlutterExercisesHub({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Exercises Hub',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.blue,
          brightness: Brightness.light,
        ),
      ),
      darkTheme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.blue,
          brightness: Brightness.dark,
        ),
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int? selectedExerciseIndex;
  bool isSidebarExpanded = true;

  final List<Exercise> exercises = [
    Exercise(
      id: 1,
      title: 'Google Classroom UI',
      description: 'Giao diện lớp học với gradient và custom art',
      icon: Icons.school,
      difficulty: 'Trung bình',
      color: Colors.deepPurple,
    ),
    Exercise(
      id: 2,
      title: 'Travel/Places UI',
      description: 'Giao diện du lịch với saved places',
      icon: Icons.place,
      difficulty: 'Dễ',
      color: Colors.blue,
    ),
    Exercise(
      id: 3,
      title: 'Countdown Timer',
      description: 'Bộ đếm ngược thời gian',
      icon: Icons.timer,
      difficulty: 'Dễ',
      color: Colors.orange,
    ),
    Exercise(
      id: 4,
      title: 'Counter App',
      description: 'Ứng dụng đếm số với màu động',
      icon: Icons.add_circle_outline,
      difficulty: 'Dễ',
      color: Colors.green,
    ),
    Exercise(
      id: 5,
      title: 'Change Color',
      description: 'Đổi màu nền ngẫu nhiên',
      icon: Icons.color_lens,
      difficulty: 'Dễ',
      color: Colors.purple,
    ),
    Exercise(
      id: 6,
      title: 'Register Form',
      description: 'Form đăng ký với validation',
      icon: Icons.person_add,
      difficulty: 'Trung bình',
      color: Colors.indigo,
    ),
    Exercise(
      id: 7,
      title: 'Login Form',
      description: 'Form đăng nhập đơn giản',
      icon: Icons.login,
      difficulty: 'Dễ',
      color: Colors.cyan,
    ),
    Exercise(
      id: 8,
      title: 'BMI Calculator',
      description: 'Tính chỉ số cân nặng BMI',
      icon: Icons.calculate,
      difficulty: 'Dễ',
      color: Colors.teal,
    ),
    Exercise(
      id: 9,
      title: 'Feedback Form',
      description: 'Form góp ý với rating',
      icon: Icons.feedback,
      difficulty: 'Trung bình',
      color: Colors.deepOrange,
    ),
    Exercise(
      id: 10,
      title: 'Product List',
      description: 'Danh sách sản phẩm với GridView',
      icon: Icons.shopping_bag,
      difficulty: 'Trung bình',
      color: Colors.pink,
    ),
    Exercise(
      id: 11,
      title: 'E-Commerce App',
      description: 'Ứng dụng bán hàng hoàn chỉnh với API',
      icon: Icons.store,
      difficulty: 'Khó',
      color: Colors.red,
    ),
    Exercise(
      id: 12,
      title: 'Login + Profile',
      description: 'Đăng nhập và trang cá nhân với animation',
      icon: Icons.account_circle,
      difficulty: 'Khó',
      color: Colors.deepPurple,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          // Sidebar
          AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            width: isSidebarExpanded ? 280 : 70,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Theme.of(context).colorScheme.primaryContainer,
                  Theme.of(context).colorScheme.secondaryContainer,
                ],
              ),
            ),
            child: Column(
              children: [
                _buildSidebarHeader(),
                const Divider(height: 1),
                Expanded(
                  child: ListView.builder(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    itemCount: exercises.length,
                    itemBuilder: (context, index) {
                      return _buildExerciseItem(exercises[index], index);
                    },
                  ),
                ),
                _buildToggleButton(),
              ],
            ),
          ),
          // Main Content
          Expanded(
            child: selectedExerciseIndex == null
                ? _buildWelcomeScreen()
                : _buildExerciseScreen(exercises[selectedExerciseIndex!]),
          ),
        ],
      ),
    );
  }

  Widget _buildSidebarHeader() {
    return Container(
      padding: const EdgeInsets.all(20),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 8,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: const Icon(
              Icons.flutter_dash,
              color: Colors.blue,
              size: 28,
            ),
          ),
          if (isSidebarExpanded) ...[
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Flutter Hub',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).colorScheme.onPrimaryContainer,
                    ),
                  ),
                  Text(
                    '${exercises.length} bài tập',
                    style: TextStyle(
                      fontSize: 12,
                      color: Theme.of(context)
                          .colorScheme
                          .onPrimaryContainer
                          .withOpacity(0.7),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildExerciseItem(Exercise exercise, int index) {
    final isSelected = selectedExerciseIndex == index;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () {
            setState(() {
              selectedExerciseIndex = index;
            });
          },
          borderRadius: BorderRadius.circular(12),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: isSelected
                  ? Colors.white.withOpacity(0.9)
                  : Colors.transparent,
              borderRadius: BorderRadius.circular(12),
              boxShadow: isSelected
                  ? [
                      BoxShadow(
                        color: exercise.color.withOpacity(0.3),
                        blurRadius: 8,
                        offset: const Offset(0, 2),
                      ),
                    ]
                  : [],
            ),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: exercise.color.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Icon(
                    exercise.icon,
                    color: exercise.color,
                    size: 24,
                  ),
                ),
                if (isSidebarExpanded) ...[
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          exercise.title,
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: isSelected
                                ? exercise.color
                                : Theme.of(context)
                                    .colorScheme
                                    .onPrimaryContainer,
                          ),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          exercise.difficulty,
                          style: TextStyle(
                            fontSize: 11,
                            color: isSelected
                                ? exercise.color.withOpacity(0.7)
                                : Theme.of(context)
                                    .colorScheme
                                    .onPrimaryContainer
                                    .withOpacity(0.6),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildToggleButton() {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: IconButton(
        onPressed: () {
          setState(() {
            isSidebarExpanded = !isSidebarExpanded;
          });
        },
        icon: Icon(
          isSidebarExpanded ? Icons.chevron_left : Icons.chevron_right,
          color: Theme.of(context).colorScheme.onPrimaryContainer,
        ),
        style: IconButton.styleFrom(
          backgroundColor: Colors.white.withOpacity(0.2),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      ),
    );
  }

  Widget _buildWelcomeScreen() {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Theme.of(context).colorScheme.surface,
            Theme.of(context).colorScheme.surfaceVariant,
          ],
        ),
      ),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(32),
              decoration: BoxDecoration(
                color: Colors.blue.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.code,
                size: 100,
                color: Colors.blue,
              ),
            ),
            const SizedBox(height: 32),
            Text(
              'Chào mừng đến Flutter Exercises Hub',
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: Theme.of(context).colorScheme.onSurface,
              ),
            ),
            const SizedBox(height: 16),
            Text(
              'Chọn một bài tập từ sidebar để bắt đầu',
              style: TextStyle(
                fontSize: 16,
                color: Theme.of(context).colorScheme.onSurface.withOpacity(0.7),
              ),
            ),
            const SizedBox(height: 48),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _buildStatCard(
                    'Tổng bài tập', '${exercises.length}', Icons.assignment),
                const SizedBox(width: 24),
                _buildStatCard('Đã hoàn thành', '12/${exercises.length}',
                    Icons.check_circle_outline),
                const SizedBox(width: 24),
                _buildStatCard('Độ khó', 'Đa dạng', Icons.trending_up),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatCard(String label, String value, IconData icon) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 20,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          Icon(icon, size: 32, color: Colors.blue),
          const SizedBox(height: 12),
          Text(
            value,
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.blue,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey[600],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildExerciseScreen(Exercise exercise) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            exercise.color.withOpacity(0.05),
            Colors.white,
          ],
        ),
      ),
      child: Column(
        children: [
          // Header with back button
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 10,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Row(
              children: [
                IconButton(
                  onPressed: () {
                    setState(() {
                      selectedExerciseIndex = null;
                    });
                  },
                  icon: const Icon(Icons.arrow_back),
                  style: IconButton.styleFrom(
                    backgroundColor: exercise.color.withOpacity(0.1),
                    foregroundColor: exercise.color,
                  ),
                ),
                const SizedBox(width: 16),
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: exercise.color.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(
                    exercise.icon,
                    color: exercise.color,
                    size: 28,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        exercise.title,
                        style: const TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        exercise.description,
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey[600],
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 8,
                  ),
                  decoration: BoxDecoration(
                    color: exercise.color.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    exercise.difficulty,
                    style: TextStyle(
                      color: exercise.color,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
          ),
          // Exercise content
          Expanded(
            child: _getExerciseWidget(exercise.id),
          ),
        ],
      ),
    );
  }

  Widget _getExerciseWidget(int id) {
    switch (id) {
      case 1:
        return ClassroomListScreen();
      case 2:
        return TravelHomeScreen();
      case 3:
        return CountdownTimerPage();
      case 4:
        return CounterPage();
      case 5:
        return ChangeColorPage();
      case 6:
        return RegisterForm();
      case 7:
        return LoginForm();
      case 8:
        return BmiPage();
      case 9:
        return FeedbackForm();
      case 10:
        return ProductPage();
      case 11:
        return ProductListScreen();
      case 12:
        return LoginProfileApp();
      default:
        return Center(child: Text('Bài tập không tồn tại'));
    }
  }
}

// Models
class Exercise {
  final int id;
  final String title;
  final String description;
  final IconData icon;
  final String difficulty;
  final Color color;

  Exercise({
    required this.id,
    required this.title,
    required this.description,
    required this.icon,
    required this.difficulty,
    required this.color,
  });
}
