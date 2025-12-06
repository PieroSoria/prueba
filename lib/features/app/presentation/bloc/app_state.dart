part of 'app_bloc.dart';

enum AppMethod {
  none,
  getLocal,
  getListApi,
  getListLocal,
  searchApi,
  save,
  edit,
  deleted,
}

enum ErrorTypeState { none, network, local, unknown }

enum StateStatus { none, loading, success, failure }

class AppState extends Equatable {
  final AppMethod? appMethod;
  final StateStatus? stateStatus;
  final ErrorTypeState? errorTypeState;
  final String? title;
  final String? message;
  final List<ProductEntity>? listProducts;
  final List<ProductEntity>? filteredListProducts;
  final List<ProductEntity>? listProductsLocal;
  final ProductEntity? productEntity;
  const AppState({
    this.appMethod,
    this.stateStatus,
    this.errorTypeState,
    this.title,
    this.message,
    this.listProducts,
    this.filteredListProducts,
    this.listProductsLocal,
    this.productEntity,
  });

  factory AppState.initialState() => AppState(
    listProducts: [],
    filteredListProducts: [],
    listProductsLocal: [],
  );

  AppState copyWith({
    AppMethod? appMethod,
    StateStatus? stateStatus,
    ErrorTypeState? errorTypeState,
    String? title,
    String? message,
    List<ProductEntity>? listProducts,
    List<ProductEntity>? filteredListProducts,
    List<ProductEntity>? listProductsLocal,
    ProductEntity? productEntity,
  }) => AppState(
    appMethod: appMethod ?? this.appMethod,
    stateStatus: stateStatus ?? this.stateStatus,
    errorTypeState: errorTypeState ?? this.errorTypeState,
    title: title ?? this.title,
    message: message ?? this.message,
    listProducts: listProducts ?? this.listProducts,
    filteredListProducts: filteredListProducts ?? this.filteredListProducts,
    listProductsLocal: listProductsLocal ?? this.listProductsLocal,
    productEntity: productEntity ?? this.productEntity,
  );

  @override
  List<Object?> get props => [
    appMethod,
    stateStatus,
    errorTypeState,
    title,
    message,
    listProducts,
    filteredListProducts,
    listProductsLocal,
    productEntity,
  ];
}

extension AppStateX on AppState {
  bool get listProductsEmpty => (listProducts ?? []).isEmpty;
  bool get listProductsLocalEmpty => (listProductsLocal ?? []).isEmpty;

  bool get productGetListApiLoading =>
      appMethod == AppMethod.getListApi && stateStatus == StateStatus.loading;
  bool get productGetListApiSuccess =>
      appMethod == AppMethod.getListApi && stateStatus == StateStatus.success;
  bool get productGetListApiFailure =>
      appMethod == AppMethod.getListApi &&
      stateStatus == StateStatus.failure &&
      errorTypeState == ErrorTypeState.network;
  bool get productGetListApiUnkNown =>
      appMethod == AppMethod.getListApi &&
      errorTypeState == ErrorTypeState.unknown;

  bool get productGetLocalLoading =>
      appMethod == AppMethod.getLocal && stateStatus == StateStatus.loading;
  bool get productGetLocalSuccess =>
      appMethod == AppMethod.getLocal && stateStatus == StateStatus.success;
  bool get productGetLocalFailure =>
      appMethod == AppMethod.getLocal &&
      stateStatus == StateStatus.failure &&
      errorTypeState == ErrorTypeState.local;
  bool get productGetLocalUnkNown =>
      appMethod == AppMethod.getLocal &&
      errorTypeState == ErrorTypeState.unknown;
  bool get productGetListLocalLoading =>
      appMethod == AppMethod.getListLocal && stateStatus == StateStatus.loading;
  bool get productGetListLocalSuccess =>
      appMethod == AppMethod.getListLocal && stateStatus == StateStatus.success;
  bool get productGetListLocalFailure =>
      appMethod == AppMethod.getListLocal &&
      stateStatus == StateStatus.failure &&
      errorTypeState == ErrorTypeState.local;
  bool get productGetListLocalUnkNown =>
      appMethod == AppMethod.getListLocal &&
      errorTypeState == ErrorTypeState.unknown;
  bool get productSaveLocalLoading =>
      appMethod == AppMethod.save && stateStatus == StateStatus.loading;
  bool get productSaveLocalSuccess =>
      appMethod == AppMethod.save && stateStatus == StateStatus.success;
  bool get productSaveLocalFailure =>
      appMethod == AppMethod.save &&
      stateStatus == StateStatus.failure &&
      errorTypeState == ErrorTypeState.local;
  bool get productSaveLocalUnkNown =>
      appMethod == AppMethod.save && errorTypeState == ErrorTypeState.unknown;
  bool get productEditLocalLoading =>
      appMethod == AppMethod.edit && stateStatus == StateStatus.loading;
  bool get productEditLocalSuccess =>
      appMethod == AppMethod.edit && stateStatus == StateStatus.success;
  bool get productEditLocalFailure =>
      appMethod == AppMethod.edit &&
      stateStatus == StateStatus.failure &&
      errorTypeState == ErrorTypeState.local;
  bool get productEditLocalUnkNown =>
      appMethod == AppMethod.edit && errorTypeState == ErrorTypeState.unknown;
  bool get productDeletedLocalLoading =>
      appMethod == AppMethod.deleted && stateStatus == StateStatus.loading;
  bool get productDeletedLocalSuccess =>
      appMethod == AppMethod.deleted && stateStatus == StateStatus.success;
  bool get productDeletedLocalFailure =>
      appMethod == AppMethod.deleted &&
      stateStatus == StateStatus.failure &&
      errorTypeState == ErrorTypeState.local;
  bool get productDeletedLocalUnkNown =>
      appMethod == AppMethod.deleted &&
      errorTypeState == ErrorTypeState.unknown;
}
