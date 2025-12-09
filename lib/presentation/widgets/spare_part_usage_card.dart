import 'package:flutter/material.dart';

class SparePartUsageCard extends StatefulWidget {
  const SparePartUsageCard({Key? key}) : super(key: key);

  @override
  _SparePartUsageCardState createState() => _SparePartUsageCardState();
}

class _SparePartUsageCardState extends State<SparePartUsageCard> {
  String? _selectedMonth;
  int? _selectedMonthValue;

  final Map<String, int> _monthData = {
    'Jan': 85,
    'Feb': 45,
    'Mar': 70,
    'Apr': 90,
    'May': 35,
    'Jun': 60,
    'Jul': 80,
    'Aug': 50,
    'Sep': 65,
    'Oct': 75,
    'Nov': 40,
    'Dec': 95,
  };

  @override
  void initState() {
    super.initState();

    _selectedMonth = 'Jun';
    _selectedMonthValue = _monthData['Jun'];
  }

  void _onMonthTap(String month) {
    setState(() {
      _selectedMonth = month;
      _selectedMonthValue = _monthData[month];
    });
  }

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
                'Spare part Usage',
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
                child: Row(
                  children: [
                    Text(
                      'View All',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                        color: Color(0xFF2196F3),
                      ),
                    ),
                    SizedBox(width: 2),
                    Icon(
                      Icons.arrow_forward_ios,
                      size: 10,
                      color: Color(0xFF2196F3),
                    ),
                  ],
                ),
              ),
            ],
          ),

          SizedBox(height: 8),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(6),
                  border: Border.all(color: Colors.grey[300]!),
                ),
                child: Row(
                  children: [
                    Text(
                      'Alloy Casting',
                      style: TextStyle(fontSize: 12, color: Colors.grey[800]),
                    ),
                    SizedBox(width: 4),
                    Icon(
                      Icons.arrow_drop_down,
                      color: Colors.grey[600],
                      size: 16,
                    ),
                  ],
                ),
              ),

              Container(
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(6),
                  border: Border.all(color: Colors.grey[300]!),
                ),
                child: Row(
                  children: [
                    Text(
                      '2024',
                      style: TextStyle(fontSize: 12, color: Colors.grey[800]),
                    ),
                    SizedBox(width: 4),
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

          SizedBox(height: 12),

          Container(
            height: 140,
            child: Stack(
              children: [
                Container(
                  padding: EdgeInsets.only(
                    left: 4,
                    right: 8,
                    top: 8,
                    bottom: 8,
                  ),
                  decoration: BoxDecoration(
                    color: Color(0xFFF8F9FA),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Container(
                        width: 30,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              height: 100,
                              child: Align(
                                alignment: Alignment.center,
                                child: RotatedBox(
                                  quarterTurns: 3,
                                  child: Text(
                                    'Part Quantity',
                                    style: TextStyle(
                                      fontSize: 9,
                                      color: Colors.grey[600],
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),

                      Expanded(
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Container(
                              width: 18,
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: ['100', '80', '60', '40', '20', '0']
                                    .map(
                                      (label) => Container(
                                        height: 13,
                                        child: Align(
                                          alignment: Alignment.centerRight,
                                          child: Text(
                                            label,
                                            style: TextStyle(
                                              fontSize: 8,
                                              color: Colors.grey[600],
                                            ),
                                          ),
                                        ),
                                      ),
                                    )
                                    .toList(),
                              ),
                            ),
                            SizedBox(width: 4),

                            Expanded(
                              child: SingleChildScrollView(
                                scrollDirection: Axis.horizontal,
                                child: Container(
                                  width: _monthData.length * 22.0,
                                  child: Row(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: _monthData.entries.map((entry) {
                                      final month = entry.key;
                                      final value = entry.value;
                                      final maxHeight = 80.0;
                                      final barWidth = 10.0;
                                      final barHeight =
                                          (value / 100) * maxHeight;
                                      final isSelected =
                                          _selectedMonth == month;

                                      return GestureDetector(
                                        onTap: () => _onMonthTap(month),
                                        child: Container(
                                          width: 20,
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.end,
                                            children: [
                                              Container(
                                                width: barWidth,
                                                height: barHeight,
                                                margin: EdgeInsets.symmetric(
                                                  horizontal: 5,
                                                ),
                                                decoration: BoxDecoration(
                                                  color: isSelected
                                                      ? Color(0xFF2196F3)
                                                      : Color(
                                                          0xFF2196F3,
                                                        ).withOpacity(0.6),
                                                  borderRadius:
                                                      BorderRadius.only(
                                                        topLeft:
                                                            Radius.circular(2),
                                                        topRight:
                                                            Radius.circular(2),
                                                      ),
                                                ),
                                              ),
                                              SizedBox(height: 2),

                                              Text(
                                                month,
                                                style: TextStyle(
                                                  fontSize: 8,
                                                  color: Colors.grey[600],
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      );
                                    }).toList(),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),

                if (_selectedMonth != null && _selectedMonthValue != null)
                  Positioned(
                    left: _getTooltipPosition(),
                    top: 10,
                    child: _buildTooltip(),
                  ),

                Positioned(
                  left: 56,
                  right: 8,
                  top: 8,
                  bottom: 24,
                  child: IgnorePointer(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          height: 1,
                          color: Colors.grey[300]!.withOpacity(0.3),
                        ),
                        Container(
                          height: 1,
                          color: Colors.grey[300]!.withOpacity(0.3),
                        ),
                        Container(
                          height: 1,
                          color: Colors.grey[300]!.withOpacity(0.3),
                        ),
                        Container(
                          height: 1,
                          color: Colors.grey[300]!.withOpacity(0.3),
                        ),
                        Container(
                          height: 1,
                          color: Colors.grey[300]!.withOpacity(0.3),
                        ),
                        Container(
                          height: 1,
                          color: Colors.grey[300]!.withOpacity(0.3),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  double _getTooltipPosition() {
    final monthIndex = _monthData.keys.toList().indexOf(_selectedMonth!);
    return 56.0 + (monthIndex * 22.0) - 25.0;
  }

  Widget _buildTooltip() {
    if (_selectedMonth == null || _selectedMonthValue == null)
      return SizedBox();

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(4),
        border: Border.all(color: Color(0xFF2196F3).withOpacity(0.3)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 4,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            _selectedMonth!,
            style: TextStyle(
              fontSize: 9,
              fontWeight: FontWeight.w600,
              color: Color(0xFF2196F3),
            ),
          ),
          Text(
            'Total : $_selectedMonthValue',
            style: TextStyle(fontSize: 9, color: Colors.grey[700]),
          ),
        ],
      ),
    );
  }
}
