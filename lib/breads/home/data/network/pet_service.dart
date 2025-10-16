import 'package:breads/breads/home/data/model/pet_model_response.dart';
import 'package:breads/breads/home/data/network/pet_constants.dart';
import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

import '../../../../core/networking/api_constants.dart';
part 'pet_service.g.dart';

@RestApi(baseUrl: ApiConstants.baseUrl)
abstract class PetService {
  factory PetService(Dio dio, {String baseUrl}) = _PetService;

  @GET(PetConstants.breeds)
  Future<List<PetModelResponse>> fetchPets({
    @Query("limit") int limit = 10,
    @Query("page") int page = 1,
  });
}
