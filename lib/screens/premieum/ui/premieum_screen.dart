import 'package:dio/dio.dart' show Dio;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:product0/core/api/dio_consumer.dart';
import 'package:product0/core/components/custom_button.dart';
import 'package:product0/core/utils/constants.dart';
import 'package:product0/core/utils/ui_state.dart';
import 'package:product0/screens/premieum/data/model/premieum.dart';
import 'package:product0/screens/premieum/data/remote/premieum_remote_source_impl.dart';
import 'package:product0/screens/premieum/data/repository/premieum_repository_impl.dart';
import 'package:product0/screens/premieum/ui/viewmodel/premieum_state.dart';
import 'package:product0/screens/premieum/ui/viewmodel/premieum_viewmodel.dart';
import 'package:url_launcher/url_launcher.dart';

class PremieumScreen extends StatelessWidget {
  const PremieumScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => PremieumViewmodel(
        premieumRepositoryImpl: PremieumRepositoryImpl(
          premieumRemoteSource: PremieumRemoteSourceImpl(
            api: DioConsumer(dio: Dio()),
          ),
        ),
      ),
      child: Scaffold(
        backgroundColor: backgroundColor,
        appBar: AppBar(
          backgroundColor: kMainDarkColor,
          title: Text('اشترك معنا', style: TextStyle(color: Colors.white)),
          centerTitle: true,
        ),
        body: const PremieumScreenBody(),
      ),
    );
  }
}

class PremieumScreenBody extends StatelessWidget {
  const PremieumScreenBody({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PremieumViewmodel, PremieumState>(
      builder: (context, state) {
        if (state.uiState == UiState.loading) {
          return const Center(
            child: CircularProgressIndicator(color: kMainColor),
          );
        } else if (state.uiState == UiState.error) {
          return const Center(
            child: Text(
              'Error fetching plans',
              style: TextStyle(color: Colors.red),
            ),
          );
        } else if (state.uiState == UiState.data && state.premieum.isNotEmpty) {
          return ListView.builder(
            padding: EdgeInsets.all(10),
            itemCount: state.premieum.length,
            itemBuilder: (context, index) {
              return PremieumCard(
                premieum: state.premieum[index],
                index: index,
              );
            },
          );
        }
        return Column(children: []);
      },
    );
  }
}

class PremieumCard extends StatelessWidget {
  const PremieumCard({super.key, required this.premieum, required this.index});
  final Premieum premieum;
  final int index;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: MediaQuery.of(context).size.height * 0.001),

        Container(
          margin: EdgeInsets.symmetric(
            horizontal: MediaQuery.of(context).size.width * 0.03,
          ),
          width: double.infinity,
          decoration: BoxDecoration(
            color: kMainDarkColor,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 20),
            child: Column(
              children: [
                Text(
                  premieum.title,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 10),
                Directionality(
                  textDirection: TextDirection.rtl,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: ListView.builder(
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: premieum.content.length,
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        return Text(
                          '${premieum.content[index]}',
                          style: TextStyle(
                            color: Colors.grey.shade100,
                            fontSize: 16,
                          ),
                        );
                      },
                    ),
                  ),
                ),
                SizedBox(height: MediaQuery.of(context).size.height * 0.02),
                CustomButton(
                  color: Color(0xffef4565),
                  onTap: () async {
                    final String phoneNumber = "963965325745";
                    if (index == 0) {
                      final url = Uri.parse(
                        "https://wa.me/${phoneNumber.replaceAll('+', '')}?text=${Uri.encodeComponent("السلام عليكم أريد نشر إعلان لنشاطي التجاري ")}",
                      );
                      await launchUrl(
                        url,
                        mode: LaunchMode.externalApplication,
                      );
                    } else {
                      final url = Uri.parse(
                        "https://wa.me/${phoneNumber.replaceAll('+', '')}?text=${Uri.encodeComponent("السلام عليكم أريد الاشتراك كعضو مميز ")}",
                      );
                      await launchUrl(
                        url,
                        mode: LaunchMode.externalApplication,
                      );
                    }
                  },
                  btnText: 'اشترك الآن',
                ),
                // SizedBox(height: 50),
              ],
            ),
          ),
        ),
        SizedBox(height: MediaQuery.of(context).size.height * 0.03),
      ],
    );
  }
}
