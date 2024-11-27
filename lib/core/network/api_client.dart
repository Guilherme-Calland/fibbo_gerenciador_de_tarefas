import 'package:dio/dio.dart';
import 'package:gerenciador_de_tarefas/core/network/api_response.dart';

class ApiClient{
  final _dio = Dio();

  ApiClient._();

  static ApiClient? _instance;

  static getInstance(){
    _instance ??= ApiClient._();
    return _instance;
  }

  Future<ApiResponse<Map<String, dynamic>>> get(String path) async {
    final response = await _dio.get(path);
    
    bool internalServerError = response.statusCode == 500;
    bool validResponseType = response.data is Map<String, dynamic>;
    return ApiResponse(response.statusCode, (){
      if(internalServerError){
        return null;
      }else if(validResponseType){
        return response.data;
      }else{
        return {};
      }
    }());
  }
}