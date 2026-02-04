import 'package:bloc_test/bloc_test.dart';
import 'package:rick_and_morty/domain/bloc/home/home_bloc.dart';

class MockHomeBloc extends MockBloc<HomeEvent, HomeState> implements HomeBloc {}
