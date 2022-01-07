import 'package:flutter_pet/base/base_page_presenter.dart';
import 'package:flutter_pet/entity/pet_type_entity.dart';
import 'package:flutter_pet/net/api.dart';
import 'package:flutter_pet/page/other/page/select_list_date_page.dart';

class SelectListDataPresenter extends BasePagePresenter {
  void getList(String type) {
    // if (type == SelectListDataPage.TYPE_PET) {
      getPetList();
    // }
  }

  void getPetList() {
    var paramters = <String, dynamic>{};
    paramters["type"] = "PET_TYPE_DOG";
    asyncRequestNetwork<List<PetTypeEntity>>(
        url: Api.petTypeList,
        queryParameters: paramters,
        onSuccess: (data) => {print("${data![0].toJson()}")},
        onError: (code, error) => {
          print(code)
        });
  }
}
