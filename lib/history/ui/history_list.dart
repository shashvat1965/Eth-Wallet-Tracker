import 'package:cypherock_task/history/history_view_model.dart';
import 'package:cypherock_task/history/ui/date_row.dart';
import 'package:cypherock_task/history/ui/transaction_row.dart';
import 'package:flutter/material.dart';

import '../history_data_models.dart';

class HistoryList extends StatefulWidget {
  HistoryList({super.key});

  @override
  _HistoryListState createState() => _HistoryListState();
}

class _HistoryListState extends State<HistoryList>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(
    duration: const Duration(seconds: 1),
    vsync: this,
  );

  late final Animation<Offset> _offsetAnimation = Tween<Offset>(
    begin: const Offset(-1.0, 0),
    end: const Offset(0.0, 0.0),
  ).animate(CurvedAnimation(
    parent: _controller,
    curve: Curves.easeInCubic,
  ));


  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: HistoryViewModel.amountFilterOrSortChanged,
      builder: (context, bool value, child) {
        Map<String, List<Transaction>> historyMap =
            HistoryViewModel.sortedFilteredTransactions;
        _controller.reset();
        _controller.forward();
        List<String> dateList = historyMap.keys.toList(growable: true);
        return Expanded(
          child: ListView.builder(
            padding: EdgeInsets.zero,
            itemBuilder: (context, index) {
              int dateIndex = HistoryViewModel.timeSortChanged
                  ? historyMap.length - index - 1
                  : index;
              return Column(
                children: [
                  DateRow(date: dateList[dateIndex]),
                  ListView.builder(
                    padding: EdgeInsets.zero,
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) {
                      return SlideTransition(
                        position: _offsetAnimation,
                        child: TransactionRow(
                          transaction: historyMap[dateList[dateIndex]]![index],
                          isOdd: (index % 2 == 0) ? true : false,
                        ),
                      );
                    },
                    itemCount: historyMap[dateList[dateIndex]]?.length ?? 0,
                    shrinkWrap: true,
                  )
                ],
              );
            },
            itemCount: historyMap.length,
          ),
        );
      },
    );
  }
}
