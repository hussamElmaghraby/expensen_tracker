import 'package:expense_tracker/presentation/screens/add_expense/widgets/add_catergory_item.dart';
import 'package:expense_tracker/presentation/screens/add_expense/widgets/category_item.dart';
import 'package:expense_tracker/presentation/screens/add_expense/widgets/custom_drop_down_field.dart';
import 'package:expense_tracker/presentation/screens/add_expense/widgets/custom_text_field.dart';
import 'package:expense_tracker/presentation/screens/add_expense/widgets/date_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'bloc/add_expense_bloc.dart';
import 'bloc/add_expense_event.dart';
import 'bloc/add_expense_state.dart';

class AddExpenseScreen extends StatefulWidget {
  const AddExpenseScreen({super.key});

  @override
  _AddExpenseScreenState createState() => _AddExpenseScreenState();
}

class _AddExpenseScreenState extends State<AddExpenseScreen> {
  final _formKey = GlobalKey<FormState>();
  final List<String> _categories = [
    'Entertainment',
    'Transport',
    'Gas',
    'Shopping',
    'Rent',
  ];
  DateTime _date = DateTime.now();
  String? _currency;
  String? _category;
  final List<String> _currencies = ['EGP', 'USD', 'EUR', 'SAR'];
  final TextEditingController _amountController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => AddExpenseBloc(),
      child: Scaffold(
        appBar: AppBar(
          iconTheme: const IconThemeData(
            color: Colors.black, // ← لون زر الرجوع
          ),
          title:
              const Text("Add Expense", style: TextStyle(color: Colors.black)),
          elevation: 0,
          centerTitle: true,
          backgroundColor: Colors.white10,
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: BlocConsumer<AddExpenseBloc, AddExpenseState>(
            listener: (context, state) {
              if (state is AddExpenseSuccess) {
                ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text("Expense Added")));
                Navigator.pop(context, true);
              } else if (state is AddExpenseFailure) {
                ScaffoldMessenger.of(context)
                    .showSnackBar(SnackBar(content: Text(state.message)));
              }
            },
            builder: (context, state) {
              return Form(
                key: _formKey,
                child: ListView(
                  children: [
                    DropdownTextField(
                      label: 'Category',
                      value: 'Entertainment',
                      items: _categories,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please select a category';
                        }
                        return null;
                      },
                      onChanged: (String? value) {
                        _category = value;
                      },
                    ),
                    const SizedBox(height: 15),
                    DropdownTextField(
                      label: 'Currency',
                      value: 'EGP',
                      items: _currencies,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please select a currency';
                        }
                        return null;
                      },
                      onChanged: (String? value) {
                        _currency = value ;
                      },
                    ),
                    const SizedBox(height: 15),
                    CustomInputField(
                      label: 'Amount',
                      hint: '50,000',
                      validator: (val) {
                        if (val != null && val.isEmpty) {
                          return 'Please enter an amount';
                        }
                        return null;
                      },
                      controller: _amountController,
                      readOnly: false,
                    ),
                    const SizedBox(height: 15),
                    DateTextField(
                      label: 'Date',
                      validator: (date) {
                        if (date == null) {
                          return 'Please select a date';
                        }
                        return null;
                      },
                      onDateSelected: (DateTime date) {
                        setState(() {
                          _date = date;
                          print(_date);
                        });
                      },
                    ),
                    const SizedBox(height: 20),
                    GridView.count(
                      crossAxisCount: 3,
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      padding: const EdgeInsets.all(16),
                      crossAxisSpacing: 0,
                      mainAxisSpacing: 0,
                      children: [
                        const CategoryItem(
                          icon: Icons.local_movies,
                          label: "Entertainment",
                          color: Colors.blue,
                          isSelected: true,
                        ),
                        const CategoryItem(
                          icon: Icons.directions_car,
                          label: "Transport",
                          color: Colors.purple,
                        ),
                        const CategoryItem(
                          icon: Icons.local_gas_station,
                          label: "Gas",
                          color: Colors.red,
                        ),
                        const CategoryItem(
                          icon: Icons.shopping_bag,
                          label: "Shopping",
                          color: Colors.orange,
                        ),
                        CategoryItem(
                          icon: Icons.paid,
                          label: "Rent",
                          color: Colors.amber.shade700,
                        ),
                        AddCategoryItem(
                          onTap: () {
                            print("Add Category");
                          },
                        ),
                      ],
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF1d55f3),
                      ),
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          context.read<AddExpenseBloc>().add(SubmitExpense(
                                category: _category!,
                                amount: double.tryParse(_amountController.text)
                                        ?.toDouble() ??
                                    0,
                                currency: _currency ?? 'EGP',
                                date: _date,
                              ));
                        }
                      },
                      child: state is AddExpenseLoading
                          ? const CircularProgressIndicator(color: Colors.white)
                          : const Text(
                              "Save",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
