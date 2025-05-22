import 'package:flutter/material.dart';
import 'package:penguin/models/ice_cream_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class IceCreamCard extends StatefulWidget {
  final IceCream iceCream;

  const IceCreamCard({super.key, required this.iceCream});

  @override
  State<IceCreamCard> createState() => _IceCreamCardState();
}

class _IceCreamCardState extends State<IceCreamCard> {
  int? cartQuantity;
  bool _isDisposed = false;

  @override
  void initState() {
    super.initState();
    _checkCartQuantity();
  }

  @override
  void dispose() {
    _isDisposed = true;
    super.dispose();
  }

Future<void> _checkCartQuantity() async {
  final user = FirebaseAuth.instance.currentUser;
  if (user == null || _isDisposed) return;

  try {
    final DocumentSnapshot doc = await FirebaseFirestore.instance
        .collection('Users')
        .doc(user.email!)
        .collection('cart')
        .doc(widget.iceCream.name)
        .get();

    if (!mounted) return;

    setState(() {
      cartQuantity = doc.exists ? doc['quantity'] : 0;
    });
  } catch (e) {
    if (!mounted) return;
    debugPrint('Error checking cart quantity: $e');
  }
}

Future<void> _addToCart() async {
  final user = FirebaseAuth.instance.currentUser;
  if (user == null || _isDisposed) return;

  try {
    final docRef = FirebaseFirestore.instance
        .collection('Users')
        .doc(user.email!)
        .collection('cart')
        .doc(widget.iceCream.name);

    final doc = await docRef.get();

    if (doc.exists) {
      await docRef.update({
        'quantity': FieldValue.increment(1),
        'updated_at': FieldValue.serverTimestamp(),
      });
    } else {
      await docRef.set({
        'name': widget.iceCream.name,
        'price': widget.iceCream.price,
        'imageUrl': widget.iceCream.imageUrl,
        'quantity': 1,
        'added_at': FieldValue.serverTimestamp(),
      });
    }

    await _checkCartQuantity();

    if (!mounted) return;

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('${widget.iceCream.name} добавлено в корзину'),
        behavior: SnackBarBehavior.floating,
        duration: const Duration(seconds: 1),
      ),
    );
  } catch (e) {
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Ошибка: $e'),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }
}

Future<void> _removeFromCart() async {
  final user = FirebaseAuth.instance.currentUser;
  if (user == null || (cartQuantity ?? 0) <= 0 || _isDisposed) return;

  try {
    final docRef = FirebaseFirestore.instance
        .collection('Users')
        .doc(user.email!) // <-- Здесь заменяем uid на email
        .collection('cart')
        .doc(widget.iceCream.name);

    if (cartQuantity == 1) {
      await docRef.delete();
    } else {
      await docRef.update({
        'quantity': FieldValue.increment(-1),
        'updated_at': FieldValue.serverTimestamp(),
      });
    }

    await _checkCartQuantity();
  } catch (e) {
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Ошибка: $e'),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }
}

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 140,
      margin: const EdgeInsets.symmetric(horizontal: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 6,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
            child: Image.asset(
              widget.iceCream.imageUrl,
              height: 90,
              width: 140,
              fit: BoxFit.contain,
              errorBuilder: (_, __, ___) => Container(
                color: Colors.grey[200],
                height: 90,
                width: 140,
                child: const Icon(Icons.image_not_supported),
              ),
            ),
          ),
          const SizedBox(height: 5),
          Padding(
            padding: const EdgeInsets.all(8),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                SizedBox(
                  height: 36,
                  child: Center(
                    child: Text(
                      widget.iceCream.name,
                      style: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
                const SizedBox(height: 30),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '${widget.iceCream.price} руб.',
                      style: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Row(
                      children: [
                        if ((cartQuantity ?? 0) > 0) ...[
                          GestureDetector(
                            onTap: _removeFromCart,
                            child: Container(
                              width: 20,
                              height: 20,
                              decoration: BoxDecoration(
                                color: const Color.fromRGBO(84, 170, 242, 1),
                                borderRadius: BorderRadius.circular(4),
                              ),
                              child: const Icon(
                                Icons.remove,
                                size: 16,
                                color: Colors.white,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 4),
                            child: Text(
                              (cartQuantity ?? 0).toString(),
                              style: const TextStyle(
                                fontSize: 12,
                                color: Color.fromRGBO(84, 170, 242, 1),
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ],
                        GestureDetector(
                          onTap: _addToCart,
                          child: Container(
                            width: 20,
                            height: 20,
                            decoration: BoxDecoration(
                              color: const Color.fromRGBO(84, 170, 242, 1),
                              borderRadius: BorderRadius.circular(4),
                            ),
                            child: const Icon(
                              Icons.add,
                              size: 16,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}