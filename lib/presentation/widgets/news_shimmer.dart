import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class NewsShimmer extends StatelessWidget {
  const NewsShimmer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
          decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.1),
                blurRadius: 4,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Shimmer.fromColors(
            baseColor: Colors.grey[300]!,
            highlightColor: Colors.grey[100]!,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(height: 24, width: 120, color: Colors.white),
                Container(width: 24, height: 24, color: Colors.white),
              ],
            ),
          ),
        ),

        Expanded(
          child: ListView.builder(
            padding: EdgeInsets.zero,
            itemCount: 5,
            itemBuilder: (context, index) {
              if (index == 0) {
                return _buildFirstNewsShimmer();
              }
              return _buildNewsItemShimmer();
            },
          ),
        ),
      ],
    );
  }

  Widget _buildFirstNewsShimmer() {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: Container(
        margin: const EdgeInsets.only(bottom: 1),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border(
            bottom: BorderSide(color: Colors.grey[200]!, width: 1),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(height: 220, width: double.infinity, color: Colors.white),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(height: 12, width: 80, color: Colors.white),
                      const SizedBox(width: 8),
                      Container(height: 12, width: 10, color: Colors.white),
                      const SizedBox(width: 8),
                      Container(height: 12, width: 60, color: Colors.white),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Container(
                    height: 20,
                    width: double.infinity,
                    color: Colors.white,
                  ),
                  const SizedBox(height: 8),
                  Container(
                    height: 16,
                    width: double.infinity,
                    color: Colors.white,
                  ),
                  const SizedBox(height: 8),
                  Container(height: 16, width: 250, color: Colors.white),
                  const SizedBox(height: 12),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Container(
                            width: 32,
                            height: 32,
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.white,
                            ),
                          ),
                          const SizedBox(width: 8),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                height: 10,
                                width: 60,
                                color: Colors.white,
                              ),
                              const SizedBox(height: 4),
                              Container(
                                height: 8,
                                width: 40,
                                color: Colors.white,
                              ),
                            ],
                          ),
                        ],
                      ),
                      Container(height: 12, width: 80, color: Colors.white),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNewsItemShimmer() {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border(
            top: BorderSide(color: Colors.grey[200]!, width: 1),
            bottom: BorderSide(color: Colors.grey[200]!, width: 1),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Container(height: 10, width: 60, color: Colors.white),
                        const SizedBox(width: 6),
                        Container(height: 10, width: 8, color: Colors.white),
                        const SizedBox(width: 6),
                        Container(height: 10, width: 50, color: Colors.white),
                      ],
                    ),
                    const SizedBox(height: 6),
                    Container(
                      height: 16,
                      width: double.infinity,
                      color: Colors.white,
                    ),
                    const SizedBox(height: 6),
                    Container(
                      height: 14,
                      width: double.infinity,
                      color: Colors.white,
                    ),
                    const SizedBox(height: 4),
                    Container(height: 14, width: 200, color: Colors.white),
                  ],
                ),
              ),
              const SizedBox(width: 12),
              Container(
                width: 80,
                height: 80,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
