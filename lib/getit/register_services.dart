import 'package:chatapp/services/auth_service.dart';
import 'package:get_it/get_it.dart';

Future<void> registerServices() async {
  final GetIt getIt=GetIt.instance;
  getIt.registerSingleton<AuthService>(AuthService());
}