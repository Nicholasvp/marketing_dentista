import 'package:marketing_dentista/core/core.dart';
import 'package:marketing_dentista/core/theme/app_colors.dart';
import 'package:marketing_dentista/core/theme/app_text_style.dart';
import 'package:marketing_dentista/core/utils/formatter.dart';
import 'package:marketing_dentista/features/product_search/models/product_model.dart';

class CardProduct extends StatelessWidget {
  const CardProduct({
    super.key,
    required this.product,
  });

  final ProductModel product;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.white,
      padding: const EdgeInsets.all(8),
      child: Row(
        children: [
          Image.network(
            product.imageUrl,
            width: 100,
            height: 100,
            fit: BoxFit.cover,
            errorBuilder: (context, error, stackTrace) => const Icon(
              Icons.image,
              size: 100,
            ),
          ),
          const SizedBox(width: 16),
          Flexible(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  product.name,
                  style: AppTextStyle.body,
                ),
                const SizedBox(height: 6),
                if (product.discount != null)
                  Text(
                    product.price.toCurrency(),
                    style: AppTextStyle.infoHighline.copyWith(
                      decoration: TextDecoration.lineThrough,
                      color: AppColors.grey,
                    ),
                  ),
                Text(
                  (product.price - (product.discount ?? 0)).toCurrency(),
                  style: AppTextStyle.price,
                ),
                Text(
                  'Em até 12x de ${(product.price / 12).toCurrency()}',
                  style: AppTextStyle.infoHighline,
                ),
                const SizedBox(height: 6),
                if (product.createdAt.millisecondsSinceEpoch >=
                    DateTime.now().subtract(const Duration(days: 1)).millisecondsSinceEpoch)
                  Text(
                    'NOVO',
                    style: AppTextStyle.labelData.copyWith(color: AppColors.grey),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
