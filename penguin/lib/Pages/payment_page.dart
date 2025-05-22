import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:penguin/Widgets/app_bar_widget.dart';
import 'package:penguin/Widgets/bottom_bar_widget.dart';
import 'package:penguin/router/router.gr.dart';
import 'package:qr_flutter/qr_flutter.dart';

@RoutePage()
class PaymentPage extends StatefulWidget {
  const PaymentPage({super.key});

  @override
  State<PaymentPage> createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {
  final TextEditingController _addressController = TextEditingController();
  String? _selectedDeliveryPoint;

  String? userEmail;
  String? userFirstName;
  String? userPhone;
  String? userAddress;

  double totalPrice = 0.0;

  final List<MapMarker> deliveryPoints = [
    MapMarker(
      position: Offset(0.1, 0.34),
      address: "г. Донской, ул. Терпигорева, д. 15Б",
    ),
    MapMarker(
      position: Offset(0.2, 0.35),
      address: "г. Донской, ул. 30 лет Победы, д. 4",
    ),
    MapMarker(
      position: Offset(0.53, 0.55),
      address: "Руднев, ул. Октябрьская, д. 15В",
    ),
    MapMarker(
      position: Offset(0.84, 0.26),
      address: "Алексеевка, ул. Заводская, д. 15",
    ),
    MapMarker(
      position: Offset(0.87, 0.35),
      address: "г. Кимовск, ул. Стадионная, д. 24",
    ),
  ];

  @override
  void initState() {
    super.initState();
    _loadUserData();
    _loadCartTotal();
    _selectedDeliveryPoint = deliveryPoints.first.address;
  }

  Future<void> _loadUserData() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null || user.email == null) return;

    try {
      final DocumentSnapshot snapshot = await FirebaseFirestore.instance
          .collection('Users')
          .doc(user.email!)
          .get();

      if (snapshot.exists) {
        setState(() {
          userEmail = snapshot.get('email') ?? user.email;
          userFirstName = snapshot.get('first_name') ?? 'Не указано';
          userPhone = snapshot.get('phone') ?? 'Не указан';
          userAddress = snapshot.get('address') ?? '';
          _addressController.text = userAddress ?? '';
        });
      } else {
        setState(() {
          userEmail = 'Неизвестный пользователь';
          userFirstName = 'Гость';
          userPhone = 'Не указан';
        });
      }
    } catch (e) {
      debugPrint('Ошибка при загрузке данных пользователя: $e');
    }
  }

  Future<void> _loadCartTotal() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null || user.email == null) return;

    final QuerySnapshot cartSnapshot = await FirebaseFirestore.instance
        .collection('Users')
        .doc(user.email!)
        .collection('cart')
        .get();

    double total = 0.0;
    for (var doc in cartSnapshot.docs) {
      final data = doc.data() as Map<String, dynamic>;
      total += (data['price'] * data['quantity']);
    }

    setState(() {
      totalPrice = total;
    });
  }

  @override
  void dispose() {
    _addressController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final fixedHeight = screenWidth * 0.15;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const AppBarWidget(
        leftText: 'ОФОРМЛЕНИЕ',
        rightText: 'ЗАКАЗА',
        showSignOutButton: false,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: screenWidth * 0.06,
            vertical: screenHeight * 0.02,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(height: screenHeight * 0.02),
              Text(
                'Оплата заказа',
                style: TextStyle(
                  fontSize: screenWidth * 0.06,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: screenHeight * 0.02),

              // Первый ряд: ФИО и Email
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: _buildFixedHeightField(
                      label: 'Имя',
                      value: userFirstName ?? 'Не указано',
                      height: fixedHeight,
                      screenWidth: screenWidth,
                    ),
                  ),
                  SizedBox(width: screenWidth * 0.03),
                  Expanded(
                    child: _buildFixedHeightField(
                      label: 'Email',
                      value: userEmail ?? 'Не указан',
                      height: fixedHeight,
                      screenWidth: screenWidth,
                    ),
                  ),
                ],
              ),
              SizedBox(height: screenHeight * 0.015),

              // Второй ряд: Телефон и Пункт выдачи
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: _buildFixedHeightField(
                      label: 'Телефон',
                      value: userPhone ?? 'Не указан',
                      height: fixedHeight,
                      screenWidth: screenWidth,
                    ),
                  ),
                  SizedBox(width: screenWidth * 0.03),
                  Expanded(
                    child: SizedBox(
                      height: fixedHeight,
                      child: _buildDeliveryDropdown(screenWidth),
                    ),
                  ),
                ],
              ),
              SizedBox(height: screenHeight * 0.03),

              // QR-код
              Center(
                child: Container(
                  width: screenWidth * 0.6,
                  height: screenWidth * 0.6,
                  child: QrImageView(
                    data:
                        'Order ID: ${FirebaseAuth.instance.currentUser?.uid ?? 'unknown'}, Amount: ${totalPrice.toStringAsFixed(2)} руб.',
                    version: QrVersions.auto,
                    foregroundColor: Colors.blue,
                    eyeStyle: const QrEyeStyle(
                      eyeShape: QrEyeShape.square,
                      color: Colors.blue,
                    ),
                    embeddedImageStyle: QrEmbeddedImageStyle(
                      size: Size(screenWidth * 0.08, screenWidth * 0.08),
                    ),
                  ),
                ),
              ),
              SizedBox(height: screenHeight * 0.04),

              // Кнопка оплаты
              ElevatedButton(
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Переход к оплате...'),
                      duration: Duration(seconds: 3),
                    ),
                  );

                  Future.delayed(const Duration(seconds: 3), () {
                    context.router.pushAndPopUntil(
                      GradefulRoute(
                        selectedAddress: _selectedDeliveryPoint ?? deliveryPoints.first.address,
                      ),
                      predicate: (_) => false,
                    );
                  });
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromRGBO(84, 170, 242, 1),
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  padding: EdgeInsets.symmetric(vertical: screenHeight * 0.02),
                  minimumSize: Size(double.infinity, screenHeight * 0.06),
                ),
                child: FittedBox(
                  fit: BoxFit.scaleDown,
                  child: Text(
                    'Оплатить через приложение банка',
                    style: TextStyle(fontSize: screenWidth * 0.04),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: const BottomNavBar(),
    );
  }

  Widget _buildFixedHeightField({
    required String label,
    required String value,
    required double height,
    required double screenWidth,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: screenWidth * 0.035,
            color: Colors.grey,
          ),
        ),
        SizedBox(height: screenWidth * 0.01),
        Container(
          height: height - screenWidth * 0.05,
          width: double.infinity,
          padding: EdgeInsets.symmetric(
            horizontal: screenWidth * 0.04,
            vertical: screenWidth * 0.02,
          ),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey),
            borderRadius: BorderRadius.circular(8),
          ),
          child: SingleChildScrollView(
            physics: const NeverScrollableScrollPhysics(),
            child: Text(
              value,
              style: TextStyle(fontSize: screenWidth * 0.035),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildDeliveryDropdown(double screenWidth) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Пункт выдачи',
          style: TextStyle(
            fontSize: screenWidth * 0.035,
            color: Colors.grey,
          ),
        ),
        SizedBox(height: screenWidth * 0.01),
        Expanded(
          child: DropdownButtonFormField<String>(
            value: _selectedDeliveryPoint,
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              contentPadding: EdgeInsets.symmetric(
                horizontal: screenWidth * 0.04,
                vertical: screenWidth * 0.02,
              ),
              isDense: true,
            ),
            style: TextStyle(
              fontSize: screenWidth * 0.035,
              overflow: TextOverflow.ellipsis,
            ),
            selectedItemBuilder: (BuildContext context) {
              return deliveryPoints.map<Widget>((point) {
                return Text(
                  point.address,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: screenWidth * 0.035,
                    color: Colors.black,
                  ),
                );
              }).toList();
            },
            items: deliveryPoints.map((point) {
              return DropdownMenuItem<String>(
                value: point.address,
                child: Text(
                  point.address,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: screenWidth * 0.035,
                    color: Colors.black,
                  ),
                ),
              );
            }).toList(),
            onChanged: (value) {
              setState(() {
                _selectedDeliveryPoint = value;
              });
            },
            isExpanded: true,
          ),
        ),
      ],
    );
  }
}

class MapMarker {
  final Offset position;
  final String address;

  const MapMarker({required this.position, required this.address});
}