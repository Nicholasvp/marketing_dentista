import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:marketing_dentista/core/theme/app_assets.dart';
import 'package:marketing_dentista/core/theme/app_colors.dart';
import 'package:marketing_dentista/core/theme/app_text_style.dart';

class AppBottomNavigation extends StatelessWidget {
  const AppBottomNavigation({super.key, required this.currentIndex, required this.onTap});
  final int currentIndex;
  final void Function(int) onTap;

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: currentIndex,
      onTap: onTap,
      type: BottomNavigationBarType.fixed,
      selectedLabelStyle: AppTextStyle.label.copyWith(color: AppColors.primary),
      unselectedLabelStyle: AppTextStyle.label.copyWith(color: AppColors.grey),
      selectedItemColor: AppColors.primary,
      items: [
        BottomNavigationBarItem(
          icon: SvgPicture.asset(
            AppAssets.home,
            colorFilter: ColorFilter.mode(AppColors.grey, BlendMode.srcIn),
          ),
          activeIcon: SvgPicture.asset(
            AppAssets.home,
            colorFilter: ColorFilter.mode(AppColors.primary, BlendMode.srcIn),
          ),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: SvgPicture.asset(
            AppAssets.categories,
            colorFilter: ColorFilter.mode(AppColors.grey, BlendMode.srcIn),
          ),
          activeIcon: SvgPicture.asset(
            AppAssets.categories,
            colorFilter: ColorFilter.mode(AppColors.primary, BlendMode.srcIn),
          ),
          label: 'Categorias',
        ),
        BottomNavigationBarItem(
          icon: SvgPicture.asset(
            AppAssets.add,
            colorFilter: ColorFilter.mode(AppColors.grey, BlendMode.srcIn),
          ),
          activeIcon: SvgPicture.asset(
            AppAssets.add,
            colorFilter: ColorFilter.mode(AppColors.primary, BlendMode.srcIn),
          ),
          label: 'Anunciar',
        ),
        BottomNavigationBarItem(
          icon: SvgPicture.asset(
            AppAssets.favorite,
            colorFilter: ColorFilter.mode(AppColors.grey, BlendMode.srcIn),
          ),
          activeIcon: SvgPicture.asset(
            AppAssets.favorite,
            colorFilter: ColorFilter.mode(AppColors.primary, BlendMode.srcIn),
          ),
          label: 'Favoritos',
        ),
        BottomNavigationBarItem(
          icon: SvgPicture.asset(
            AppAssets.user,
            colorFilter: ColorFilter.mode(AppColors.grey, BlendMode.srcIn),
          ),
          activeIcon: SvgPicture.asset(
            AppAssets.user,
            colorFilter: ColorFilter.mode(AppColors.primary, BlendMode.srcIn),
          ),
          label: 'Conta',
        ),
      ],
    );
  }
}
