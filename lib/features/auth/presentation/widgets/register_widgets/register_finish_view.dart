import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:volt/core/di/service_locator.dart';
import 'package:volt/core/extensions/navigation_extension.dart';
import 'package:volt/core/theme/app_colors.dart';
import 'package:volt/features/auth/data/models/register_request_model.dart';
import 'package:volt/features/auth/presentation/cubits/register_cubit/register_cubit.dart';
import 'package:volt/features/auth/presentation/widgets/auth_widgets/auth_finish_loading_view.dart';
import 'package:volt/features/auth/presentation/widgets/auth_widgets/auth_term_footer.dart';
import 'package:volt/features/auth/presentation/widgets/register_widgets/register_finish_body.dart';
import 'package:volt/features/auth/presentation/widgets/register_widgets/register_finish_header.dart';

class RegisterFinishView extends StatelessWidget {
  final RegisterRequestModel requestModel;

  const RegisterFinishView({
    super.key,
    required this.requestModel,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<RegisterCubit>(),
      child: Builder(
        builder: (context) {
          return Scaffold(
            backgroundColor: AppColors.surfaceSubtle,
            body: SafeArea(
              top: false,
              child: CustomScrollView(
                physics: const ClampingScrollPhysics(),
                slivers: [
                  const SliverToBoxAdapter(
                    child: RegisterFinishHeader(),
                  ),
                  SliverToBoxAdapter(
                    child: RegisterFinishBody(
                      name: requestModel.fullName,
                      email: requestModel.email,
                      age: requestModel.age,
                      onSubmit: () {
                        context.push(
                          AuthFinishLoadingView(cubit: context.read<RegisterCubit>()),
                        );
                        context.read<RegisterCubit>().register(requestModel);
                      },
                    ),
                  ),
                  const SliverFillRemaining(
                    hasScrollBody: false,
                    child: Padding(
                      padding: EdgeInsets.only(bottom: 16),
                      child: Align(
                        alignment: Alignment.bottomCenter,
                        child: AuthTermsFooter(),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
