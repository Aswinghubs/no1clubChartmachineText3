import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // TRY THIS: Try running your application with "flutter run". You'll see
        // the application has a purple toolbar. Then, without quitting the app,
        // try changing the seedColor in the colorScheme below to Colors.green
        // and then invoke "hot reload" (save your changes or press the "hot
        // reload" button in a Flutter-supported IDE, or press "r" if you used
        // the command line to start the app).
        //
        // Notice that the counter didn't reset back to zero; the application
        // state is not lost during the reload. To reset the state, use hot
        // restart instead.
        //
        // This works for code too, not just values: Most code changes can be
        // tested with just a hot reload.
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      debugShowCheckedModeBanner: false,
      home: const ChartScreen(),
    );
  }
}

class ChartScreen extends StatelessWidget {
  const ChartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: const Color(0xFFEFEFEF),
      body: Center(
        child: Container(
          width: size.width * 0.9,
          padding: EdgeInsets.all(size.width * 0.06),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(size.width * 0.08),
            boxShadow: const [
              BoxShadow(
                color: Colors.white,
                offset: Offset(-8, -8),
                blurRadius: 20,
              ),
              BoxShadow(
                color: Colors.black12,
                offset: Offset(8, 8),
                blurRadius: 20,
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Purchase breakup by year",
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: size.height * 0.05),
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Expanded(
                    child: Stack(
                      alignment: Alignment.bottomCenter,
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            _buildYAxisRow(size, "50M"),
                            SizedBox(height: size.height * 0.07),
                            _buildYAxisRow(size, "10M"),
                            SizedBox(height: size.height * 0.07),
                            _buildYAxisRow(size, "5M"),
                            SizedBox(height: size.height * 0.07),
                            _buildYAxisRow(size, "1M"),
                            SizedBox(height: size.height * 0.07),
                            _buildYAxisRow(size, "1L"),
                            SizedBox(height: size.height * 0.12),
                          ],
                        ),

                        Padding(
                          padding: const EdgeInsets.only(left: 45, bottom: 20),
                          child: const ChartBars(),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(height: size.height * 0.05),
            ],
          ),
        ),
      ),
    );
  }
}

Widget _buildYAxisRow(Size size, String label) {
  return Row(
    children: [
      SizedBox(width: 35, child: YAxisLabel(label: label)),
      const SizedBox(width: 10),
      Expanded(
        child: CustomPaint(
          size: const Size(double.infinity, 1),
          painter: DashedLinePainter(),
        ),
      ),
    ],
  );
}

class DashedLinePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    double dashWidth = 5, dashSpace = 3, startX = 0;
    final paint = Paint()
      ..color = Colors.black12
      ..strokeWidth = 1;
    while (startX < size.width) {
      canvas.drawLine(Offset(startX, 0), Offset(startX + dashWidth, 0), paint);
      startX += dashWidth + dashSpace;
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}

class YAxisLabel extends StatelessWidget {
  final String label;

  const YAxisLabel({super.key, required this.label});

  @override
  Widget build(BuildContext context) {
    return Text(
      label,
      style: const TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w400,
        color: Colors.black,
      ),
    );
  }
}

class ChartBars extends StatelessWidget {
  const ChartBars({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    double chartHeight = size.height * 0.35;

    return Stack(
      alignment: Alignment.bottomCenter,
      children: [
        Positioned(
          bottom: chartHeight * 0.2,
          child: Container(
            width: size.width * 0.65,
            height: chartHeight * 0.2,
            decoration: BoxDecoration(
              boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.1))],
              borderRadius: const BorderRadius.all(Radius.elliptical(500, 150)),
            ),
          ),
        ),

        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            YearColumn(
              year: "2018",
              heights: [
                chartHeight * 0.27,
                chartHeight * 0.26,
                chartHeight * 0.28,
              ],
              colors: const [
                Color(0xFF7B8CDE),
                Color(0xFF8B5CF6),
                Color.fromARGB(255, 179, 235, 255),
              ],
            ),
            YearColumn(
              year: "2019",
              heights: [
                chartHeight * 0.32,
                chartHeight * 0.34,
                chartHeight * 0.32,
              ],
              colors: const [
                Color(0xFF7B8CDE),
                Color(0xFF8B5CF6),
                Color.fromARGB(255, 179, 235, 255),
              ],
            ),
            YearColumn(
              year: "2020",
              heights: [
                chartHeight * 0.39,
                chartHeight * 0.3,
                chartHeight * 0.4,
              ],
              colors: const [
                Color(0xFF7B8CDE),
                Color(0xFF8B5CF6),
                Color.fromARGB(255, 179, 235, 255),
              ],
            ),
          ],
        ),
      ],
    );
  }
}

class YearColumn extends StatelessWidget {
  final String year;
  final List<double> heights;
  final List<Color> colors;

  const YearColumn({
    super.key,
    required this.year,
    required this.heights,
    required this.colors,
  });

  @override
  Widget build(BuildContext context) {
    const double cubeWidth = 35.0;
    const double cubeDepth = 15.0;
    const double overlapOffset = cubeDepth * 0.6;

    double totalStackedHeight = 0;
    for (var h in heights) {
      totalStackedHeight += (h + (cubeDepth - overlapOffset));
    }
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        SizedBox(
          height: totalStackedHeight + cubeDepth,
          width: cubeWidth + cubeDepth,
          child: Stack(
            alignment: Alignment.bottomCenter,
            children: List.generate(heights.length, (index) {
              double bottomOffset = 0;
              for (int i = 0; i < index; i++) {
                bottomOffset += (heights[i] + cubeDepth - overlapOffset);
              }

              return Positioned(
                bottom: bottomOffset,
                child: IsometricCube(
                  height: heights[index],
                  color: colors[index],
                  width: cubeWidth,
                  depth: cubeDepth,
                ),
              );
            }),
          ),
        ),

        const SizedBox(height: 35),

        Text(
          year,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
        ),
      ],
    );
  }
}

class IsometricCube extends StatelessWidget {
  final double height;
  final Color color;
  final double width;
  final double depth;

  const IsometricCube({
    super.key,
    required this.height,
    required this.color,
    required this.width,
    required this.depth,
  });

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: Size(width + depth, height + depth),
      painter: CubePainter(
        baseColor: color,
        height: height,
        perspective: depth,
      ),
    );
  }
}

class CubePainter extends CustomPainter {
  final Color baseColor;
  final double height;
  final double perspective;

  CubePainter({
    required this.baseColor,
    required this.height,
    required this.perspective,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..style = PaintingStyle.fill;

    final Color topColor = Color.lerp(baseColor, Colors.white, 0.25)!;
    final Color leftColor = Color.lerp(baseColor, Colors.black, 0.05)!;
    final Color rightColor = baseColor;
    double centerX = size.width / 2;
    double topY = perspective / 2;

    paint.color = leftColor;
    final leftPath = Path()
      ..moveTo(centerX, topY)
      ..lineTo(0, 0)
      ..lineTo(0, height)
      ..lineTo(centerX, height + topY)
      ..close();
    canvas.drawPath(leftPath, paint);

    paint.color = rightColor;
    final rightPath = Path()
      ..moveTo(centerX, topY)
      ..lineTo(size.width, 0)
      ..lineTo(size.width, height)
      ..lineTo(centerX, height + topY)
      ..close();
    canvas.drawPath(rightPath, paint);

    paint.color = topColor;
    final topPath = Path()
      ..moveTo(centerX, topY)
      ..lineTo(0, 0)
      ..lineTo(centerX, -topY)
      ..lineTo(size.width, 0)
      ..close();
    canvas.drawPath(topPath, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

Widget buildBar(double height, Color color, double width, double depth) {
  return SizedBox(
    width: width + depth,
    height: height + depth * 0.5,
    child: Stack(
      children: [
        Positioned(
          left: depth,
          bottom: 0,
          child: Container(width: width, height: height, color: color),
        ),

        Positioned(
          left: 0,
          bottom: depth * 0.5,
          child: CustomPaint(
            size: Size(depth, height),
            painter: LeftFacePainter(
              color: color.withOpacity(0.7),
              height: height,
              depth: depth,
            ),
          ),
        ),

        Positioned(
          left: 0,
          top: 0,
          child: CustomPaint(
            size: Size(width + depth, depth * 0.5),
            painter: TopFacePainter(
              color: color.withOpacity(0.9),
              width: width,
              depth: depth,
            ),
          ),
        ),
      ],
    ),
  );
}

class LeftFacePainter extends CustomPainter {
  final Color color;
  final double height;
  final double depth;

  LeftFacePainter({
    required this.color,
    required this.height,
    required this.depth,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;

    final path = Path();
    path.moveTo(depth, depth * 0.5);
    path.lineTo(0, 0);
    path.lineTo(0, height);
    path.lineTo(depth, height + depth * 0.5);
    path.close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class TopFacePainter extends CustomPainter {
  final Color color;
  final double width;
  final double depth;

  TopFacePainter({
    required this.color,
    required this.width,
    required this.depth,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;

    final path = Path();
    path.moveTo(depth, depth * 0.5);
    path.lineTo(0, 0);
    path.lineTo(width, 0);
    path.lineTo(width + depth, depth * 0.5);
    path.close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
