import 'package:flutter/material.dart';

class AuthBackgorundC1 extends StatelessWidget {
  const AuthBackgorundC1({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Container(
      width: double.infinity,
      height: size.height * 0.4,
      decoration: _orangeDecoration(),
      child: Stack(
        children: const [
          Positioned(top: 90, left: 30, child: _Bubble()),
          Positioned(top: -40, left: -30, child: _Bubble()),
          Positioned(top: -50, right: -20, child: _Bubble()),
          Positioned(bottom: -50, left: -20, child: _Bubble()),
          Positioned(bottom: 120, right: 20, child: _Bubble()),
          Positioned(bottom: 20, right: 80, child: _Bubble()),
        ],
      ),
    );
  }

  BoxDecoration _orangeDecoration() => const BoxDecoration(
        gradient: LinearGradient(colors: [
          Color.fromRGBO(215, 165, 233, 1),
          Color.fromRGBO(83, 60, 87, 1),
        ]),
      );
}

class _Bubble extends StatelessWidget {
  const _Bubble();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100,
      height: 100,
      decoration: BoxDecoration(
        color: const Color.fromRGBO(255, 255, 255, 0.15),
        borderRadius: BorderRadius.circular(100),
      ),
    );
  }
}
