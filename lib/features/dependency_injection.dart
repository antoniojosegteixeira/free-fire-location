import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:free_fire_location/core/infra/http_request.dart';
import 'package:free_fire_location/features/map/data/datasources/fire_info_datasource_inpe.dart';
import 'package:free_fire_location/features/map/data/datasources/fire_info_datasource_nasa.dart';
import 'package:free_fire_location/features/map/data/datasources/firebase_datasource_impl.dart';
import 'package:free_fire_location/features/map/data/datasources/places_autocomplete_datasource.dart';
import 'package:free_fire_location/features/map/data/datasources/places_info_datasource.dart';
import 'package:free_fire_location/features/map/data/datasources/weather_info_datasource.dart';
import 'package:free_fire_location/features/map/data/repositories/fire_info_repository_impl.dart';
import 'package:free_fire_location/features/map/data/repositories/firebase_repository_impl.dart';
import 'package:free_fire_location/features/map/data/repositories/places_repository_impl.dart';
import 'package:free_fire_location/features/map/data/repositories/weather_info_repository_impl.dart';

import 'package:free_fire_location/features/map/domain/usecases/get_fire_info_inpe_usecase.dart';
import 'package:free_fire_location/features/map/domain/usecases/get_fire_info_nasa_usecase.dart';
import 'package:free_fire_location/features/map/domain/usecases/get_places_autocomplete_usecase.dart';
import 'package:free_fire_location/features/map/domain/usecases/get_places_info_usecase.dart';
import 'package:free_fire_location/features/map/domain/usecases/get_user_fires_usecase.dart';
import 'package:free_fire_location/features/map/domain/usecases/get_weather_info_usecase.dart';
import 'package:free_fire_location/features/map/domain/usecases/post_user_fire_usecase.dart';
import 'package:free_fire_location/features/map/view/cubit/fire/fire_cubit.dart';
import 'package:free_fire_location/features/map/view/cubit/location/location_cubit.dart';
import 'package:free_fire_location/features/map/view/cubit/map_controller/map_controller_cubit.dart';
import 'package:free_fire_location/features/map/view/cubit/options/options_cubit.dart';
import 'package:free_fire_location/features/map/view/cubit/places_search/places_search_cubit.dart';
import 'package:free_fire_location/features/map/view/cubit/user_fire/user_fire_cubit.dart';
import 'package:free_fire_location/features/map/view/cubit/weather_info/weather_info_cubit.dart';
import 'package:get_it/get_it.dart';

class DependencyInjection {
  final i = GetIt.instance;

  void setup() {
    // Http Client
    i.registerSingleton<Dio>(
      Dio(),
    );
    i.registerSingleton<HttpRequest>(
      HttpRequest(dio: i<Dio>()),
    );
    // Datasources
    i.registerSingleton<FireInfoDatasourceInpe>(
      FireInfoDatasourceInpe(client: i<HttpRequest>()),
    );
    i.registerSingleton<FireInfoDatasourceNasa>(
      FireInfoDatasourceNasa(client: i<HttpRequest>()),
    );
    i.registerSingleton<WeatherInfoDatasourceImpl>(
      WeatherInfoDatasourceImpl(client: i<HttpRequest>()),
    );
    i.registerSingleton<PlacesInfoDatasourceImpl>(
      PlacesInfoDatasourceImpl(client: i<HttpRequest>()),
    );
    i.registerSingleton<PlacesAutocompleteDatasourceImpl>(
      PlacesAutocompleteDatasourceImpl(client: i<HttpRequest>()),
    );
    i.registerSingleton<FirebaseDatasourceImpl>(
      FirebaseDatasourceImpl(database: FirebaseFirestore.instance),
    );

    // Repositories
    i.registerSingleton<FireInfoRepositoryImpl>(
      FireInfoRepositoryImpl(
          datasourceNasa: i<FireInfoDatasourceNasa>(),
          datasourceInpe: i<FireInfoDatasourceInpe>()),
    );
    i.registerSingleton<PlacesRepositoryImpl>(
      PlacesRepositoryImpl(
        datasourceInfo: i<PlacesInfoDatasourceImpl>(),
        datasourceAutocomplete: i<PlacesAutocompleteDatasourceImpl>(),
      ),
    );
    i.registerSingleton<WeatherInfoRepositoryImpl>(
      WeatherInfoRepositoryImpl(
        datasource: i<WeatherInfoDatasourceImpl>(),
      ),
    );
    i.registerSingleton<FirebaseRepositoryImpl>(
      FirebaseRepositoryImpl(
        datasource: i<FirebaseDatasourceImpl>(),
      ),
    );

    // Usecases
    i.registerSingleton<GetFireInfoInpeUsecase>(
      GetFireInfoInpeUsecase(repository: i<FireInfoRepositoryImpl>()),
    );

    i.registerSingleton<GetFireInfoNasaUsecase>(
      GetFireInfoNasaUsecase(repository: i<FireInfoRepositoryImpl>()),
    );

    i.registerSingleton<GetWeatherInfoUsecase>(
      GetWeatherInfoUsecase(repository: i<WeatherInfoRepositoryImpl>()),
    );

    i.registerSingleton<GetPlacesInfoUsecase>(
        GetPlacesInfoUsecase(repository: i<PlacesRepositoryImpl>()));

    i.registerSingleton<GetPlacesAutocompleteUsecase>(
        GetPlacesAutocompleteUsecase(repository: i<PlacesRepositoryImpl>()));

    i.registerSingleton<GetUserFiresUsecase>(
        GetUserFiresUsecase(repository: i<FirebaseRepositoryImpl>()));

    i.registerSingleton<PostUserFireUsecase>(
        PostUserFireUsecase(repository: i<FirebaseRepositoryImpl>()));

    // Bloc / Cubit
    i.registerSingleton<WeatherInfoCubit>(
      WeatherInfoCubit(
        getWeatherInfoUsecase: i<GetWeatherInfoUsecase>(),
      ),
    );
    i.registerSingleton<FireCubit>(
      FireCubit(
        getFireInfoInpeUsecase: i<GetFireInfoInpeUsecase>(),
        getFireInfoNasaUsecase: i<GetFireInfoNasaUsecase>(),
        weatherInfoCubit: i<WeatherInfoCubit>(),
      ),
    );
    i.registerSingleton<OptionsCubit>(
      OptionsCubit(),
    );

    i.registerSingleton<LocationCubit>(
      LocationCubit(),
    );
    i.registerSingleton<PlacesSearchCubit>(
      PlacesSearchCubit(
        placesAutocompleteUsecase: i<GetPlacesAutocompleteUsecase>(),
        placesInfoUsecase: i<GetPlacesInfoUsecase>(),
      ),
    );
    i.registerSingleton<MapControllerCubit>(
      MapControllerCubit(),
    );
    i.registerSingleton<UserFireCubit>(
      UserFireCubit(
        weatherInfoCubit: i<WeatherInfoCubit>(),
        getUserFiresUsecase: i<GetUserFiresUsecase>(),
        postUserFiresUsecase: i<PostUserFireUsecase>(),
      ),
    );
  }
}
