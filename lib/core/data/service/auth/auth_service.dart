import 'package:dio/dio.dart';
import 'package:good_trip/core/data/api/urls.dart';
import 'package:good_trip/core/data/models/auth/auth_request.dart';
import 'package:good_trip/core/data/models/auth/auth_response.dart';
import 'package:good_trip/core/data/models/auth/login_request.dart';
import 'package:good_trip/core/data/models/auth/refresh_token.dart';
import 'package:good_trip/core/data/models/user/user_dto.dart';
import 'package:retrofit/http.dart';

part 'auth_service.g.dart';

@RestApi()
abstract class AuthService {
  factory AuthService(Dio dio, {String baseUrl}) = _AuthService;

  @GET('${Urls.user}/{user_id}')
  Future<UserDto> getUserById({
    @Path('user_id') required String userId,
  });

  @POST(Urls.refresh)
  Future<RefreshToken> refreshToken({
    @Body() required String refreshToken,
  });

  @POST(Urls.register)
  Future<AuthResponse> register({
    @Body() required AuthRequest authRequest,
  });

  @POST(Urls.login)
  Future<AuthResponse> login({
    @Body() required LoginRequest loginRequest,
  });
}
