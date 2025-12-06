import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:prueba/core/components/input_custom_core.dart';
import 'package:prueba/core/helpers/responsive.dart';
import 'package:prueba/features/app/presentation/bloc/app_bloc.dart';
import 'package:prueba/features/app/presentation/widgets/item_product_widget.dart';

class ApiListSearchPage extends StatefulWidget {
  const ApiListSearchPage({super.key});

  @override
  State<ApiListSearchPage> createState() => _ApiListSearchPageState();
}

class _ApiListSearchPageState extends State<ApiListSearchPage> {
  final _searchController = TextEditingController();
  Timer? _debounce;

  @override
  void initState() {
    super.initState();

    _searchController.addListener(_onSearchChanged);
  }

  void _onSearchChanged() {
    if (_debounce?.isActive ?? false) _debounce!.cancel();

    _debounce = Timer(const Duration(milliseconds: 500), () {
      final query = _searchController.text;
      context.read<AppBloc>().add(
        AppEvent.onSearchProductDataApi(query: query),
      );
    });
  }

  @override
  void dispose() {
    _searchController.removeListener(_onSearchChanged);
    _searchController.dispose();
    _debounce?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      onPopInvokedWithResult: (didPop, result) {
        context.read<AppBloc>().add(AppEvent.onSearchProductDataApi(query: ""));
      },
      child: Scaffold(
        appBar: AppBar(
          scrolledUnderElevation: 0,
          title: InputCustomCore(
            controller: _searchController,
            hintText: 'Buscar producto',
          ),
        ),
        body: BlocBuilder<AppBloc, AppState>(
          builder: (context, state) {
            if (state.stateStatus == StateStatus.loading) {
              return const Center(child: CircularProgressIndicator());
            }

            final filtered = state.filteredListProducts ?? [];
            if (filtered.isEmpty) {
              return const Center(child: Text('No se encontraron productos'));
            }

            return Container(
              padding: EdgeInsets.symmetric(
                horizontal: ResponsiveHelper.paddingHorizontal(8),
                vertical: ResponsiveHelper.paddingVertical(2),
              ),
              child: ListView.builder(
                itemCount: filtered.length,
                itemBuilder: (context, index) {
                  final product = filtered[index];
                  return ItemProductWidget(product: product);
                },
              ),
            );
          },
        ),
      ),
    );
  }
}
