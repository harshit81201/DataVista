import 'package:basic_app/bloc/form_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/form_bloc.dart' as custom_form;

class RegistrationForm extends StatelessWidget {
  const RegistrationForm({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<custom_form.FormBloc, custom_form.FormState>(
      listener: (context, state) {
        if (state.status == FormStatus.success) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Registration successful!')),
          );
        }
        if (state.status == FormStatus.failure) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.error ?? 'Registration failed')),
          );
        }
      },
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            _buildTextField(
              context: context,
              label: 'Name',
              onChanged: (value) => context.read<FormBloc>().add(NameChanged(value)),
            ),
            const SizedBox(height: 16),
            _buildTextField(
              context: context,
              label: 'Email',
              onChanged: (value) => context.read<FormBloc>().add(EmailChanged(value)),
            ),
            const SizedBox(height: 16),
            _buildTextField(
              context: context,
              label: 'Phone',
              onChanged: (value) => context.read<FormBloc>().add(PhoneChanged(value)),
            ),
            const SizedBox(height: 16),
            _buildDropdown(
              context: context,
              label: 'Gender',
              items: ['Male', 'Female', 'Other'],
              onChanged: (value) => context.read<FormBloc>().add(GenderChanged(value!)),
            ),
            const SizedBox(height: 16),
            _buildDropdown(
              context: context,
              label: 'Country',
              items: ['USA', 'UK', 'Canada', 'Australia'],
              onChanged: (value) => context.read<FormBloc>().add(CountryChanged(value!)),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () => context.read<FormBloc>().add(FormSubmitted()),
              child: const Text('Submit'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField({
    required BuildContext context,
    required String label,
    required Function(String) onChanged,
  }) {
    return TextField(
      decoration: InputDecoration(
        labelText: label,
        border: OutlineInputBorder(),
      ),
      onChanged: onChanged,
    );
  }

  Widget _buildDropdown({
    required BuildContext context,
    required String label,
    required List<String> items,
    required Function(String?) onChanged,
  }) {
    return DropdownButtonFormField<String>(
      decoration: InputDecoration(
        labelText: label,
        border: const OutlineInputBorder(),
      ),
      items: items.map((item) => DropdownMenuItem(
        value: item,
        child: Text(item),
      )).toList(),
      onChanged: onChanged,
    );
  }
}