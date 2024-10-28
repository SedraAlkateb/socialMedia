import 'package:untitled11/app/constants.dart';
import 'package:untitled11/app/user_info.dart';
import 'package:untitled11/data/responses/responses.dart';
import 'package:untitled11/domain/models/models.dart';
/*
extension BrandsSpRequestMapper on BrandSpResponse? {
  BrandSpModel toDomain() {
    return BrandSpModel(
      int.parse(this?.id ?? "0") ,
      int.parse(this?.spId ?? "0") ,
      int.parse(this?.brandId ?? "0") ,
      this?.brandType?? Constants.empty,
    );
  }
}
extension ListBrandsSpRequestMapper on AllBrandSpBaseResponse? {
  List<BrandSpModel> toDomain() {
    List<BrandSpModel> brandSpModels =(this?.data?.brandsSpecializations?.map((response) => response.toDomain()) ??
        const Iterable.empty())
        .cast<BrandSpModel>()
        .toList();
    return brandSpModels;
  }
}
 */