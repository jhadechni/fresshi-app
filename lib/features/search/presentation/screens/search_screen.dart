import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:fresshi/routes/app_routes.dart';
import 'package:fresshi/features/products/presentation/widgets/product_card.dart';
import 'package:fresshi/features/search/presentation/providers/search_provider.dart';

class SearchScreen extends ConsumerStatefulWidget {
  const SearchScreen({super.key});

  @override
  ConsumerState<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends ConsumerState<SearchScreen> {
  late final TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final resultsAsync = ref.watch(searchResultsProvider);
    final query = ref.watch(searchQueryProvider);

    return Scaffold(
      appBar: AppBar(
        title: TextField(
          controller: _controller,
          autofocus: true,
          decoration: const InputDecoration(
            hintText: 'Search products...',
            border: InputBorder.none,
          ),
          onChanged: (value) =>
              ref.read(searchQueryProvider.notifier).state = value,
        ),
        actions: [
          if (query.isNotEmpty)
            IconButton(
              icon: const Icon(Icons.clear),
              tooltip: 'Clear search',
              onPressed: () {
                _controller.clear();
                ref.read(searchQueryProvider.notifier).state = '';
              },
            ),
        ],
      ),
      body: query.isEmpty
          ? const Center(child: Text('Type to search products'))
          : resultsAsync.when(
              loading: () =>
                  const Center(child: CircularProgressIndicator()),
              error: (error, _) => Center(child: Text('$error')),
              data: (results) => results.isEmpty
                  ? const Center(child: Text('No products found'))
                  : GridView.builder(
                      padding: const EdgeInsets.all(12),
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        childAspectRatio: 0.7,
                        crossAxisSpacing: 12,
                        mainAxisSpacing: 12,
                      ),
                      itemCount: results.length,
                      itemBuilder: (context, index) => ProductCard(
                        product: results[index],
                        onTap: () => context.pushNamed(
                          AppRoutes.productDetailName,
                          pathParameters: {'id': results[index].id.toString()},
                        ),
                      ),
                    ),
            ),
    );
  }
}
