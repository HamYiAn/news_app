import 'package:flutter/material.dart';

class TroubleByAreaCard extends StatelessWidget {
  const TroubleByAreaCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            blurRadius: 10,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Trouble by-Area',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: Colors.grey[800],
            ),
          ),

          SizedBox(height: 16),

          Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(horizontal: 12, vertical: 10),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: Colors.grey[300]!),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Icon(
                      Icons.calendar_today_outlined,
                      color: Colors.grey[700],
                      size: 16,
                    ),
                    SizedBox(width: 8),
                    Text(
                      '9/09/2024 - 01/09/2024',
                      style: TextStyle(fontSize: 14, color: Colors.grey[800]),
                    ),
                  ],
                ),
                Icon(Icons.arrow_drop_down, color: Colors.grey[600], size: 20),
              ],
            ),
          ),

          SizedBox(height: 24),

          Container(
            padding: EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Color(0xFFF8F9FA),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Colors.grey[200]!),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Building Performance',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Colors.grey[800],
                  ),
                ),
                SizedBox(height: 16),

                Container(
                  height: 200,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Container(
                        width: 20,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: ['10', '8', '6', '4', '2', '0']
                              .map(
                                (label) => Text(
                                  label,
                                  style: TextStyle(
                                    fontSize: 10,
                                    color: Colors.grey[600],
                                  ),
                                ),
                              )
                              .toList(),
                        ),
                      ),
                      SizedBox(width: 8),

                      Expanded(
                        child: Stack(
                          children: [
                            Positioned.fill(
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: List.generate(6, (index) {
                                  return Container(
                                    height: 1,
                                    color: Colors.grey[300]!.withOpacity(0.5),
                                  );
                                }),
                              ),
                            ),

                            Positioned(
                              bottom: 0,
                              left: 0,
                              right: 0,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  _buildStackedBar(
                                    'B1',
                                    [4, 2],
                                    [Color(0xFF2196F3), Color(0xFF4CAF50)],
                                  ),
                                  _buildStackedBar(
                                    'C1',
                                    [3, 3],
                                    [Color(0xFF2196F3), Color(0xFF4CAF50)],
                                  ),
                                  _buildStackedBar(
                                    'C1',
                                    [2, 1],
                                    [Color(0xFF2196F3), Color(0xFF4CAF50)],
                                  ),
                                  _buildStackedBar(
                                    'B1',
                                    [5, 1],
                                    [Color(0xFF2196F3), Color(0xFF4CAF50)],
                                  ),
                                ],
                              ),
                            ),

                            Positioned.fill(
                              child: CustomPaint(painter: _LineChartPainter()),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),

                SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    _buildXAxisLabel('Building B1'),
                    _buildXAxisLabel('Building C1'),
                    _buildXAxisLabel('Building C1'),
                    _buildXAxisLabel('Building B1'),
                  ],
                ),

                SizedBox(height: 20),
                Wrap(
                  alignment: WrapAlignment.center,
                  spacing: 12,
                  runSpacing: 8,
                  children: [
                    _buildChartLegendItem('Average', Color(0xFF2196F3)),
                    _buildChartLegendItem('Building A', Color(0xFF4CAF50)),
                    _buildChartLegendItem('Line Trend', Color(0xFFF44336)),
                  ],
                ),
              ],
            ),
          ),

          SizedBox(height: 24),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Container(
                  padding: EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Color(0xFFF8F9FA),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: Colors.grey[200]!),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Average',
                        style: TextStyle(fontSize: 14, color: Colors.grey[600]),
                      ),
                      SizedBox(height: 8),
                      Row(
                        children: [
                          Container(
                            width: 8,
                            height: 8,
                            margin: EdgeInsets.only(right: 8),
                            decoration: BoxDecoration(
                              color: Color(0xFF2196F3),
                              shape: BoxShape.circle,
                            ),
                          ),
                          Text(
                            '4',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w700,
                              color: Colors.grey[800],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),

              SizedBox(width: 12),

              Expanded(
                child: Container(
                  padding: EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Color(0xFFF8F9FA),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: Colors.grey[200]!),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Building A',
                        style: TextStyle(fontSize: 14, color: Colors.grey[600]),
                      ),
                      SizedBox(height: 8),
                      Row(
                        children: [
                          Container(
                            width: 8,
                            height: 8,
                            margin: EdgeInsets.only(right: 8),
                            decoration: BoxDecoration(
                              color: Color(0xFF4CAF50),
                              shape: BoxShape.circle,
                            ),
                          ),
                          Text(
                            '4',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w700,
                              color: Colors.grey[800],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStackedBar(String label, List<int> values, List<Color> colors) {
    final totalHeight = 150.0;
    final maxValue = 10.0;

    return Column(
      children: [
        Container(
          width: 40,
          height: totalHeight,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: values.asMap().entries.map((entry) {
              int index = entry.key;
              int value = entry.value;
              double height = (value / maxValue) * totalHeight;

              return Container(
                height: height,
                width: 40,
                decoration: BoxDecoration(
                  color: colors[index % colors.length],
                  borderRadius: index == 0
                      ? BorderRadius.vertical(top: Radius.circular(4))
                      : BorderRadius.zero,
                ),
              );
            }).toList(),
          ),
        ),
        SizedBox(height: 8),
        Text(label, style: TextStyle(fontSize: 10, color: Colors.grey[600])),
      ],
    );
  }

  Widget _buildXAxisLabel(String text) {
    return Container(
      width: 60,
      child: Center(
        child: Text(
          text,
          style: TextStyle(fontSize: 10, color: Colors.grey[600]),
        ),
      ),
    );
  }

  Widget _buildChartLegendItem(String text, Color color) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 6, vertical: 4),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 10,
            height: 10,
            margin: EdgeInsets.only(right: 4),
            decoration: BoxDecoration(color: color, shape: BoxShape.circle),
          ),
          Text(text, style: TextStyle(fontSize: 11, color: Colors.grey[700])),
        ],
      ),
    );
  }
}

class _LineChartPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Color(0xFFF44336)
      ..strokeWidth = 2
      ..style = PaintingStyle.stroke;

    final points = [
      Offset(size.width * 0.125, size.height * 0.4),
      Offset(size.width * 0.375, size.height * 0.3),
      Offset(size.width * 0.625, size.height * 0.7),
      Offset(size.width * 0.875, size.height * 0.2),
    ];

    for (int i = 0; i < points.length - 1; i++) {
      canvas.drawLine(points[i], points[i + 1], paint);
    }

    final pointPaint = Paint()
      ..color = Color(0xFFF44336)
      ..style = PaintingStyle.fill;

    for (final point in points) {
      canvas.drawCircle(point, 4, pointPaint);
      canvas.drawCircle(point, 6, paint..strokeWidth = 1);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
