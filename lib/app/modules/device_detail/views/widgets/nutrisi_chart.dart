import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:kelola_tani/app/core/theme/app_style.dart';
import 'package:kelola_tani/app/modules/device_detail/controllers/device_detail_controller.dart';
import 'dart:math' as math;

class NutrisiChart extends StatefulWidget {
  const NutrisiChart({super.key});

  @override
  State<NutrisiChart> createState() => _NutrisiChartState();
}

class _NutrisiChartState extends State<NutrisiChart> {
  final ScrollController _scrollController = ScrollController();

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _scrollToNewest() {
    if (_scrollController.hasClients) {
      _scrollController.animateTo(
        0.0,
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeInOut,
      );
    }
  }

  void _scrollToOldest() {
    if (_scrollController.hasClients) {
      _scrollController.animateTo(
        _scrollController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeInOut,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<DeviceDetailController>();

    return Obx(() {
      final raw = controller.chartLogs.toList();
      final logs = raw.reversed.toList();

      if (logs.isEmpty) {
        return Container(
          height: 250.h,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12.r),
          ),
          child: const Center(child: Text('Belum ada data sensor')),
        );
      }

      double calculatedWidth = logs.length * 40.w;
      double minWidth = MediaQuery.of(context).size.width - 50.w;
      double chartWidth = math.max(calculatedWidth, minWidth);

      return Container(
        height: 290.h,
        padding: EdgeInsets.only(left: 8.w, top: 16.h, bottom: 8.h),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12.r),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _buildLegendItem('Nitrogen (N)', Colors.green),
                SizedBox(width: 12.w),
                _buildLegendItem('Fosfor (P)', Colors.red),
                SizedBox(width: 12.w),
                _buildLegendItem('Kalium (K)', Colors.blue),
              ],
            ),

            Expanded(
              child: SingleChildScrollView(
                controller: _scrollController,
                scrollDirection: Axis.horizontal,
                reverse: true,
                child: Container(
                  width: chartWidth,
                  padding: EdgeInsets.only(right: 16.w),
                  child: LineChart(
                    LineChartData(
                      maxX: (logs.length - 1).toDouble(),
                      minY: 0,
                      maxY: 250,
                      gridData: FlGridData(
                        show: true,
                        drawVerticalLine: true,
                        getDrawingHorizontalLine: (value) =>
                            FlLine(color: Colors.grey.shade300, strokeWidth: 1),
                        getDrawingVerticalLine: (value) =>
                            FlLine(color: Colors.grey.shade300, strokeWidth: 1),
                      ),
                      titlesData: FlTitlesData(
                        bottomTitles: AxisTitles(
                          sideTitles: SideTitles(
                            showTitles: true,
                            reservedSize: 28,
                            interval: 1,
                            getTitlesWidget: (value, meta) {
                              final index = value.toInt();
                              if (index < 0 || index >= logs.length) {
                                return const SizedBox();
                              }
                              final time = logs[index].recordedAt.toLocal();
                              return Padding(
                                padding: EdgeInsets.only(top: 4.h),
                                child: Text(
                                  '${time.hour.toString().padLeft(2, '0')}:${time.minute.toString().padLeft(2, '0')}',
                                  style: TextStyle(
                                    fontSize: 9.sp,
                                    color: Colors.grey.shade600,
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                        leftTitles: AxisTitles(
                          sideTitles: SideTitles(
                            showTitles: true,
                            interval: 50,
                            reservedSize: 30,
                            getTitlesWidget: (value, meta) {
                              return Text(
                                value.toInt().toString(),
                                style: TextStyle(
                                  fontSize: 10.sp,
                                  color: Colors.grey.shade600,
                                ),
                              );
                            },
                          ),
                        ),
                        topTitles: const AxisTitles(
                          sideTitles: SideTitles(showTitles: false),
                        ),
                        rightTitles: const AxisTitles(
                          sideTitles: SideTitles(showTitles: false),
                        ),
                      ),
                      borderData: FlBorderData(
                        show: true,
                        border: Border.all(color: Colors.grey.shade300),
                      ),
                      lineBarsData: [
                        _buildLine(
                          logs
                              .asMap()
                              .entries
                              .map(
                                (e) =>
                                    FlSpot(e.key.toDouble(), e.value.nitrogen),
                              )
                              .toList(),
                          Colors.green,
                        ),
                        _buildLine(
                          logs
                              .asMap()
                              .entries
                              .map(
                                (e) =>
                                    FlSpot(e.key.toDouble(), e.value.phosphor),
                              )
                              .toList(),
                          Colors.red,
                        ),
                        _buildLine(
                          logs
                              .asMap()
                              .entries
                              .map(
                                (e) => FlSpot(e.key.toDouble(), e.value.kalium),
                              )
                              .toList(),
                          Colors.blue,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 8.h),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  InkWell(
                    onTap: _scrollToOldest,
                    child: Row(
                      children: [
                        Icon(
                          Icons.keyboard_double_arrow_left,
                          size: 16.sp,
                          color: AppStyle.primary,
                        ),
                        SizedBox(width: 4.w),
                        Text(
                          'Terlama',
                          style: TextStyle(
                            fontSize: 11.sp,
                            color: AppStyle.primary,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                  InkWell(
                    onTap: _scrollToNewest,
                    child: Row(
                      children: [
                        Text(
                          'Terbaru',
                          style: TextStyle(
                            fontSize: 11.sp,
                            color: AppStyle.primary,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(width: 4.w),
                        Icon(
                          Icons.keyboard_double_arrow_right,
                          size: 16.sp,
                          color: AppStyle.primary,
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
    });
  }

  Widget _buildLegendItem(String label, Color color) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 8.w,
          height: 8.w,
          decoration: BoxDecoration(shape: BoxShape.circle, color: color),
        ),
        SizedBox(width: 4.w),
        Text(
          label,
          style: TextStyle(
            fontSize: 11.sp,
            color: Colors.grey.shade700,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }

  LineChartBarData _buildLine(List<FlSpot> spots, Color color) {
    return LineChartBarData(
      spots: spots,
      isCurved: true,
      color: color,
      barWidth: 2.5,
      isStrokeCapRound: true,
      dotData: FlDotData(
        show: true,
        getDotPainter: (spot, percent, barData, index) => FlDotCirclePainter(
          radius: 3,
          color: color,
          strokeWidth: 1.5,
          strokeColor: Colors.white,
        ),
      ),
    );
  }
}
