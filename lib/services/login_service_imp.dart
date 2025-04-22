
import 'package:dio/dio.dart';
import 'package:provide_boiler_plate/models/generic_response_model.dart';
import 'package:provide_boiler_plate/services/login_service.dart';

class LoginServiceImp extends LoginService
{
  Dio? dio;

  LoginServiceImp(this.dio);

  @override
  Future<GenericResponse> login(String username, String password) async {
    var response = new GenericResponse();
    var url = "loginApiPath";

    try {
      var httpResponse = await dio?.get(url);

      if (httpResponse?.statusCode == 200)
        return GenericResponse.fromMap(httpResponse?.data);

      response.message = httpResponse?.statusMessage;
      response.hasError = true;
    } catch (e) {
      response.message = "Something went wrong";
      response.hasError = true;
    }
    return response;
  }

}


