part of 'app_bloc.dart';

abstract class AppEvent extends Equatable {
  factory AppEvent.onGetListProductDataApi() => _OnGetListProductDataApi();
  factory AppEvent.onGetListProductDataLocal() => _OnGetListProductDataLocal();
  factory AppEvent.onGetProductDataLocal({int? id}) =>
      _OnGetProductDataLocal(id: id);
  factory AppEvent.onSelectProductData({
    required ProductEntity productEntity,
  }) => _OnSelectProductData(productEntity: productEntity);
  factory AppEvent.onSaveProductDataLocal({
    required ProductEntity productEntity,
  }) => _OnSaveProductDataLocal(productEntity: productEntity);
  factory AppEvent.onDeletedProductDataLocal({required int id}) =>
      _OnDeletedProductDataLocal(id: id);
  factory AppEvent.onUpdatedProductDataLocal({
    required ProductEntity productEntity,
  }) => _OnUpdatedProductDataLocal(productEntity: productEntity);
  factory AppEvent.onSearchProductDataApi({required String query}) =>
      _OnSearchProductDataApi(query: query);

  @override
  List<Object?> get props => [];
}

class _OnSearchProductDataApi implements AppEvent {
  final String query;

  _OnSearchProductDataApi({required this.query});
  @override
  List<Object?> get props => [query];
  @override
  bool? get stringify => throw UnimplementedError();
}

class _OnUpdatedProductDataLocal implements AppEvent {
  final ProductEntity? productEntity;

  _OnUpdatedProductDataLocal({required this.productEntity});
  @override
  // TODO: implement props
  List<Object?> get props => [productEntity];

  @override
  // TODO: implement stringify
  bool? get stringify => throw UnimplementedError();
}

class _OnSelectProductData implements AppEvent {
  final ProductEntity? productEntity;

  _OnSelectProductData({required this.productEntity});
  @override
  // TODO: implement props
  List<Object?> get props => [productEntity];

  @override
  // TODO: implement stringify
  bool? get stringify => throw UnimplementedError();
}

class _OnGetProductDataLocal implements AppEvent {
  final int? id;

  _OnGetProductDataLocal({required this.id});
  @override
  // TODO: implement props
  List<Object?> get props => [id];

  @override
  // TODO: implement stringify
  bool? get stringify => throw UnimplementedError();
}

class _OnDeletedProductDataLocal implements AppEvent {
  final int id;

  _OnDeletedProductDataLocal({required this.id});
  @override
  // TODO: implement props
  List<Object?> get props => [id];

  @override
  // TODO: implement stringify
  bool? get stringify => throw UnimplementedError();
}

class _OnSaveProductDataLocal implements AppEvent {
  final ProductEntity? productEntity;

  _OnSaveProductDataLocal({required this.productEntity});
  @override
  // TODO: implement props
  List<Object?> get props => [productEntity];

  @override
  // TODO: implement stringify
  bool? get stringify => throw UnimplementedError();
}

class _OnGetListProductDataLocal implements AppEvent {
  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();

  @override
  // TODO: implement stringify
  bool? get stringify => throw UnimplementedError();
}

class _OnGetListProductDataApi implements AppEvent {
  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();

  @override
  // TODO: implement stringify
  bool? get stringify => throw UnimplementedError();
}
