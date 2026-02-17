import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:fresshi/features/auth/presentation/screens/login_screen.dart';
import 'package:fresshi/features/auth/presentation/screens/register_screen.dart';
import 'package:fresshi/features/cart/presentation/screens/cart_screen.dart';
import 'package:fresshi/features/home/presentation/screens/home_screen.dart';
import 'package:fresshi/features/products/presentation/screens/product_detail_screen.dart';
import 'package:fresshi/features/products/presentation/screens/product_list_screen.dart';
import 'package:fresshi/features/search/presentation/screens/search_screen.dart';
import 'package:fresshi/routes/app_routes.dart';

final appRouter = GoRouter(
  initialLocation: AppRoutes.home,
  routes: [
    GoRoute(
      path: AppRoutes.home,
      name: AppRoutes.homeName,
      builder: (context, state) => const HomeScreen(),
    ),
    GoRoute(
      path: AppRoutes.productList,
      name: AppRoutes.productListName,
      builder: (context, state) => const ProductListScreen(),
    ),
    GoRoute(
      path: AppRoutes.productDetail,
      name: AppRoutes.productDetailName,
      builder: (context, state) {
        final id = int.parse(state.pathParameters['id']!);
        return ProductDetailScreen(productId: id);
      },
    ),
    GoRoute(
      path: AppRoutes.search,
      name: AppRoutes.searchName,
      builder: (context, state) => const SearchScreen(),
    ),
    GoRoute(
      path: AppRoutes.cart,
      name: AppRoutes.cartName,
      builder: (context, state) => const CartScreen(),
    ),
    GoRoute(
      path: AppRoutes.login,
      name: AppRoutes.loginName,
      builder: (context, state) => const LoginScreen(),
    ),
    GoRoute(
      path: AppRoutes.register,
      name: AppRoutes.registerName,
      builder: (context, state) => const RegisterScreen(),
    ),
    GoRoute(
      path: AppRoutes.support,
      name: AppRoutes.supportName,
      builder: (context, state) => const _SupportPlaceholderScreen(),
    ),
  ],
);

/// Temporary placeholder until the support feature is implemented.
class _SupportPlaceholderScreen extends StatelessWidget {
  const _SupportPlaceholderScreen();

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(child: Text('Support — coming soon')),
    );
  }
}
