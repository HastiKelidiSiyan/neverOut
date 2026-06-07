import 'package:flutter_test/flutter_test.dart';
import 'package:never_out/app/my_app.dart';
import 'package:never_out/models/product_model.dart';
import 'package:never_out/providers/products_provider.dart';
import 'package:never_out/repositories/product_repository.dart';

void main() {
  testWidgets('renders root product tabs', (WidgetTester tester) async {
    await tester.pumpWidget(
      ProductsProviderScope(
        provider: ProductsProvider(_FakeProductRepository()),
        child: const MyApp(),
      ),
    );

    expect(find.text('RanOut'), findsOneWidget);
    expect(find.text('Ran Out'), findsOneWidget);
    expect(find.text('Normal'), findsOneWidget);
  });
}

class _FakeProductRepository extends ProductRepository {
  @override
  Future<List<ProductModel>> getProducts() async {
    return [];
  }

  @override
  Future<void> addProduct(ProductModel product) async {}

  @override
  Future<void> updateProduct(ProductModel product) async {}

  @override
  Future<void> deleteProduct(ProductModel product) async {}
}
