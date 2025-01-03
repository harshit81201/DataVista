import 'package:flutter_bloc/flutter_bloc.dart';

enum FormStatus { initial, submitting, success, failure }

class FormState {
  final String name;
  final String email;
  final String phone;
  final String? gender;
  final String? country;
  final String? state;
  final String? city;
  final FormStatus status;
  final String? error;

  FormState({
    this.name = '',
    this.email = '',
    this.phone = '',
    this.gender,
    this.country,
    this.state,
    this.city,
    this.status = FormStatus.initial,
    this.error,
  });

  FormState copyWith({
    String? name,
    String? email,
    String? phone,
    String? gender,
    String? country,
    String? state,
    String? city,
    FormStatus? status,
    String? error,
  }) {
    return FormState(
      name: name ?? this.name,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      gender: gender ?? this.gender,
      country: country ?? this.country,
      state: state ?? this.state,
      city: city ?? this.city,
      status: status ?? this.status,
      error: error ?? this.error,
    );
  }
}

abstract class FormEvent {}

class NameChanged extends FormEvent {
  final String name;
  NameChanged(this.name);
}

class EmailChanged extends FormEvent {
  final String email;
  EmailChanged(this.email);
}

class PhoneChanged extends FormEvent {
  final String phone;
  PhoneChanged(this.phone);
}

class GenderChanged extends FormEvent {
  final String gender;
  GenderChanged(this.gender);
}

class CountryChanged extends FormEvent {
  final String country;
  CountryChanged(this.country);
}

class StateChanged extends FormEvent {
  final String state;
  StateChanged(this.state);
}

class CityChanged extends FormEvent {
  final String city;
  CityChanged(this.city);
}

class FormSubmitted extends FormEvent {}

class FormBloc extends Bloc<FormEvent, FormState> {
  FormBloc() : super(FormState()) {
    on<NameChanged>((event, emit) {
      emit(state.copyWith(name: event.name));
    });

    on<EmailChanged>((event, emit) {
      emit(state.copyWith(email: event.email));
    });

    on<PhoneChanged>((event, emit) {
      emit(state.copyWith(phone: event.phone));
    });

    on<GenderChanged>((event, emit) {
      emit(state.copyWith(gender: event.gender));
    });

    on<CountryChanged>((event, emit) {
      emit(state.copyWith(country: event.country));
    });

    on<StateChanged>((event, emit) {
      emit(state.copyWith(state: event.state));
    });

    on<CityChanged>((event, emit) {
      emit(state.copyWith(city: event.city));
    });

    on<FormSubmitted>((event, emit) async {
      emit(state.copyWith(status: FormStatus.submitting));
      try {
        // Validate form
        if (!_isValidEmail(state.email) || 
            !_isValidPhone(state.phone) || 
            state.name.isEmpty) {
          throw Exception('Please fill all required fields correctly');
        }

        // Simulate API call
        await Future.delayed(Duration(seconds: 1));
        
        emit(state.copyWith(status: FormStatus.success));
      } catch (e) {
        emit(state.copyWith(
          status: FormStatus.failure,
          error: e.toString(),
        ));
      }
    });
  }

  bool _isValidEmail(String email) {
    return RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(email);
  }

  bool _isValidPhone(String phone) {
    return RegExp(r'^\+?[0-9]{10,}$').hasMatch(phone);
  }
}