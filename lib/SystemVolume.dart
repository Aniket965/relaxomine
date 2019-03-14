import 'package:rxdart/rxdart.dart';
class SystemVolume {
  BehaviorSubject _volSys =BehaviorSubject.seeded(0.75);
  Observable get stream$ => _volSys.stream;
  int get current => _volSys.value;
 change(double val) {
    _volSys.value = val;
  }
}
 SystemVolume systemVolume =SystemVolume();