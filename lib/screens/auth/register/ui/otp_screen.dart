// import 'package:dio/dio.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:pin_code_fields/pin_code_fields.dart';
// import 'package:product0/core/api/dio_consumer.dart';
// import 'package:product0/screens/auth/register/data/datasource/local/register_local_source_impl.dart';
// import 'package:product0/screens/auth/register/data/datasource/remote/register_remote_Source_impl.dart';
// import 'package:product0/screens/auth/register/data/repository/register_repository_impl.dart';
// import 'package:product0/screens/auth/register/ui/viewmodel/auth_viewmodel.dart';

// class OtpScreen extends StatelessWidget {
//   const OtpScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return BlocProvider(
//       create: (context) => AuthViewmodel(
//         registerRepositoryImp: RegisterRepositoryImpl(
//           registerLocalSourceImpl: RegisterLocalSourceImpl(),
//           registerRemoteSourceImpl: RegisterRemoteSourceImpl(
//             api: DioConsumer(dio: Dio()),
//           ),
//         ),
//       ),
//       child: Scaffold(body: OtpScreenBody()),
//     );
//   }
// }

// class OtpScreenBody extends StatefulWidget {
//   const OtpScreenBody({super.key});

//   @override
//   State<OtpScreenBody> createState() => _OtpScreenBodyState();
// }

// class _OtpScreenBodyState extends State<OtpScreenBody> {
//   String otp = '';
//   @override
//   Widget build(BuildContext context) {
//     return Center(
//       child: Column(
//         children: [
//           PinCodeTextField(
//             keyboardType: TextInputType.number,
//             pinTheme: PinTheme(
//               shape: PinCodeFieldShape.circle,
//               borderRadius: BorderRadius.circular(5),
//               fieldHeight: 100,
//               fieldWidth: 50,
//               activeFillColor: Colors.white,
//             ),
//             appContext: context,
//             scrollPadding: EdgeInsets.all(0),
//             length: 6,
//             onCompleted: (value) {
//               otp = value;
//             },
//           ),
//           IconButton(
//             onPressed: () async {
//               await BlocProvider.of<AuthViewmodel>(
//                 context,
//               ).verifyOtp(otp: otp, userId: 52);
//             },
//             icon: Icon(Icons.abc),
//           ),
//         ],
//       ),
//     );
//   }
// }
