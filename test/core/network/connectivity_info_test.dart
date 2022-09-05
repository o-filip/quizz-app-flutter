import 'package:flutter_test/flutter_test.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:quiz_app/core/network/connectivity_info.dart';

import 'connectivity_info_test.mocks.dart';

@GenerateMocks([InternetConnectionChecker])
void main() {
  late MockInternetConnectionChecker mockConnectionChecker;
  late ConnectivityInfoImpl connectivityInfoImpl;

  setUp(() {
    mockConnectionChecker = MockInternetConnectionChecker();
    connectivityInfoImpl = ConnectivityInfoImpl(
      connectionChecker: mockConnectionChecker,
    );
  });

  group('ConnectivityInfoImpl', () {
    test('should return true when connectionChecker.hasConnection is true',
        () async {
      // Arrange
      when(mockConnectionChecker.hasConnection).thenAnswer((_) async => true);

      // Act
      final result = await connectivityInfoImpl.isConnected;

      // Assert
      expect(result, true);
      verify(mockConnectionChecker.hasConnection);
      verifyNoMoreInteractions(mockConnectionChecker);
    });

    test('should return false when connectionChecker.hasConnection is false',
        () async {
      // Arrange
      when(mockConnectionChecker.hasConnection).thenAnswer((_) async => false);

      // Act
      final result = await connectivityInfoImpl.isConnected;

      // Assert
      expect(result, false);
      verify(mockConnectionChecker.hasConnection);
      verifyNoMoreInteractions(mockConnectionChecker);
    });
  });
}
