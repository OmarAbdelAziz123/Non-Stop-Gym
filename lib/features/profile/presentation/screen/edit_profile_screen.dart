import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:non_stop/core/theme/theme.dart';
import 'package:non_stop/core/widgets/custom_app_bar.dart';
import 'package:non_stop/core/widgets/text_field/custom_text_form_field_widget.dart';
import 'package:non_stop/features/profile/bloc/cubit/profile_cubit.dart';
import 'package:non_stop/features/profile/data/models/profile_response.dart';
import 'package:non_stop/features/profile/presentation/widgets/profile_card.dart';

class EditProfilePage extends StatefulWidget {
  const EditProfilePage({super.key});

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _nameController;
  late final TextEditingController _emailController;
  late final TextEditingController _phoneController;
  late final TextEditingController _genderController;
  late final TextEditingController _passwordController;
  late final TextEditingController _passwordConfirmController;
  String? _selectedGender;
  XFile? _pickedImage;
  bool _hasUpdated = false;

  @override
  void initState() {
    super.initState();
    final cubit = context.read<ProfileCubit>();
    final profile = cubit.profileData;

    _nameController = TextEditingController(text: profile?.name ?? '');
    _emailController = TextEditingController(text: profile?.email ?? '');
    _phoneController = TextEditingController(text: profile?.phone ?? '');
    _genderController = TextEditingController(
      text: profile?.genderLabel ?? profile?.gender ?? '',
    );
    _passwordController = TextEditingController();
    _passwordConfirmController = TextEditingController();
    _selectedGender = profile?.gender?.toLowerCase();

    if (profile == null) {
      cubit.fetchProfile();
    }
  }

  void _updateControllers(ProfileData profile) {
    _nameController.text = profile.name ?? '';
    _emailController.text = profile.email ?? '';
    _phoneController.text = profile.phone ?? '';
    _genderController.text = profile.genderLabel ?? profile.gender ?? '';
    _selectedGender = profile.gender?.toLowerCase();
  }

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final selected = await picker.pickImage(source: ImageSource.gallery);
    if (selected != null) {
      setState(() {
        _pickedImage = selected;
      });
    }
  }

  void _submitUpdate() {
    final cubit = context.read<ProfileCubit>();
    final profile = cubit.profileData;

    if (_passwordController.text.isNotEmpty &&
        _passwordController.text != _passwordConfirmController.text) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('كلمتا المرور غير متطابقتين')),
      );
      return;
    }

    if (!(_formKey.currentState?.validate() ?? true)) {
      return;
    }

    String? name = _nameController.text.trim();
    if (name.isEmpty || name == profile?.name) {
      name = null;
    }

    String? email = _emailController.text.trim();
    if (email.isEmpty || email == profile?.email) {
      email = null;
    }

    String? phone = _phoneController.text.trim();
    if (phone.isEmpty || phone == profile?.phone) {
      phone = null;
    }

    String? gender = _selectedGender;
    if (gender != null) {
      gender = gender.trim();
      if (gender.isEmpty || gender == profile?.gender) {
        gender = null;
      }
    }

    String? password = _passwordController.text.trim();
    String? passwordConfirmation = _passwordConfirmController.text.trim();
    if (password.isEmpty) {
      password = null;
      passwordConfirmation = null;
    }

    cubit.updateProfile(
      name: name,
      email: email,
      phone: phone,
      gender: gender,
      password: password,
      passwordConfirmation: passwordConfirmation,
      imageFile: _pickedImage != null ? File(_pickedImage!.path) : null,
    );
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _genderController.dispose();
    _passwordController.dispose();
    _passwordConfirmController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ProfileCubit, ProfileState>(
      listenWhen: (previous, current) =>
          current is ProfileLoaded ||
          current is ProfileUpdateSuccess ||
          current is ProfileUpdateFailure,
      listener: (context, state) {
        if (state is ProfileUpdateSuccess) {
          _hasUpdated = true;
          _updateControllers(state.profile);
          setState(() {
            _pickedImage = null;
            _passwordController.clear();
            _passwordConfirmController.clear();
          });
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('تم تحديث الملف الشخصي بنجاح')),
          );
        } else if (state is ProfileUpdateFailure) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text(state.message)));
        } else if (state is ProfileLoaded) {
          _updateControllers(state.profile);
        }
      },
      builder: (context, state) {
        final cubit = context.read<ProfileCubit>();
        final profile = state is ProfileLoaded
            ? state.profile
            : state is ProfileUpdateSuccess
            ? state.profile
            : cubit.profileData;
        final isInitialLoading = profile == null && state is ProfileLoading;
        final isUpdateLoading = state is ProfileUpdateLoading;

        final genderValue =
            _selectedGender ?? profile?.gender?.toLowerCase() ?? 'male';

        final ImageProvider? customImage = _pickedImage != null
            ? FileImage(File(_pickedImage!.path))
            : null;

        return WillPopScope(
          onWillPop: () async {
            Navigator.of(context).pop(_hasUpdated);
            return false;
          },
          child: Container(
            decoration: const BoxDecoration(gradient: linearGradient),
            child: Scaffold(
              body: SafeArea(
                child: Column(
                  children: [
                    CustomAppBar(
                      title: 'تعديل الملف الشخصي',
                      onBack: () => Navigator.of(context).pop(_hasUpdated),
                    ),
                    Expanded(
                      child: SingleChildScrollView(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: Builder(
                          builder: (context) {
                            if (isInitialLoading) {
                              return Padding(
                                padding: EdgeInsets.only(top: 40.h),
                                child: const Center(
                                  child: CircularProgressIndicator(),
                                ),
                              );
                            }

                            if (profile == null && state is ProfileError) {
                              final errorState = state;
                              return Padding(
                                padding: EdgeInsets.only(top: 40.h),
                                child: Column(
                                  children: [
                                    Text(
                                      errorState.message,
                                      style: const TextStyle(
                                        color: Colors.redAccent,
                                      ),
                                    ),
                                    const SizedBox(height: 12),
                                    ElevatedButton(
                                      onPressed: cubit.fetchProfile,
                                      child: const Text('إعادة المحاولة'),
                                    ),
                                  ],
                                ),
                              );
                            }

                            return Form(
                              key: _formKey,
                              child: Column(
                                spacing: 15.sp,
                                children: [
                                  ProfileCard(
                                    isEditProfile: true,
                                    profile: profile,
                                    customImage: customImage,
                                    isLoading: isUpdateLoading,
                                    onEditPressed: _submitUpdate,
                                  ),
                                  10.verticalSpace,
                                  Align(
                                    alignment: Alignment.centerLeft,
                                    child: TextButton.icon(
                                      onPressed: _pickImage,
                                      icon: const Icon(
                                        color: Color(0xff9F5A5B),
                                        Icons.camera_alt_outlined,
                                      ),
                                      label: const Text(
                                        'تغيير الصورة',
                                        style: TextStyle(
                                          color: Color(0xff9F5A5B),
                                        ),
                                      ),
                                    ),
                                  ),
                                  CustomTextFormFieldWidget(
                                    controller: _nameController,
                                    labelText: 'اسم المستخدم',
                                    hintText: 'ادخل الاسم',
                                    validator: (value) {
                                      if (value == null ||
                                          value.trim().isEmpty) {
                                        return 'الاسم مطلوب';
                                      }
                                      return null;
                                    },
                                  ),
                                  CustomTextFormFieldWidget(
                                    controller: _emailController,
                                    labelText: 'البريد الإلكتروني',
                                    keyboardType: TextInputType.emailAddress,
                                    hintText: 'ادخل البريد الإلكتروني',
                                    validator: (value) {
                                      if (value == null ||
                                          value.trim().isEmpty) {
                                        return 'البريد الإلكتروني مطلوب';
                                      }
                                      return null;
                                    },
                                  ),
                                  CustomTextFormFieldWidget(
                                    controller: _phoneController,
                                    labelText: 'رقم الهاتف',
                                    keyboardType: TextInputType.phone,
                                    hintText: 'ادخل رقم الهاتف',
                                    validator: (value) {
                                      if (value == null ||
                                          value.trim().isEmpty) {
                                        return 'رقم الهاتف مطلوب';
                                      }
                                      return null;
                                    },
                                  ),
                                  DropdownButtonFormField<String>(
                                    initialValue: genderValue,
                                    decoration: const InputDecoration(
                                      labelText: 'الجنس',
                                      border: OutlineInputBorder(),
                                    ),
                                    items: const [
                                      DropdownMenuItem(
                                        value: 'male',
                                        child: Text('ذكر'),
                                      ),
                                      DropdownMenuItem(
                                        value: 'female',
                                        child: Text('أنثى'),
                                      ),
                                    ],
                                    onChanged: (value) {
                                      setState(() {
                                        _selectedGender = value;
                                        _genderController.text =
                                            value == 'female' ? 'أنثى' : 'ذكر';
                                      });
                                    },
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
