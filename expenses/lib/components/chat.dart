import 'package:expenses/components/chart_bar.dart';
import 'package:expenses/models/transaction.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Chart extends StatelessWidget {
  final List<Transaction> recenTransaction;

  Chart(this.recenTransaction);

  List<Map<String, Object>> get groupedTransanction {
    return List.generate(7, (index) {
      final weekDay = DateTime.now().subtract(
        Duration(days: index),
      );

      double sumtotal = 0.0;

      for (var i = 0; i < recenTransaction.length; i++) {
        bool sumday = recenTransaction[i].date.day == weekDay.day;
        bool sumyear = recenTransaction[i].date.day == weekDay.year;
        bool sumMonth = recenTransaction[i].date.day == weekDay.month;

        if (sumday && sumyear && sumMonth) {
          sumtotal += recenTransaction[i].value;
        }
      }
      return {
        "day": DateFormat.E().format(weekDay)[0],
        "value": sumtotal,
      };
    }).reversed.toList();
  }

double get _wekTotalValue{
  return groupedTransanction.fold(0.0,(sum, tr){
    return sum + tr['value'];

  });

}
  @override
  Widget build(BuildContext context) {
    
    return Card(
      elevation: 6.0,
      margin: EdgeInsets.all(20),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: groupedTransanction.map((tr) {
            return Flexible(
              fit: FlexFit.tight,
              child: ChartBar(
                label: tr['day'],
                value: tr['value'],
                percentage: _wekTotalValue != 0 ? 0 : (tr['value'] as double)/ _wekTotalValue,
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}
