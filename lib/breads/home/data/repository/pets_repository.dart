import 'package:breads/breads/home/data/model/pet_model_response.dart';
import 'package:breads/breads/home/data/network/pet_service.dart';
import 'package:breads/core/networking/api_error_handler.dart';
import 'package:breads/core/networking/api_result.dart';

class PetsRepository {
  final PetService petService;

  const PetsRepository(this.petService);

  Future<ApiResult<List<PetModelResponse>>> fetchAllPets({limit, page}) async {
    try {
      final response = await petService.fetchPets(limit: limit, page: page);
      return Success(response);
    } catch (error) {
      return Failure(
          ApiErrorHandler.handle(error).errorModel.message.toString());
    }
  }
}
