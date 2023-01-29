import 'package:equatable/equatable.dart';
import 'package:free_fire_location/features/map/domain/entities/fire_info_entity.dart';

class FirePageEntity extends Equatable {
  final List<FireInfoEntity> coordinatesList;

  const FirePageEntity({
    required this.coordinatesList,
  });

  @override
  List<Object> get props => [coordinatesList];
}
