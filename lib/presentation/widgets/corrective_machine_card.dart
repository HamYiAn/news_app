import 'package:flutter/material.dart';

class CorrectiveMachineCard extends StatelessWidget {
  const CorrectiveMachineCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            blurRadius: 8,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Corrective (Machine)',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: Colors.grey[800],
                ),
              ),
              TextButton(
                onPressed: () {},
                style: TextButton.styleFrom(
                  padding: EdgeInsets.zero,
                  minimumSize: Size.zero,
                ),
                child: Text(
                  'View All',
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                    color: Color(0xFF2196F3),
                  ),
                ),
              ),
            ],
          ),

          SizedBox(height: 12),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                width: MediaQuery.of(context).size.width * 0.4,
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(6),
                  border: Border.all(color: Colors.grey[300]!),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.location_on_outlined,
                          color: Colors.grey[700],
                          size: 12,
                        ),
                        SizedBox(width: 4),
                        Text(
                          'Building A',
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.grey[800],
                          ),
                        ),
                      ],
                    ),
                    Icon(
                      Icons.arrow_drop_down,
                      color: Colors.grey[600],
                      size: 16,
                    ),
                  ],
                ),
              ),

              Container(
                width: MediaQuery.of(context).size.width * 0.25,
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(6),
                  border: Border.all(color: Colors.grey[300]!),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '2024',
                      style: TextStyle(fontSize: 12, color: Colors.grey[800]),
                    ),
                    Icon(
                      Icons.arrow_drop_down,
                      color: Colors.grey[600],
                      size: 16,
                    ),
                  ],
                ),
              ),
            ],
          ),

          SizedBox(height: 16),

          Center(
            child: Container(
              width: 140,
              height: 140,
              child: _buildSegmentedCircleNoText(),
            ),
          ),

          SizedBox(height: 16),

          Container(
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    children: [
                      _buildMachineLegendItem(
                        'Crane',
                        '43% (92)',
                        Color(0xFFF44336),
                      ),
                      SizedBox(height: 6),
                      _buildMachineLegendItem(
                        'Crane',
                        '20%',
                        Color(0xFFFF9800),
                      ),
                      SizedBox(height: 6),
                      _buildMachineLegendItem(
                        'Air Dryer',
                        '15%',
                        Color(0xFF9C27B0),
                      ),
                    ],
                  ),
                ),
                SizedBox(width: 8),
                Expanded(
                  child: Column(
                    children: [
                      _buildMachineLegendItem(
                        'Hoist',
                        '10%',
                        Color(0xFF4CAF50),
                      ),
                      SizedBox(height: 6),
                      _buildMachineLegendItem(
                        'Compressor',
                        '10%',
                        Color(0xFF2196F3),
                      ),
                      SizedBox(height: 6),
                      _buildMachineLegendItem(
                        'Spot Welding',
                        '5%',
                        Color(0xFFFFC107),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSegmentedCircleNoText() {
    return SizedBox(
      width: 140,
      height: 140,
      child: CustomPaint(painter: _SegmentedCircleNoTextPainter()),
    );
  }

  Widget _buildMachineLegendItem(String name, String percentage, Color color) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 6, vertical: 4),
      margin: EdgeInsets.only(bottom: 2),
      decoration: BoxDecoration(
        color: Colors.grey[50],
        borderRadius: BorderRadius.circular(4),
      ),
      child: Row(
        children: [
          Container(
            width: 8,
            height: 8,
            margin: EdgeInsets.only(right: 6),
            decoration: BoxDecoration(color: color, shape: BoxShape.circle),
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: TextStyle(
                    fontSize: 10,
                    color: Colors.grey[700],
                    fontWeight: FontWeight.w500,
                  ),
                ),
                if (percentage.isNotEmpty)
                  Text(
                    percentage,
                    style: TextStyle(
                      fontSize: 9,
                      fontWeight: FontWeight.w600,
                      color: Colors.grey[800],
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _SegmentedCircleNoTextPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width / 2 - 6;
    final strokeWidth = 20.0;

    final segments = [
      {'start': 0.0, 'sweep': 43.0, 'color': Color(0xFFF44336)},
      {'start': 43.0, 'sweep': 20.0, 'color': Color(0xFFFF9800)},
      {'start': 63.0, 'sweep': 15.0, 'color': Color(0xFF9C27B0)},
      {'start': 78.0, 'sweep': 10.0, 'color': Color(0xFF4CAF50)},
      {'start': 88.0, 'sweep': 10.0, 'color': Color(0xFF2196F3)},
      {'start': 98.0, 'sweep': 2.0, 'color': Color(0xFFFFC107)},
    ];

    for (var segment in segments) {
      final paint = Paint()
        ..color = segment['color'] as Color
        ..strokeWidth = strokeWidth
        ..style = PaintingStyle.stroke
        ..strokeCap = StrokeCap.butt;

      final startAngleRad = ((segment['start'] as double) / 100) * 2 * 3.14159;
      final sweepAngleRad = ((segment['sweep'] as double) / 100) * 2 * 3.14159;

      canvas.drawArc(
        Rect.fromCircle(center: center, radius: radius),
        startAngleRad + 0.015,
        sweepAngleRad - 0.03,
        false,
        paint,
      );
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
