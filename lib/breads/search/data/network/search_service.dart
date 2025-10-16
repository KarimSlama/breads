import 'package:breads/breads/home/data/model/pet_model_response.dart';
import 'package:breads/breads/home/data/network/pet_constants.dart';
import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

import '../../../../core/networking/api_constants.dart';
part 'search_service.g.dart';

@RestApi(baseUrl: ApiConstants.baseUrl)
abstract class SearchService {
  factory SearchService(Dio dio, {String baseUrl}) = _SearchService;

  @GET(PetConstants.search)
  Future<List<PetModelResponse>> searchPets(@Query("q") String q);
}
