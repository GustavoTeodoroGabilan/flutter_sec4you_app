import 'lib/service/security_event_service.dart';

void main() {
  print('🔍 Testando endpoints do SecurityEventService...');
  
  // Simula uma chamada para ver que endpoints são usados
  print('📍 Testando se está usando IP correto (10.0.0.168)...');
  
  // O teste vai mostrar nos logs que endpoints estão sendo usados
  SecurityEventService.logLoginAttempt(
    email: 'teste@exemplo.com',
    success: false,
    errorCode: 'test',
    errorMessage: 'Teste de endpoint',
  );
}
