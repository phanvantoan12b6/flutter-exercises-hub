import 'package:flutter/material.dart';
import 'dart:math' as math;

enum ArtType { medal, book, cap }

class ClassItem {
  final String title;
  final String subTitle;
  final String studentCount;
  final List<Color> gradientColors;
  final ArtType artType;

  ClassItem({
    required this.title,
    required this.subTitle,
    required this.studentCount,
    required this.gradientColors,
    required this.artType,
  });
}

class ClassroomListScreen extends StatelessWidget {
  const ClassroomListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final List<ClassItem> classes = [
      ClassItem(
        title: "XML và ứng dụng - Nhóm 1",
        subTitle: "2025-2026.1.TIN4583.001",
        studentCount: "58 học viên",
        gradientColors: [const Color(0xFF37474F), const Color(0xFF263238)],
        artType: ArtType.medal,
      ),
      ClassItem(
        title: "Lập trình ứng dụng cho các thiết bị di động",
        subTitle: "2025-2026.1.TIN4403.006",
        studentCount: "55 học viên",
        gradientColors: [const Color(0xFF37474F), const Color(0xFF263238)],
        artType: ArtType.book,
      ),
      ClassItem(
        title: "Lập trình ứng dụng cho các thiết bị di động",
        subTitle: "2025-2026.1.TIN4403.005",
        studentCount: "52 học viên",
        gradientColors: [const Color(0xFF37474F), const Color(0xFF263238)],
        artType: ArtType.book,
      ),
      ClassItem(
        title: "Lập trình ứng dụng cho các thiết bị di động",
        subTitle: "2025-2026.1.TIN4403.004",
        studentCount: "50 học viên",
        gradientColors: [const Color(0xFF1976D2), const Color(0xFF0D47A1)],
        artType: ArtType.cap,
      ),
      ClassItem(
        title: "Lập trình ứng dụng cho các thiết bị di động",
        subTitle: "2025-2026.1.TIN4403.003",
        studentCount: "52 học viên",
        gradientColors: [const Color(0xFF37474F), const Color(0xFF263238)],
        artType: ArtType.medal,
      ),
    ];

    return Scaffold(
      body: SafeArea(
        child: ListView.separated(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 12),
          itemCount: classes.length,
          separatorBuilder: (context, index) => const SizedBox(height: 10),
          itemBuilder: (context, index) {
            return ClassCard(item: classes[index]);
          },
        ),
      ),
    );
  }
}

class ClassCard extends StatelessWidget {
  final ClassItem item;

  const ClassCard({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 175,
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        gradient: LinearGradient(
          colors: item.gradientColors,
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(8),
        child: Stack(
          children: [
            Positioned(right: 12, bottom: 12, child: _buildArt(item.artType)),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Text(
                          item.title,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 23,
                            height: 1.15,
                            fontWeight: FontWeight.w400,
                          ),
                          maxLines: 3,
                          overflow: TextOverflow.visible,
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.only(left: 8.0),
                        child: Icon(
                          Icons.more_horiz,
                          color: Colors.white,
                          size: 30,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 6),
                  Text(
                    item.subTitle,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 15,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  const Spacer(),
                  Text(
                    item.studentCount,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 13,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildArt(ArtType type) {
    switch (type) {
      case ArtType.book:
        return Transform.rotate(
          angle: -0.2,
          child: Container(
            width: 100,
            height: 120,
            decoration: BoxDecoration(
              color: const Color(0xFFE57373).withOpacity(0.9),
              borderRadius: BorderRadius.circular(6),
              boxShadow: const [
                BoxShadow(color: Colors.black12, blurRadius: 4),
              ],
            ),
            child: Stack(
              children: [
                Positioned(
                  left: 10,
                  top: 0,
                  bottom: 0,
                  child: Container(width: 4, color: Colors.white24),
                ),
                const Center(
                  child: Icon(
                    Icons.auto_stories,
                    color: Colors.white30,
                    size: 50,
                  ),
                ),
              ],
            ),
          ),
        );

      case ArtType.medal:
        return SizedBox(
          width: 140,
          height: 140,
          child: Stack(
            alignment: Alignment.center,
            children: [
              Positioned(
                right: 15,
                bottom: -10,
                child: Transform.rotate(
                  angle: -0.4,
                  child: Container(
                    width: 40,
                    height: 100,
                    color: Colors.white10,
                  ),
                ),
              ),
              Positioned(
                right: -5,
                bottom: -20,
                child: Container(
                  width: 110,
                  height: 110,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: const Color(0xFFFFD54F).withOpacity(0.15),
                    border: Border.all(color: Colors.white12, width: 1.5),
                  ),
                  child: const Center(
                    child: Icon(
                      Icons.emoji_events,
                      size: 70,
                      color: Color(0x55FFCA28),
                    ),
                  ),
                ),
              ),
            ],
          ),
        );

      case ArtType.cap:
        return Transform.rotate(
          angle: -0.2,
          child: const Opacity(
            opacity: 0.2,
            child: Icon(Icons.school, size: 140, color: Colors.white),
          ),
        );
    }
  }
}
