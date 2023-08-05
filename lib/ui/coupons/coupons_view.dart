import 'package:appetizer_revamp_parts/ui/coupons/bloc/coupons_page_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CouponsPage extends StatelessWidget {
  const CouponsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {},
        ),
        title: const Text(
          'Coupons',
          style: TextStyle(
            color: Colors.white,
            fontSize: 24,
            fontFamily: 'Noto Sans',
            fontWeight: FontWeight.w700,
          ),
        ),
        backgroundColor: const Color(0xFFFFCB74),
        toolbarHeight: 120,
      ),
      body: BlocProvider(
        create: (context) => CouponsPageBloc(),
        child: BlocBuilder<CouponsPageBloc, CouponsPageState>(
          builder: (context, state) {
            return const Placeholder();
          },
        ),
      ),
    );
  }
}
