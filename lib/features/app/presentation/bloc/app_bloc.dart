import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:prueba/core/resources/data_state.dart';
import 'package:prueba/core/helpers/logger.dart';
import 'package:prueba/features/app/data/models/product_model.dart';
import 'package:prueba/features/app/domain/entities/product_entity.dart';
import 'package:prueba/features/app/domain/usecases/delete_product_local_use_case.dart';
import 'package:prueba/features/app/domain/usecases/edit_product_local_use_case.dart';
import 'package:prueba/features/app/domain/usecases/get_products_local_use_case.dart';
import 'package:prueba/features/app/domain/usecases/get_products_use_case.dart';
import 'package:prueba/features/app/domain/usecases/save_product_local_use_case.dart';

part 'app_event.dart';
part 'app_state.dart';

class AppBloc extends Bloc<AppEvent, AppState> {
  final GetProductsUseCase getProductsUseCase;
  final GetProductsLocalUseCase getProductsLocalUseCase;
  final SaveProductLocalUseCase saveProductLocalUseCase;
  final DeleteProductLocalUseCase deleteProductLocalUseCase;
  final EditProductLocalUseCase editProductLocalUseCase;
  AppBloc(
    this.getProductsUseCase,
    this.getProductsLocalUseCase,
    this.saveProductLocalUseCase,
    this.deleteProductLocalUseCase,
    this.editProductLocalUseCase,
  ) : super(AppState.initialState()) {
    on<_OnGetListProductDataApi>(_onGetListProductDataApi);
    on<_OnGetListProductDataLocal>(_onGetListProductDataLocal);
    on<_OnSaveProductDataLocal>(_onSaveProductDataLocal);
    on<_OnDeletedProductDataLocal>(_onDeletedProductDataLocal);
    on<_OnGetProductDataLocal>(_onGetProductDataLocal);
    on<_OnSelectProductData>(_onSelectProductData);
    on<_OnUpdatedProductDataLocal>(_onUpdatedProductDataLocal);
    on<_OnSearchProductDataApi>(_onSearchProductDataApi);
  }

  void _onGetListProductDataApi(
    _OnGetListProductDataApi event,
    Emitter<AppState> emit,
  ) async {
    try {
      emit(
        state.copyWith(
          appMethod: AppMethod.getListApi,
          stateStatus: StateStatus.loading,
        ),
      );

      final result = await getProductsUseCase();
      if (result is DataSuccess) {
        final listProduct = await compute(
          parseProductJsonList,
          result.response!.data['products'],
        );
        emit(
          state.copyWith(
            title: "Exito",
            message: "",
            listProducts: listProduct,
            appMethod: AppMethod.getListApi,
            stateStatus: StateStatus.success,
          ),
        );
      } else {
        emit(
          state.copyWith(
            title: result.errorMessage?.title,
            message: result.errorMessage?.message,
            appMethod: AppMethod.getListApi,
            stateStatus: StateStatus.failure,
            errorTypeState: ErrorTypeState.network,
          ),
        );
      }
    } catch (e) {
      emit(
        state.copyWith(
          title: "Error",
          message: e.toString(),
          appMethod: AppMethod.getListApi,
          errorTypeState: ErrorTypeState.unknown,
        ),
      );
    } finally {
      emit(
        state.copyWith(
          appMethod: AppMethod.none,
          stateStatus: StateStatus.none,
          errorTypeState: ErrorTypeState.none,
        ),
      );
    }
  }

  void _onGetListProductDataLocal(
    _OnGetListProductDataLocal event,
    Emitter<AppState> emit,
  ) async {
    try {
      emit(
        state.copyWith(
          appMethod: AppMethod.getListLocal,
          stateStatus: StateStatus.loading,
        ),
      );
      final result = await getProductsLocalUseCase();
      if (result is DataSuccess) {
        final listProduct = await compute(
          parseProductJsonList,
          result.response?.data,
        );
        emit(
          state.copyWith(
            title: result.response?.title,
            message: result.response?.message,
            listProductsLocal: listProduct,
            appMethod: AppMethod.getListLocal,
            stateStatus: StateStatus.success,
          ),
        );
      } else {
        emit(
          state.copyWith(
            title: result.errorMessage?.title,
            message: result.errorMessage?.message,
            appMethod: AppMethod.getListLocal,
            stateStatus: StateStatus.failure,
            errorTypeState: ErrorTypeState.local,
          ),
        );
      }
    } catch (e) {
      LoggerHelper.error('error $e');
      emit(
        state.copyWith(
          title: "Error",
          message: e.toString(),
          appMethod: AppMethod.getListLocal,
          errorTypeState: ErrorTypeState.unknown,
        ),
      );
    } finally {
      emit(
        state.copyWith(
          appMethod: AppMethod.none,
          stateStatus: StateStatus.none,
          errorTypeState: ErrorTypeState.none,
        ),
      );
    }
  }

  void _onSaveProductDataLocal(
    _OnSaveProductDataLocal event,
    Emitter<AppState> emit,
  ) async {
    try {
      emit(
        state.copyWith(
          appMethod: AppMethod.save,
          stateStatus: StateStatus.loading,
        ),
      );
      final result = await saveProductLocalUseCase(params: event.productEntity);
      if (result is DataSuccess) {
        final products = await compute(parseProductJson, result.response?.data);
        final listProducts = List<ProductEntity>.from(state.listProductsLocal!);
        listProducts.add(products);
        emit(
          state.copyWith(
            title: result.response?.title,
            message: result.response?.message,
            listProductsLocal: listProducts,
            appMethod: AppMethod.save,
            stateStatus: StateStatus.success,
          ),
        );
      } else {
        LoggerHelper.error('error ${result.errorMessage?.message}');
        emit(
          state.copyWith(
            title: result.errorMessage?.title,
            message: result.errorMessage?.message,
            appMethod: AppMethod.save,
            stateStatus: StateStatus.failure,
            errorTypeState: ErrorTypeState.local,
          ),
        );
      }
    } catch (e) {
      LoggerHelper.error('el error es $e');
      emit(
        state.copyWith(
          title: "Error",
          message: e.toString(),
          appMethod: AppMethod.save,
          errorTypeState: ErrorTypeState.unknown,
        ),
      );
    } finally {
      emit(
        state.copyWith(
          appMethod: AppMethod.none,
          stateStatus: StateStatus.none,
          errorTypeState: ErrorTypeState.none,
        ),
      );
    }
  }

  void _onDeletedProductDataLocal(
    _OnDeletedProductDataLocal event,
    Emitter<AppState> emit,
  ) async {
    try {
      emit(
        state.copyWith(
          appMethod: AppMethod.deleted,
          stateStatus: StateStatus.loading,
        ),
      );
      final result = await deleteProductLocalUseCase(params: event.id);
      if (result is DataSuccess) {
        final listProduct = List<ProductEntity>.from(state.listProductsLocal!);
        listProduct.removeWhere((e) => e.id == event.id);
        emit(
          state.copyWith(
            title: result.response?.title,
            message: result.response?.message,
            listProductsLocal: listProduct,
            appMethod: AppMethod.deleted,
            stateStatus: StateStatus.success,
          ),
        );
      } else {
        emit(
          state.copyWith(
            title: result.errorMessage?.title,
            message: result.errorMessage?.message,
            appMethod: AppMethod.deleted,
            stateStatus: StateStatus.failure,
            errorTypeState: ErrorTypeState.local,
          ),
        );
      }
    } catch (e) {
      emit(
        state.copyWith(
          title: "Error",
          message: e.toString(),
          appMethod: AppMethod.deleted,
          errorTypeState: ErrorTypeState.unknown,
        ),
      );
    } finally {
      emit(
        state.copyWith(
          appMethod: AppMethod.none,
          stateStatus: StateStatus.none,
          errorTypeState: ErrorTypeState.none,
        ),
      );
    }
  }

  void _onGetProductDataLocal(
    _OnGetProductDataLocal event,
    Emitter<AppState> emit,
  ) async {
    try {
      emit(
        state.copyWith(
          appMethod: AppMethod.getLocal,
          stateStatus: StateStatus.loading,
        ),
      );
      final result = await getProductsLocalUseCase(params: event.id);
      if (result is DataSuccess) {
        final json = (result.response?.data as List).first;
        final product = await compute(parseProductJson, json);

        emit(
          state.copyWith(
            title: result.response?.title,
            message: result.response?.message,
            productEntity: product,
            appMethod: AppMethod.getLocal,
            stateStatus: StateStatus.success,
          ),
        );
      } else {
        emit(
          state.copyWith(
            title: result.errorMessage?.title,
            message: result.errorMessage?.message,
            appMethod: AppMethod.getLocal,
            stateStatus: StateStatus.failure,
            errorTypeState: ErrorTypeState.local,
          ),
        );
      }
    } catch (e) {
      emit(
        state.copyWith(
          title: "Error",
          message: e.toString(),
          appMethod: AppMethod.getLocal,
          errorTypeState: ErrorTypeState.unknown,
        ),
      );
    } finally {
      emit(
        state.copyWith(
          appMethod: AppMethod.none,
          stateStatus: StateStatus.none,
          errorTypeState: ErrorTypeState.none,
        ),
      );
    }
  }

  void _onSelectProductData(
    _OnSelectProductData event,
    Emitter<AppState> emit,
  ) {
    emit(state.copyWith(productEntity: event.productEntity));
  }

  void _onUpdatedProductDataLocal(
    _OnUpdatedProductDataLocal event,
    Emitter<AppState> emit,
  ) async {
    try {
      emit(
        state.copyWith(
          appMethod: AppMethod.edit,
          stateStatus: StateStatus.loading,
        ),
      );
      final result = await editProductLocalUseCase(params: event.productEntity);
      if (result is DataSuccess) {
        final listProducts = List<ProductEntity>.from(state.listProductsLocal!);
        final index = listProducts.indexWhere(
          (e) => e.id == event.productEntity?.id,
        );
        listProducts[index] = event.productEntity!;
        emit(
          state.copyWith(
            title: result.response?.title,
            message: result.response?.message,
            listProductsLocal: listProducts,
            appMethod: AppMethod.edit,
            stateStatus: StateStatus.success,
          ),
        );
      } else {
        emit(
          state.copyWith(
            title: result.errorMessage?.title,
            message: result.errorMessage?.message,
            appMethod: AppMethod.edit,
            stateStatus: StateStatus.failure,
            errorTypeState: ErrorTypeState.local,
          ),
        );
      }
    } catch (e) {
      emit(
        state.copyWith(
          title: "Error",
          message: e.toString(),
          appMethod: AppMethod.edit,
          errorTypeState: ErrorTypeState.local,
        ),
      );
    } finally {
      emit(
        state.copyWith(
          appMethod: AppMethod.none,
          stateStatus: StateStatus.none,
          errorTypeState: ErrorTypeState.none,
        ),
      );
    }
  }

  void _onSearchProductDataApi(
    _OnSearchProductDataApi event,
    Emitter<AppState> emit,
  ) async {
    try {
      emit(
        state.copyWith(
          appMethod: AppMethod.searchApi,
          stateStatus: StateStatus.loading,
        ),
      );

      final listProduct = List<ProductEntity>.from(state.listProducts!);
      final filteredList = listProduct
          .where(
            (product) => product.title!.toLowerCase().contains(
              event.query.toLowerCase(),
            ),
          )
          .toList();
      emit(
        state.copyWith(
          title: "Exito",
          message: "",
          filteredListProducts: filteredList,
          appMethod: AppMethod.searchApi,
          stateStatus: StateStatus.success,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          title: "Error",
          message: e.toString(),
          appMethod: AppMethod.searchApi,
          errorTypeState: ErrorTypeState.unknown,
        ),
      );
    } finally {
      emit(
        state.copyWith(
          appMethod: AppMethod.none,
          stateStatus: StateStatus.none,
          errorTypeState: ErrorTypeState.none,
        ),
      );
    }
  }
}
