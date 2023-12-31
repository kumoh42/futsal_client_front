import 'package:dio/dio.dart' hide Headers;
import 'package:futsal_client_front/common/dio/dio.dart';
import 'package:futsal_client_front/reservation_status/model/entity/pre_reservation/progress_reservation_entity.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:retrofit/retrofit.dart';

part 'progress_reservation_repository.g.dart';

final progressReservationRepositoryProvider = Provider((ref) {
  final dio = ref.watch(dioProvider);
  return ProgressReservationRepository(dio);
});

@RestApi()
abstract class ProgressReservationRepository {
  factory ProgressReservationRepository(Dio dio, {String baseUrl}) =
      _ProgressReservationRepository;

  @PUT("/reservation/pre/reopen")
  @Headers({'accessToken': 'true'})
  Future<void> setProgressReservationOpen();

  @PUT("/reservation/pre/stop")
  @Headers({'accessToken': 'true'})
  Future<void> setProgressReservationStop();

  @GET("/reservation/now/setting")
  @Headers({'accessToken': 'true'})
  Future<ProgressReservationEntity> getProgressReservation();

  @DELETE("/reservation/pre/reset")
  @Headers({'accessToken': 'true'})
  Future<void> reset();

  @PUT("reservation/pre-set?state=stop")
  @Headers({'accessToken': 'true'})
  Future<void> progressReservationStateStop();

  @PUT("reservation/pre-set?state=reopen")
  @Headers({'accessToken': 'true'})
  Future<void> progressReservationStateReStart();

  @PUT("reservation/pre-set?state=reset")
  @Headers({'accessToken': 'true'})
  Future<void> progressReservationStateReset();
}
