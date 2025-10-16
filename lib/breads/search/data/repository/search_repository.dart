import 'package:breads/breads/home/data/model/pet_model_response.dart';
import 'package:breads/breads/search/data/network/search_service.dart';
import 'package:breads/core/networking/api_error_handler.dart';
import 'package:breads/core/networking/api_result.dart';

class SearchRepository {
  final SearchService searchService;

  SearchRepository(this.searchService);

  Future<ApiResult<List<PetModelResponse>>> searchPets(query) async {
    try {
      final response = await searchService.searchPets(query);
      return Success(response);
    } catch (error) {
      return Failure(
          ApiErrorHandler.handle(error).errorModel.message.toString());
    }
  }
}
