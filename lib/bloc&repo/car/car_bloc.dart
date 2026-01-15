import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tripto/bloc&repo/car/car_repository.dart';
import 'car_event.dart';
import 'car_state.dart';

class CarBloc extends Bloc<CarEvent, CarState> {
  final CarRepository repo;

  CarBloc(this.repo) : super(CarInitial()) {
    on<LoadCars>((event, emit) async {
      emit(CarLoading());
      try {
        final cars = await repo.fetchCars(
          subDestinationId: event.subDestinationId,
          category: event.category,
        );
        emit(CarLoaded(cars));
      } catch (e) {
        emit(CarError('No Internet connection'));
      }
    });

    on<LoadAllCars>((event, emit) async {
      emit(CarLoading());
      try {
        final allCars =
            await repo.fetchAllCars(); // لازم تكون موجودة في الـ repo
        emit(GetAllCarsSuccess(allCars));
      } catch (e) {
        emit(CarError('No Internet connection'));
      }
    });
  }
}
