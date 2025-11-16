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
      await ApiClient.client.post('/api/v1/products/',
        data: productJson,
      );
      return (product: product, result: const Success());
    } on DioException catch (e) {
      if (e.response?.statusCode == 400){
        return (product: null, result: const GeneralFailure(message: "Erros nos dados enviados"));
      } else if  (e.response?.statusCode == 404){
        return (product: null, result: const GeneralFailure(message: "Produto não encontrado"));
      }
      return (product: null, result: const GeneralFailure(message: "Erro genérico"));
    } catch (e) {
      return (product: null, result: const GeneralFailure(message: "Erro genérico"));
    }
  }

  @override
  Future<({Response result, bool success})> deleteProduct(int id) async {
    try {
      await ApiClient.client.delete('/api/v1/products/$id');
      return (result: const Success(), success: true);
    } on DioException catch (e) {
      if (e.response?.statusCode == 400){
        return (success: false, result: const GeneralFailure(message: "Erros nos dados enviados"));
      } else if  (e.response?.statusCode == 404){
        return (success: false, result: const GeneralFailure(message: "Produto não encontrado"));
      }
      return (success: false, result: const GeneralFailure(message: "Erro genérico"));
    } catch (e) {
      return (success: false, result: const GeneralFailure(message: "Erro genérico"));
    }
  }

  @override
  Future<({List<ProductModel> products, Response result})> getProducts() async {
    try {
      final result = await ApiClient.client.get('/api/v1/products');
      final data = result.data as List;
      final products = data.map((e) => ProductModel.fromJson(e)).toList();
      return (products: products, result: const Success());
    } on DioException catch (e) {
      if (e.response?.statusCode == 400){
        return (products: <ProductModel>[], result: const GeneralFailure(message: "Erros nos dados enviados"));
      } else if  (e.response?.statusCode == 404){
        return (products: <ProductModel>[], result: const GeneralFailure(message: "Produto não encontrado"));
      }
      return (products: <ProductModel>[], result: const GeneralFailure(message: "Erro genérico"));
    } catch (e) {
      return (products: <ProductModel>[], result: const GeneralFailure(message: "Erro genérico"));
    }
  }

  @override
  Future<({ProductModel? product, Response result})> getProduct(int id) async {
    try {
      final result = await ApiClient.client.get('/api/v1/products/$id');
      final product = ProductModel.fromJson(result.data);
      return (product: product, result: const Success());
    } on DioException catch (e) {
      if (e.response?.statusCode == 400){
        return (product: null, result: const GeneralFailure(message: "Erros nos dados enviados"));
      } else if  (e.response?.statusCode == 404){
        return (product: null, result: const GeneralFailure(message: "Produto não encontrado"));
      }
      return (product: null, result: const GeneralFailure(message: "Erro genérico"));
    } catch (e) {
      return (product: null, result: const GeneralFailure(message: "Erro genérico"));
    }
  }

  @override
  Future<({ProductModel? product, Response result})> updateProduct(int id, ProductModel product) async {
    try {
      final productJson = product.toJson();
      await ApiClient.client.put('/api/v1/products/${id}',
        data: productJson,
      );
      return (product: product, result: const Success());
    } on DioException catch (e) {
      if (e.response?.statusCode == 400){
        return (product: null, result: const GeneralFailure(message: "Erros nos dados enviados"));
      } else if  (e.response?.statusCode == 404){
        return (product: null, result: const GeneralFailure(message: "Produto não encontrado"));
      }
      return (product: null, result: const GeneralFailure(message: "Erro genérico"));
    } catch (e) {
      return (product: null, result: const GeneralFailure(message: "Erro genérico"));
    }
  }
}