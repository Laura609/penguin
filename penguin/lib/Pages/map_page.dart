import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:penguin/Widgets/app_bar_widget.dart';
import 'package:penguin/Widgets/bottom_bar_widget.dart';
import 'package:photo_view/photo_view.dart';

@RoutePage()
class MapPage extends StatefulWidget {
  const MapPage({super.key});

  @override
  State<MapPage> createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  final List<MapMarker> markers = [
    MapMarker(
      position: const Offset(0.1, 0.34),
      address: "г. Донской, ул. Терпигорева, д. 15Б",
    ),
    MapMarker(
      position: const Offset(0.2, 0.35),
      address: "г. Донской, ул. 30 лет Победы, д. 4",
    ),
    MapMarker(
      position: const Offset(0.53, 0.55),
      address: "Руднев, ул. Октябрьская, д. 15В",
    ),
    MapMarker(
      position: const Offset(0.84, 0.26),
      address: "Алексеевка, ул. Заводская, д. 15 ",
    ),
    MapMarker(
      position: const Offset(0.87, 0.35),
      address: "г. Кимовск, ул. Стадионная, д. 24",
    ),
  ];

  int? selectedMarkerIndex;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 255, 255, 255),
      appBar: const AppBarWidget(
        leftText: 'ПУНКТЫ',
        rightText: 'ДОСТАВКИ',
        showSignOutButton: false,
      ),
      body: Stack(
        children: [
          PhotoView(
            imageProvider: const AssetImage("assets/map.png"),
            minScale: PhotoViewComputedScale.contained,
            maxScale: PhotoViewComputedScale.covered * 2,
            initialScale: PhotoViewComputedScale.contained,
            backgroundDecoration: const BoxDecoration(color: Colors.white),
          ),
          // Маркеры на карте
          ...markers.asMap().entries.map((entry) {
            final index = entry.key;
            final marker = entry.value;
            final isSelected = selectedMarkerIndex == index;

            final mediaQuery = MediaQuery.of(context);
            final screenWidth = mediaQuery.size.width;
            final screenHeight = mediaQuery.size.height;

            final markerX = marker.position.dx * screenWidth;
            final markerY = marker.position.dy * screenHeight;

            // Размеры контейнера с адресом
            final infoWidth = 160.0;
            final infoHeight = 30.0;

            // Проверяем, не выходит ли подсказка за правую границу
            final isOverflowingRight = (markerX + 45 + infoWidth) > screenWidth;

            double infoLeft =
                isOverflowingRight
                    ? markerX -
                        infoWidth -
                        0 // слева от маркера
                    : markerX + 35; // справа от маркера

            double infoTop = markerY - (infoHeight / 1.4);

            // Ограничиваем по вертикали, чтобы не уйти за верх/низ экрана
            infoTop = infoTop.clamp(0.0, screenHeight - infoHeight);

            return Stack(
              children: [
                if (isSelected)
                  Positioned(
                    left: infoLeft,
                    top: infoTop,
                    child: _buildMarkerInfo(marker),
                  ),
                // Маркер
                Positioned(
                  left: markerX,
                  top: markerY,
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        selectedMarkerIndex = isSelected ? null : index;
                      });
                    },
                    child: Opacity(
                      opacity: isSelected ? 1.0 : 0.6,
                      child: Image.asset(
                        'assets/btn3.png',
                        width: 40,
                        height: 40,
                      ),
                    ),
                  ),
                ),
              ],
            );
          }),
        ],
      ),
      bottomNavigationBar: const BottomNavBar(),
    );
  }

  Widget _buildMarkerInfo(MapMarker marker) {
    return Container(
      width: 160,
      height: 30,
      padding: const EdgeInsets.symmetric(vertical: 9),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            blurRadius: 6,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 7),
            child: Text(
              marker.address,
              style: const TextStyle(fontSize: 8, color: Colors.black87),
            ),
          ),
        ],
      ),
    );
  }
}

class MapMarker {
  final Offset position;
  final String address;

  const MapMarker({required this.position, required this.address});
}
