import 'package:gear/controllers/registrationCustomer_controller.dart';
import 'package:get_it/get_it.dart';


// Create an instance of GetIt
final GetIt getIt = GetIt.instance;

// Register your controller in the service locator
void setup() {
  getIt.registerLazySingleton<RegistrationController>(() => RegistrationController());
}
