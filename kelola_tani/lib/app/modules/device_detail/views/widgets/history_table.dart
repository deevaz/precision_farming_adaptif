import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:kelola_tani/app/core/theme/app_fonts.dart';
import 'package:kelola_tani/app/core/theme/app_style.dart';

import '../../controllers/device_detail_controller.dart';

class HistoryTable extends StatefulWidget {
  const HistoryTable({super.key});

  @override
  State<HistoryTable> createState() => _HistoryTableState();
}

class _HistoryTableState extends State<HistoryTable> {
  int _currentPage = 0;
  final int _rowsPerPage = 10;

  final ScrollController _headerScrollController = ScrollController();
  final ScrollController _bodyScrollController = ScrollController();

  bool _isSyncing = false;

  @override
  void initState() {
    super.initState();

    _bodyScrollController.addListener(() {
      if (_isSyncing) return;
      if (_headerScrollController.hasClients &&
          _bodyScrollController.hasClients) {
        _isSyncing = true;
        _headerScrollController.jumpTo(_bodyScrollController.offset);
        _isSyncing = false;
      }
    });

    _headerScrollController.addListener(() {
      if (_isSyncing) return;
      if (_headerScrollController.hasClients &&
          _bodyScrollController.hasClients) {
        _isSyncing = true;
        _bodyScrollController.jumpTo(_headerScrollController.offset);
        _isSyncing = false;
      }
    });
  }

  @override
  void dispose() {
    _headerScrollController.dispose();
    _bodyScrollController.dispose();
    super.dispose();
  }

  void _nextPage(int totalPages) {
    if (_currentPage < totalPages - 1) {
      setState(() {
        _currentPage++;
      });
    }
  }

  void _prevPage() {
    if (_currentPage > 0) {
      setState(() {
        _currentPage--;
      });
    }
  }

  double _getColumnWidth(int index) {
    switch (index) {
      case 0:
        return 60.w;
      case 1:
        return 40.w;
      case 2:
        return 40.w;
      case 3:
        return 40.w;
      case 4:
        return 50.w;
      case 5:
        return 70.w;
      case 6:
        return 70.w;
      default:
        return 50.w;
    }
  }

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<DeviceDetailController>();

    return Obx(() {
      final logs = controller.tableLogs;

      if (logs.isEmpty) {
        return Container(
          height: 300.h,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12.r),
          ),
          child: const Center(child: Text('Belum ada data riwayat')),
        );
      }

      int totalPages = (logs.length / _rowsPerPage).ceil();

      if (_currentPage >= totalPages && totalPages > 0) {
        _currentPage = totalPages - 1;
      }
      if (totalPages == 0) _currentPage = 0;

      final paginatedLogs = logs
          .skip(_currentPage * _rowsPerPage)
          .take(_rowsPerPage)
          .toList();

      return Container(
        height: 350.h,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12.r),
          border: Border.all(color: Colors.grey.shade200),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              decoration: BoxDecoration(
                color: Colors.green.shade100,
                borderRadius: BorderRadius.vertical(top: Radius.circular(11.r)),
              ),
              child: SingleChildScrollView(
                controller: _headerScrollController,
                scrollDirection: Axis.horizontal,
                physics: const NeverScrollableScrollPhysics(),
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 16.w,
                    vertical: 12.h,
                  ),
                  child: Row(
                    children: [
                      _buildHeaderCell('Waktu', 0),
                      _buildHeaderCell('N', 1),
                      _buildHeaderCell('P', 2),
                      _buildHeaderCell('K', 3),
                      _buildHeaderCell('Suhu', 4),
                      _buildHeaderCell('Kel.Tanah', 5),
                      _buildHeaderCell('Kel.Udara', 6),
                    ],
                  ),
                ),
              ),
            ),

            Expanded(
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: SingleChildScrollView(
                  controller: _bodyScrollController,
                  scrollDirection: Axis.horizontal,
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16.w),
                    child: Column(
                      children: paginatedLogs.map((log) {
                        final time = log.recordedAt.toLocal();
                        return Container(
                          padding: EdgeInsets.symmetric(vertical: 12.h),
                          decoration: BoxDecoration(
                            border: Border(
                              bottom: BorderSide(color: Colors.grey.shade100),
                            ),
                          ),
                          child: Row(
                            children: [
                              _buildDataCell(
                                '${time.hour.toString().padLeft(2, '0')}:${time.minute.toString().padLeft(2, '0')}',
                                0,
                              ),
                              _buildDataCell(
                                log.nitrogen.toStringAsFixed(0),
                                1,
                              ),
                              _buildDataCell(
                                log.phosphor.toStringAsFixed(0),
                                2,
                              ),
                              _buildDataCell(log.kalium.toStringAsFixed(0), 3),
                              _buildDataCell(log.suhu.toStringAsFixed(1), 4),
                              _buildDataCell(
                                log.kelembapanTanah.toStringAsFixed(0),
                                5,
                              ),
                              _buildDataCell(
                                log.kelembapanUdara.toStringAsFixed(0),
                                6,
                              ),
                            ],
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                ),
              ),
            ),

            Container(
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
              decoration: BoxDecoration(
                border: Border(top: BorderSide(color: Colors.grey.shade200)),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    icon: Icon(
                      Icons.chevron_left,
                      color: _currentPage > 0
                          ? AppStyle.primary
                          : Colors.grey.shade400,
                    ),
                    onPressed: _currentPage > 0 ? _prevPage : null,
                  ),
                  Text(
                    'Halaman ${_currentPage + 1} dari $totalPages',
                    style: AppFonts.smSemiBold.copyWith(
                      color: Colors.grey.shade700,
                    ),
                  ),
                  IconButton(
                    icon: Icon(
                      Icons.chevron_right,
                      color: _currentPage < totalPages - 1
                          ? AppStyle.primary
                          : Colors.grey.shade400,
                    ),
                    onPressed: _currentPage < totalPages - 1
                        ? () => _nextPage(totalPages)
                        : null,
                  ),
                ],
              ),
            ),
          ],
        ),
      );
    });
  }

  Widget _buildHeaderCell(String label, int index) {
    return SizedBox(
      width: _getColumnWidth(index),
      child: Text(
        label,
        style: AppFonts.smBold.copyWith(color: Colors.green.shade800),
        textAlign: TextAlign.center,
      ),
    );
  }

  Widget _buildDataCell(String value, int index) {
    return SizedBox(
      width: _getColumnWidth(index),
      child: Text(
        value,
        style: AppFonts.smRegular.copyWith(color: Colors.black87),
        textAlign: TextAlign.center,
      ),
    );
  }
}
