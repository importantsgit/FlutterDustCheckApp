import 'package:flutter_dust/air_result.dart';
import 'package:flutter_dust/bloc/air_fetch_bloc.dart';
import 'package:rxdart/rxdart.dart';

class AirBloc {
  final _repository = AirFetchbloc();
  final _airSubject = BehaviorSubject<AirResult>();

  AirBloc() {
    fetch();
  }

  void fetch() async {
    var airResult = await _repository.fetchData();
    _airSubject.add(airResult);
  }

  Stream<AirResult> get airResult => _airSubject.stream;
}
