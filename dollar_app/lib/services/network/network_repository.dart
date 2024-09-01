import 'package:dollar_app/services/network/network_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class NetworkRepository extends NetworkService {
  NetworkRepository({required super.ref});

  Future<Map<String, dynamic>> postRequest(
      {required String path, dynamic body}) async {
    final response = await post(path, data: body);
    return response.data;
  }

  Future<Map<String, dynamic>> getRequest({required String path}) async {
    final response = await get(path);
    return response.data;
  }

   Future<Map<String, dynamic>> deleteRequest({required String path}) async {
    final response = await delete(path);
    return response.data;
  }

  Future<Map<String, dynamic>> putRequest({required String path, dynamic body}) async {
    final response = await put(path,data: body);
    return response.data;
  }
}

final networkProvider = Provider((ref) => NetworkRepository(ref: ref));
