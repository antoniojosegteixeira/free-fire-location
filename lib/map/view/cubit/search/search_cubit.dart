import 'package:bloc/bloc.dart';
import 'package:free_fire_location/map/view/cubit/search/search_state.dart';

class SearchCubit extends Cubit<SearchState> {
  SearchCubit() : super(SearchInitial());
}
