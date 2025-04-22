import 'package:provide_boiler_plate/models/generic_response_model.dart';

abstract class LoginService
{
  Future<GenericResponse>  login(String username,String password);
}