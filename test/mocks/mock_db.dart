import 'package:mocktail/mocktail.dart';
import 'package:rick_and_morty/domain/db/i_db.dart';

class MockDb extends Mock implements ILocalDataSource {}
