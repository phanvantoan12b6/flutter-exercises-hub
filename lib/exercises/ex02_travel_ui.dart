import 'package:flutter/material.dart';

class TravelHomeScreen extends StatelessWidget {
  const TravelHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    const borderColor = Color(0xFF2B60E6);

    return Scaffold(
      backgroundColor: Colors.grey[200],
      body: SafeArea(
        child: Center(
          child: Container(
            width: 360,
            margin: const EdgeInsets.symmetric(vertical: 12),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(28),
              boxShadow: const [
                BoxShadow(
                  color: Colors.black12,
                  blurRadius: 12,
                  offset: Offset(0, 6),
                ),
              ],
            ),
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Thanh trạng thái (giờ, wifi, pin)
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: const [
                      Text("09:09", style: TextStyle(fontSize: 16)),
                      Row(
                        children: [
                          Icon(Icons.wifi, size: 18),
                          SizedBox(width: 6),
                          Icon(Icons.battery_full, size: 18),
                        ],
                      ),
                    ],
                  ),

                  // Hàng icon chuông và dù
                  const SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      const Icon(Icons.notifications_none, size: 20),
                      const SizedBox(width: 10),
                      Transform.rotate(
                        angle: 3.1416,
                        child: const Icon(Icons.umbrella, size: 20),
                      ),
                    ],
                  ),

                  const SizedBox(height: 18),

                  // Welcome, Charlie
                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: borderColor, width: 2),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    padding: const EdgeInsets.fromLTRB(12, 12, 12, 14),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        Text(
                          'Welcome,',
                          style: TextStyle(
                            fontSize: 32,
                            fontWeight: FontWeight.w800,
                            color: Colors.black,
                          ),
                        ),
                        SizedBox(height: 6),
                        Text(
                          'Charlie',
                          style: TextStyle(
                            fontSize: 32,
                            fontWeight: FontWeight.w700,
                            color: Colors.black54,
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 18),

                  // Ô tìm kiếm
                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: borderColor, width: 2),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    padding: const EdgeInsets.all(10),
                    child: Container(
                      decoration: BoxDecoration(
                        color: const Color(0xFFF2F2F2),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: const TextField(
                        decoration: InputDecoration(
                          hintText: 'Search',
                          prefixIcon: Icon(
                            Icons.search,
                            color: Colors.blueAccent,
                          ),
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.symmetric(vertical: 14),
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 18),

                  // Saved Places
                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: borderColor, width: 2),
                      borderRadius: BorderRadius.circular(6),
                    ),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 6,
                    ),
                    child: const Text(
                      'Saved Places',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),

                  const SizedBox(height: 12),

                  // Lưới 2 cột với ảnh địa điểm
                  GridView.count(
                    crossAxisCount: 2,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    crossAxisSpacing: 12,
                    mainAxisSpacing: 12,
                    childAspectRatio: 1.25,
                    children: const [
                      _PlaceTile(
                        imageUrl:
                            'https://images.unsplash.com/photo-1528164344705-47542687000d?w=400',
                        label: 'Japan',
                      ),
                      _PlaceTile(
                        imageUrl:
                            'https://images.unsplash.com/photo-1467269204594-9661b134dd2b?w=400',
                        label: 'Prague',
                      ),
                      _PlaceTile(
                        imageUrl:
                            'https://images.unsplash.com/photo-1534008897995-27a23e859048?w=400',
                        label: 'Santorini',
                      ),
                      _PlaceTile(
                        imageUrl:
                            'https://images.unsplash.com/photo-1552832230-c0197dd311b5?w=400',
                        label: 'Rome',
                      ),
                    ],
                  ),

                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _PlaceTile extends StatelessWidget {
  final String imageUrl;
  final String label;

  const _PlaceTile({required this.imageUrl, required this.label});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFF2B60E6), width: 2),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: Stack(
          fit: StackFit.expand,
          children: [
            Image.network(
              imageUrl,
              fit: BoxFit.cover,
              loadingBuilder: (context, child, loadingProgress) {
                if (loadingProgress == null) return child;
                return Container(
                  color: Colors.grey[300],
                  child: const Center(
                    child: CircularProgressIndicator(),
                  ),
                );
              },
              errorBuilder: (context, error, stackTrace) {
                return Container(
                  color: Colors.grey[300],
                  child: const Icon(Icons.image_not_supported, size: 40),
                );
              },
            ),
            Positioned(
              bottom: 8,
              left: 8,
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 8,
                  vertical: 4,
                ),
                decoration: BoxDecoration(
                  color: Colors.black54,
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Text(
                  label,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
