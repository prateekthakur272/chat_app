import 'package:envied/envied.dart';

part 'env.g.dart';

@Envied()
abstract class Env{
  @EnviedField()
  static String SUPERBASE_URL = _Env.SUPERBASE_URL;
  @EnviedField()
  static String SUPERBASE_ANON_KEY = _Env.SUPERBASE_ANON_KEY;
  @EnviedField()
  static String SUPERBASE_SERVICE_ROLE_KEY = _Env.SUPERBASE_SERVICE_ROLE_KEY;
}