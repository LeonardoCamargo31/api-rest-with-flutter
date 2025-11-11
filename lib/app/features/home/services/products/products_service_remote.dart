import 'package:app_test_fiap/app/core/client/api_client.dart';
import 'package:app_test_fiap/app/core/network/response_types/response.dart';
import 'package:app_test_fiap/app/features/home/model/product_model.dart';
import 'package:app_test_fiap/app/features/home/services/products/products_service.dart';
import 'package:dio/dio.dart' hide Response;

class ProductsServiceRemote implements ProductsService {


  @override
  Future<({ProductModel? product, Response result})> createProduct(ProductModel product) async {
    try {

      final productJson = product.toJson();
      final result = await ApiClient.client.post('/api/v1/products/',
        data: productJson,
      );

      if (result.statusCode == 201) {
        return (product: product, result: const Success());
      }
      return (product: product, result: const GeneralFailure(message: "Failed to create product"));
    } catch (e) {
      print (e);
      return (product: product, result: const GeneralFailure(message: "Failed to create product"));
    }
  }

  @override
  Future<({Response result, bool success})> deleteProduct(int id) {
    // TODO: implement deleteProduct
    throw UnimplementedError();
  }

  @override
  Future<({List<ProductModel> products, Response result})> getProducts() async {
    final result = await ApiClient.client.get('/api/v1/products');
    final data = result.data as List;
    final products = data.map((e) => ProductModel.fromJson(e)).toList();
    return (products: products, result: const Success());
  }

  @override
  Future<({ProductModel? product, Response result})> getProduct(int id) {
    // TODO: implement getProduct
    throw UnimplementedError();
  }

  @override
  Future<({ProductModel? product, Response result})> updateProduct(int id, ProductModel product) {
    // TODO: implement updateProduct
    throw UnimplementedError();
  }
}