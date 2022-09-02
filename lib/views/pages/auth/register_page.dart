import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:sence/constants/app_colors.dart';
import 'package:sence/helpers/height_spacer.dart';
import 'package:sence/helpers/secure_store_service.dart';
import 'package:sence/models/user_models/user_model.dart';
import 'package:sence/services/auth_service.dart';
import 'package:sence/views/widgets/custom_button.dart';
import 'package:sence/views/pages/auth/widgets/custom_footer.dart';
import 'package:sence/views/pages/auth/widgets/custom_textformfield.dart';
import 'package:sence/views/pages/auth/widgets/logo_image.dart';
import 'package:sence/views/widgets/show_custom_dialog.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  TextEditingController? _usernameController;
  TextEditingController? _passwordController;
  late final AuthService _authService;
  late SecureStoreService _secureStoreService;
  final _baseUrl = 'https://sence-napim.herokuapp.com/user';
  @override
  void initState() {
    super.initState();
    _secureStoreService = SecureStoreService();
    final dio = Dio(BaseOptions(baseUrl: _baseUrl));
    _authService = AuthService(dio);
    _usernameController = TextEditingController();
    _passwordController = TextEditingController();
  }

  @override
  void dispose() {
    super.dispose();
    _usernameController?.dispose();
    _passwordController?.dispose();
  }

  Future<void> registerButton(BuildContext context) async {
    showCustomDialog();
    if (_usernameController!.text != '' && _passwordController!.text != '') {
      final response = await _authService.fetchRegister(
        UserModel(
          username: _usernameController!.text,
          password: _passwordController!.text,
        ),
      );
      if (response != null) {
        //save id
        _secureStoreService.storeValue(
          key: 'id',
          value: response.userId.toString(),
        );
        //token save
        _secureStoreService.storeValue(
          key: 'token',
          value: response.token.toString(),
        );
        Future.delayed(const Duration(seconds: 1), () {
          navigateHomePage();
        });
      } else {
        Future.delayed(const Duration(seconds: 2), () {
          ShowCustomDialog.showAlert(
            context: context,
            title: 'Hata oluştu',
            content: 'Kayıt yaparken hata oluştu',
          );
        });
      }
    } else {
      Future.delayed(const Duration(seconds: 2), () {
        ShowCustomDialog.showAlert(
          context: context,
          content: 'Değerler boş bırakılamaz',
          title: 'Kayıt yaparken hata oluştu',
        );
      });
    }
  }

  void showCustomDialog() {
    ShowCustomDialog.show(context);
  }

  void navigateHomePage() {
    Navigator.pushNamedAndRemoveUntil(
        context, '/navigation', ModalRoute.withName('/'));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        foregroundColor: AppColors.BERRY_BLUE_GREEN,
        backgroundColor: Colors.white10,
        elevation: 0,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Form(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Column(
                children: [
                  const LogoImage(),
                  CustomTextFormField(
                    controller: _usernameController!,
                    labelText: 'Kullanıcı Adı',
                  ),
                  const HeightSpacer(height: 0.09),
                  CustomTextFormField(
                    controller: _passwordController!,
                    labelText: 'Şifre',
                  ),
                  const HeightSpacer(height: 0.09),
                  CustomButton(
                    onPressed: () => registerButton(context),
                    text: 'Kayıt ol',
                  ),
                  const HeightSpacer(height: 0.09),
                  CustomFooter(
                    text: 'Tamamen anonim kullanım için kayıt olun',
                    textButton: '',
                    routeText: '/register',
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
