import 'package:intl/intl.dart';
import 'package:marketing_dentista/core/core.dart';
import 'package:marketing_dentista/core/theme/app_assets.dart';
import 'package:marketing_dentista/core/theme/app_colors.dart';
import 'package:marketing_dentista/core/theme/app_text_style.dart';
import 'package:marketing_dentista/features/product_search/product_search_export.dart';
import 'package:skeletonizer/skeletonizer.dart';

class ProductSearchView extends StatefulWidget {
  const ProductSearchView({super.key});

  @override
  State<ProductSearchView> createState() => _ProductSearchViewState();
}

class _ProductSearchViewState extends State<ProductSearchView> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _initialize();
    });
    super.initState();
  }

  _initialize() async {
    final viewModel = context.read<ProductViewModel>();
    if (viewModel.products.isEmpty) {
      await viewModel.fetchProducts();
    }
    if (viewModel.query.isNotEmpty) {
      await viewModel.searchProducts(viewModel.query);
    }
  }

  @override
  Widget build(BuildContext context) {
    final viewModel = context.read<ProductViewModel>();
    return Column(
      children: [
        SearchAppBar(
          action: (value) {
            viewModel.searchProducts(value);
          },
          query: viewModel.query,
        ),
        Expanded(
          child: AnimatedBuilder(
              animation: viewModel,
              builder: (context, _) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: _buildBody(viewModel),
                );
              }),
        ),
      ],
    );
  }

  Widget _buildBody(ProductViewModel viewModel) {
    switch (viewModel.state) {
      case ViewState.initial:
        return const ViewInitial();
      case ViewState.loading:
        return const ViewLoading();
      case ViewState.loaded:
        return const ViewLoaded();
      case ViewState.error:
        return const ViewError();
      default:
        return const SizedBox();
    }
  }
}

class ViewError extends StatelessWidget {
  const ViewError({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<ProductViewModel>();
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset(AppAssets.notFound),
          const SizedBox(height: 6),
          Text(
            'Resultado não encontrado',
            style: AppTextStyle.body.copyWith(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 6),
          Text(
            textAlign: TextAlign.center,
            viewModel.errorMessage,
            style: AppTextStyle.label,
          ),
        ],
      ),
    );
  }
}

class ViewLoaded extends StatelessWidget {
  const ViewLoaded({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<ProductViewModel>();
    final productsByDate = _groupAndSortProductsByDate(viewModel.products);

    return ListView.builder(
      itemCount: productsByDate.length,
      itemBuilder: (context, index) {
        final date = productsByDate.keys.elementAt(index);
        final products = productsByDate[date]!;

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                date,
                style: AppTextStyle.labelData.copyWith(color: AppColors.grey),
              ),
            ),
            ...products.map((product) => CardProduct(product: product)),
          ],
        );
      },
    );
  }

  Map<String, List<ProductModel>> _groupAndSortProductsByDate(List<ProductModel> products) {
    final Map<String, List<ProductModel>> groupedProducts = {};

    for (var product in products) {
      final date = _formatDate(product.createdAt);
      if (groupedProducts[date] == null) {
        groupedProducts[date] = [];
      }
      groupedProducts[date]!.add(product);
    }

    final sortedEntries = groupedProducts.entries.toList()
      ..sort((a, b) {
        final dateA = _parseDate(a.key);
        final dateB = _parseDate(b.key);
        return dateB.millisecondsSinceEpoch.compareTo(dateA.millisecondsSinceEpoch);
      });

    return Map<String, List<ProductModel>>.fromEntries(sortedEntries);
  }

  String _formatDate(DateTime date) {
    final now = DateTime.now();
    final difference = now.difference(date).inDays;

    if (difference == 0) {
      return 'Hoje';
    } else if (difference == 1) {
      return 'Ontem';
    } else {
      return DateFormat('dd/MM/yyyy').format(date);
    }
  }

  DateTime _parseDate(String formattedDate) {
    if (formattedDate == 'Hoje') {
      return DateTime.now();
    } else if (formattedDate == 'Ontem') {
      return DateTime.now().subtract(const Duration(days: 1));
    } else {
      return DateFormat('dd/MM/yyyy').parse(formattedDate);
    }
  }
}

class ViewLoading extends StatelessWidget {
  const ViewLoading({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 2,
      itemBuilder: (contex, index) {
        return Skeletonizer(
          enabled: true,
          child: CardProduct(
            product: ProductModel.empty(),
          ),
        );
      },
    );
  }
}

class ViewInitial extends StatelessWidget {
  const ViewInitial({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const SizedBox.shrink();
  }
}
