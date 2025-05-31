import 'package:expense_tracker/data/models/expense_model.dart';
import 'package:expense_tracker/presentation/screens/dashboard/widgets/balance_card_widget.dart';
import 'package:expense_tracker/presentation/screens/dashboard/widgets/custom_app_bar.dart';
import 'package:expense_tracker/presentation/screens/dashboard/widgets/transaction_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'bloc/dashboard_bloc.dart';
import 'bloc/dashboard_event.dart';
import 'bloc/dashboard_state.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {

  final int maxItems = 10;

  bool showAll = false;
  String selectedPeriod = 'All';


  @override
  Widget build(BuildContext context) {

     List<ExpenseModel>? expenses ;
    const int maxItems = 10;


     return BlocProvider(
      create: (ctx) => DashboardBloc()..add(LoadDashboardData()),
      child: Scaffold(
        appBar: CustomAppBar(
          selectedPeriod: selectedPeriod,
          onFilterChanged: (String newFilter) {
            setState(() {
              selectedPeriod = newFilter;
              showAll = false;
            });
          },
        ),
        body: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              stops: [0.3, 0.3],
              colors: [
                Color(0xFF1d55f3),
                Colors.white,
              ],
            ),
          ),
          child: BlocBuilder<DashboardBloc, DashboardState>(
            builder: (context, state) {
              if (state is DashboardLoading) {
                return const Center(child: CircularProgressIndicator());
              } else if (state is DashboardLoaded) {

                expenses = _applyDateFilter(state.recentExpenses, selectedPeriod);
                final bool needsButton = expenses!.length > maxItems;

                final List<ExpenseModel>? visibleItems = showAll || !needsButton
                    ? expenses
                    : expenses?.take(maxItems).toList();
                return SingleChildScrollView(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      BalanceCardWidget(
                        totlalBalance: state.totalBalance,
                        totalIncome: state.totalIncome,
                        totalExpenses: state.totalExpenses,
                      ),
                      const SizedBox(height: 40),
                      const Text(
                        "Recent Transactions",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w700,
                          color: Colors.black,
                        ),
                      ),
                      const SizedBox(height: 10),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.5,
                        child:  expenses?.isNotEmpty == true
                            ? ListView.builder(
                          itemCount: (visibleItems?.length ?? 0) + (needsButton && !showAll ? 1 : 0),
                          itemBuilder: (context, index) {
                            if (index < visibleItems!.length) {
                              final expense = visibleItems[index];
                              return TransactionItem(
                                date: DateFormat('dd/MM/yyyy').format(expense.date),
                                title: expense.category,
                                subtitle: expense.category,
                                amount: expense.convertedAmountUSD.toStringAsFixed(2),
                                icon: Icons.transfer_within_a_station,
                              );
                            }
                            return Center(
                              child: TextButton(
                                onPressed: () => setState(() => showAll = true),
                                child: const Text("Show All"),
                              ),
                            );
                          },
                        ) : Center(
                          child: Text('No Data to show',
                          style: TextStyle(
                            color: Colors.grey[700],
                            fontSize: 16,
                          )),
                ),
                      )

                    ],
                  ),
                );
              } else if (state is DashboardError) {
                return Center(child: Text(state.message));
              }
              return const SizedBox.shrink();
            },
          ),
        ),
        floatingActionButton: BlocBuilder<DashboardBloc, DashboardState>(
          builder: (context, state) {
            return FloatingActionButton(
              onPressed: () async {
               await  _navigateAndRefresh(context);
              },
              child: const Icon(Icons.add, color: Colors.white, size: 30),
            );
          }
        ),
      ),
    );
  }


  Future<void> _navigateAndRefresh(BuildContext context) async {
    final result = await Navigator.pushNamed(context, '/add-expense');

    if (result == true) {
      context.read<DashboardBloc>().add(LoadDashboardData());
    }
  }

  List<ExpenseModel> _applyDateFilter(List<ExpenseModel> all, String filter) {
    final now = DateTime.now();
    if (filter == 'This month') {
      return all.where((e) => e.date.month == now.month && e.date.year == now.year).toList();
    } else if (filter == 'This week') {
      return all.where((e) => e.date.isAfter(now.subtract(const Duration(days: 7)))).toList();
    } else if (filter == 'Today') {
      return all.where((e) =>
      e.date.day == now.day &&
          e.date.month == now.month &&
          e.date.year == now.year).toList();
    } else if (filter == 'This year') {
      return all.where((e) => e.date.year == now.year).toList();
    }
    return all;
  }


}
