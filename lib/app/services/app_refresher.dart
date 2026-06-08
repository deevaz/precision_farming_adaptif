import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kelola_tani/app/core/theme/app_fonts.dart';
import 'package:kelola_tani/app/core/theme/app_style.dart';
import 'package:pull_to_refresh_flutter3/pull_to_refresh_flutter3.dart';
import 'package:ionicons/ionicons.dart';

class AppRefresher extends StatefulWidget {
  final Widget child;
  final Future<void> Function()? onRefresh;
  final Future<void> Function()? onLoadMore;

  final bool isEmpty;
  final Widget? emptyWidget;

  const AppRefresher({
    super.key,
    required this.child,
    this.onRefresh,
    this.onLoadMore,
    this.isEmpty = false,
    this.emptyWidget,
  });

  @override
  State<AppRefresher> createState() => _AppRefresherState();
}

class _AppRefresherState extends State<AppRefresher> {
  late final RefreshController _controller;

  @override
  void initState() {
    super.initState();
    _controller = RefreshController();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> _onRefresh() async {
    if (widget.onRefresh != null) {
      try {
        await widget.onRefresh!();
        _controller.refreshCompleted();
      } catch (e) {
        _controller.refreshFailed();
      }
    }
  }

  Future<void> _onLoadMore() async {
    if (widget.onLoadMore != null) {
      try {
        await widget.onLoadMore!();
        _controller.loadComplete();
      } catch (e) {
        _controller.loadFailed();
      }
    }
  }

  Widget _buildEmptyState() {
    if (widget.emptyWidget != null) return widget.emptyWidget!;

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Ionicons.folder_open_outline,
            size: 80.sp,
            color: Colors.grey.shade300,
          ),
          SizedBox(height: 16.h),
          Text(
            "Belum ada data",
            style: AppFonts.lgBold.copyWith(color: Colors.grey.shade600),
          ),
          SizedBox(height: 8.h),
          Text(
            "Tarik ke bawah untuk memuat ulang",
            style: AppFonts.smRegular.copyWith(color: Colors.grey.shade500),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SmartRefresher(
      controller: _controller,
      enablePullDown: widget.onRefresh != null,

      enablePullUp: widget.isEmpty ? false : widget.onLoadMore != null,
      physics: const BouncingScrollPhysics(),
      header: const MaterialClassicHeader(
        color: AppStyle.white,
        backgroundColor: AppStyle.primary,
      ),
      footer: ClassicFooter(
        loadStyle: LoadStyle.ShowWhenLoading,
        loadingText: "Memuat data...",
        idleText: "Tarik ke atas untuk muat lebih banyak",
        canLoadingText: "Lepaskan untuk memuat",
        failedText: "Gagal memuat data",
        noDataText: "Semua data telah ditampilkan",
        textStyle: AppFonts.smMedium.copyWith(color: AppStyle.grey),
        idleIcon: const Icon(
          Icons.arrow_upward,
          color: AppStyle.grey,
          size: 18,
        ),
        canLoadingIcon: const Icon(
          Icons.arrow_downward,
          color: AppStyle.grey,
          size: 18,
        ),
        failedIcon: const Icon(
          Icons.error_outline,
          color: AppStyle.danger,
          size: 18,
        ),
      ),
      onRefresh: _onRefresh,
      onLoading: _onLoadMore,

      child: widget.isEmpty
          ? CustomScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              slivers: [
                SliverFillRemaining(
                  hasScrollBody: false,
                  child: _buildEmptyState(),
                ),
              ],
            )
          : widget.child,
    );
  }
}
