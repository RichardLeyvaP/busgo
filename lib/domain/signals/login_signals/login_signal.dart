import 'package:BusGo/models/login/login_model.dart';
import 'package:signals/signals.dart';

// Definimos las señales
final Signal<bool?> isLoggedInLG = Signal<bool?>(null);
final Signal<String> loginMessageLG = Signal<String>(""); // Mensaje de error o éxito
final Signal<String> passwordMessageLG = Signal<String>(""); // Mensaje de error o éxito
final Signal<String> typeCmpanyBranchLG = Signal<String>(""); // Mensaje de error o éxito
final Signal<int?> idCmpanyBranchLG = Signal<int?>(null); // Mensaje de error o éxito
final Signal<Login?> currentUserLG = Signal<Login?>(null); // Usuario actual
final Signal<Branch?> currentUserBranchLG = Signal<Branch?>(null); // Usuario actual
final Signal<Company?> currentUserBranchCompanyLG = Signal<Company?>(null); // Usuario actual
final Signal<bool> isLoadingLG = Signal<bool>(false); // Estado de carga
final Signal<bool> passwordTrueMessageLG = Signal<bool>(false); // Estado de carga
final Signal<bool> isLoginErrorLG = Signal<bool>(false); // Estado de carga
