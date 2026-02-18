import 'package:flutter/material.dart';
import 'package:no12ndmachinetest/ViewPage/widget.dart';

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
                            buildYAxisRow(size, "50M"),
                            SizedBox(height: size.height * 0.07),
                            buildYAxisRow(size, "10M"),
                            SizedBox(height: size.height * 0.07),
                            buildYAxisRow(size, "5M"),
                            SizedBox(height: size.height * 0.07),
                            buildYAxisRow(size, "1M"),
                            SizedBox(height: size.height * 0.07),
                            buildYAxisRow(size, "1L"),
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
