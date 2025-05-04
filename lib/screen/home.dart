import 'dart:math';
import 'package:flutter/material.dart';

class home_screen extends StatefulWidget {
  const home_screen({super.key});

  @override
  State<home_screen> createState() => _home_screenState();
}

class _home_screenState extends State<home_screen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 10),
    )..repeat(); // Infinite rotation
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: const Color(0xFF1C1B22),
      appBar: AppBar(
        backgroundColor: const Color(0xFF1C1B22),
        elevation: 0,
        title: Padding(
          padding: EdgeInsets.all(height * 0.01),
          child: Row(
            children: [
              Text(
                "Raghav",
                style: TextStyle(
                  fontFamily: "ChivoMono",
                  color: Colors.white,
                  fontSize: height * 0.04,
                ),
              ),
              Text(
                " Baheti",
                style: TextStyle(
                  fontFamily: "ChivoMono",
                  color: const Color(0xFF06fb9a),
                  fontSize: height * 0.04,
                ),
              ),
            ],
          ),
        ),
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          bool isMobile = constraints.maxWidth < 600;
          return SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: width * 0.05),
            child: ConstrainedBox(
              constraints: BoxConstraints(minHeight: height * 0.8),
              child: isMobile
                  ? Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        _buildLeftSide(height, width, isMobile),
                        SizedBox(height: height * 0.05),
                        _buildRightSide(height),
                      ],
                    )
                  : Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Expanded(
                            flex: 2,
                            child: _buildLeftSide(height, width, isMobile)),
                        SizedBox(width: width * 0.05),
                        Expanded(flex: 1, child: _buildRightSide(height)),
                      ],
                    ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildLeftSide(double height, double width, bool isMobile) {
    return Column(
      crossAxisAlignment:
          isMobile ? CrossAxisAlignment.center : CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          "Software Developer",
          style: TextStyle(
            fontFamily: "ChivoMono",
            color: Colors.white,
            fontSize: height * 0.025,
          ),
        ),
        SizedBox(height: height * 0.01),
        Text(
          "Hello I’m",
          style: TextStyle(
            fontFamily: "ChivoMono",
            color: Colors.white,
            fontSize: height * 0.07,
          ),
        ),
        Text(
          "Raghav Baheti",
          style: TextStyle(
            fontFamily: "ChivoMono",
            color: const Color(0xFF06fb9a),
            fontSize: height * 0.07,
          ),
        ),
        SizedBox(height: height * 0.02),
        SizedBox(
          width: isMobile ? double.infinity : width * 0.5,
          child: Text(
            "Third-year B.Tech student at JECRC University, Jaipur. Proficient in creating scalable, user-centric applications using Flutter, Firebase, Java, Python, and MySQL.\n\nAdept at optimizing app performance, collaborating in cross-functional teams, and delivering projects ahead of schedule.\n\nPassionate about leveraging technology to solve real-world problems and enhance user experiences.",
            textAlign: isMobile ? TextAlign.center : TextAlign.start,
            style: TextStyle(
              fontFamily: "ChivoMono",
              color: Colors.white70,
              fontSize: height * 0.02,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildRightSide(double height) {
    return Center(
      child: Stack(
        alignment: Alignment.center,
        children: [
          CircleAvatar(
            radius: height * 0.2,
            backgroundImage: NetworkImage(
              "https://cdn.pixabay.com/photo/2021/12/30/11/02/cartoon-6903717_1280.png",
            ),
          ),
          SizedBox(
            width: height * 0.45,
            height: height * 0.45,
            child: AnimatedBuilder(
              animation: _controller,
              builder: (_, child) {
                return Transform.rotate(
                  angle: _controller.value * 2 * pi,
                  child: CustomPaint(
                    painter: DashedCirclePainter(),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class DashedCirclePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    const dashCount = 12;
    const dashLength = pi / 18;
    const strokeWidth = 2.0;

    final Paint paint = Paint()
      ..color = Colors.tealAccent
      ..strokeWidth = strokeWidth
      ..style = PaintingStyle.stroke;

    final double radius = size.width / 2;
    final Offset center = Offset(size.width / 2, size.height / 2);

    for (int i = 0; i < dashCount; i++) {
      final double startAngle = (2 * pi / dashCount) * i;
      canvas.drawArc(
        Rect.fromCircle(center: center, radius: radius),
        startAngle,
        dashLength,
        false,
        paint,
      );
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}
