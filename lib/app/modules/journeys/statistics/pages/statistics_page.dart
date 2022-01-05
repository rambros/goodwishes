import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:intl/intl.dart';
import '/app/modules/journeys/statistics/controller/statistics_controller.dart';
import '/app/shared/utils/ui_utils.dart';
import 'package:syncfusion_flutter_charts/charts.dart';



class StatisticsPage extends StatefulWidget {
  StatisticsPage({Key? key}) : super(key: key);

  @override
  _StatisticsPageState createState() => _StatisticsPageState();
}

class _StatisticsPageState extends ModularState<StatisticsPage, StatisticsController> {

  //List<charts.Series> seriesList;
  bool? animate;

  @override
  void initState() {
    super.initState();
    //SyncfusionLicense.registerLicense('NT8mJyc2IWhia31hfWN9Z2doYmF8YGJ8ampqanNiYmlmamlmanMDHmghPDchOjQ8Mj4xITwgEzQ+Mjo/fTA8Pg==');
    controller.init();
    
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Estatísticas de Meditação'),
          bottom: TabBar(
            tabs: [
              Tab(text: 'Diário'),
              Tab(text: 'Semanal'),
              Tab(text: 'Mensal'),
              Tab(text: 'Anual'),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            _showDaily(),
            _showWeekly(),
            _showMonthly(),
            _showYearly(),
          ],
        ),
      ),
    );
  }

  

  Widget _showDaily() {
    return Observer(builder: (_) {
      return SingleChildScrollView(
        child: Container(
          child: Padding(
            padding: const EdgeInsets.all(4.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                verticalSpace(12),
                Center(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      'Últimos 14 dias',
                      style: TextStyle(fontSize: 24, fontWeight: FontWeight.w700),
                    ),
                  ),
                ),

                controller.seriesTimeListD != null
                ? Center(
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Container(
                    height: 250,
                    width: MediaQuery.of(context).size.width * 0.95,
                    child: SfCartesianChart(
                              series: controller.seriesTimeListD,
                              primaryYAxis: NumericAxis(
                                  labelFormat: '{value}',
                                  isVisible: true,
                              ),
                              primaryXAxis: DateTimeAxis(
                                  dateFormat: DateFormat.d(),
                                  intervalType: DateTimeIntervalType.days,
                                  interval: 1,
                                  majorGridLines: MajorGridLines(width: 0),
                                  title: AxisTitle(text: 'dia do mês',),
                              ),
                              plotAreaBackgroundColor: Colors.grey[100],
                              title: ChartTitle(
                                    text: 'Tempo por dia (minutos)',
                                    textStyle: TextStyle(fontSize: 16),
                              ),
                              legend: Legend(
                                isVisible: false,
                                title: LegendTitle(text: 'timer'),
                                ),
                              tooltipBehavior: TooltipBehavior(enable: true),
                            )
                    ),
                  ),
              )
              : verticalSpace(6),

              controller.seriesSessionsListD != null
              ?  Center(
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Container(
                    height: 250,
                    width: MediaQuery.of(context).size.width * 0.95,
                    child: SfCartesianChart(
                              series: controller.seriesSessionsListD,
                              primaryYAxis: NumericAxis(
                                  labelFormat: '{value}',
                                  isVisible: true,
                              ),
                              primaryXAxis: DateTimeAxis(
                                  dateFormat: DateFormat.d(),
                                  intervalType: DateTimeIntervalType.days,
                                  interval: 1,
                                  majorGridLines: MajorGridLines(width: 0),
                                  title: AxisTitle(text: 'dia do mês',),
                              ),
                              plotAreaBackgroundColor: Colors.grey[100],
                              title: ChartTitle(
                                    text: 'Sessões por dia',
                                    textStyle: TextStyle(fontSize: 16),
                              ),
                              legend: Legend(
                                isVisible: false,
                                title: LegendTitle(text: 'timer'),
                                ),
                              tooltipBehavior: TooltipBehavior(enable: true),
                            )
                    ),
                  ),
              )
              : verticalSpace(6),

              Padding(
                padding: EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                  Text('Sequencia contínuas', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600)),
                  verticalSpace(6),
                  _showLine(title: 'Dias consecutivos - atual', value: controller.actualSequenceOfDaysWithSessionD),
                  _showLine(title: 'Maior sequencia de dias consecutivos', value: controller.greaterSequenceOfDaysWithSessionD),

                  verticalSpace(24),
                  Text('Tempo', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600)),
                  verticalSpace(6),
                  _showLine(title: 'Total', value: controller.totalTimeD),
                  _showLine(title: 'Timer', value: controller.totalTimeTimerD),
                  _showLine(title: 'Meditação conduzida', value: controller.totalTimeMedD),
                  _showLine(title: 'Média diária', value: controller.dailyAverageTimeD),
                  _showLine(title: 'Duração média', value: controller.averageSessionTimeD),
                  _showLine(title: 'Sessão mais longa', value: controller.longestSessionD),

                  verticalSpace(24),
                  Text('Sessões', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600)),
                  verticalSpace(6),
                  _showLine(title: 'Total', value: controller.numberSessionsD),
                  _showLine(title: 'Timer', value: controller.numberTimerSessionsD),
                  _showLine(title: 'Meditação conduzida', value: controller.numberMedSessionsD),
                  _showLine(title: 'Frequencia diária', value: controller.dailyAverageSessionsD),
                  _showLine(title: 'Maior número em único dia', value: controller.greaterNumDailySessionsD),
                ],),
              )
              ],
            ),
          ),
        ),
      );
    });
  }

  Widget _showWeekly() {
    return Observer(builder: (_) {
      return SingleChildScrollView(
        child: Container(
          child: Padding(
            padding: const EdgeInsets.all(4.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                verticalSpace(12),
                Center(
                  child: Padding(
                    padding: const EdgeInsets.all(6.0),
                    child: Text(
                      'Últimas 12 semanas',
                      style: TextStyle(fontSize: 24, fontWeight: FontWeight.w700),
                    ),
                  ),
                ),

                controller.seriesTimeListW != null
                ? Center(
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Container(
                      height: 250,
                      width: MediaQuery.of(context).size.width * 0.95,
                      child: SfCartesianChart(
                                series: controller.seriesTimeListW,
                                primaryYAxis: NumericAxis(
                                    labelFormat: '{value}',
                                    isVisible: true,
                                ),
                                primaryXAxis: CategoryAxis(
                                    interval: 1,
                                    majorGridLines: MajorGridLines(width: 0),
                                    title: AxisTitle(text: 'semana',),
                                    labelRotation: 315,
                                ),
                                plotAreaBackgroundColor: Colors.grey[100],
                                title: ChartTitle(
                                      text: 'Tempo por semana (minutos)',
                                      textStyle: TextStyle(fontSize: 16),
                                ),
                                legend: Legend(
                                  isVisible: false,
                                  title: LegendTitle(text: 'timer'),
                                  ),
                                tooltipBehavior: TooltipBehavior(enable: true),
                              )
                      ),
                    ),
                )
                : verticalSpace(6),

                controller.seriesSessionsListW != null 
                ? Center(
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Container(
                      height: 250,
                      width: MediaQuery.of(context).size.width * 0.95,
                      child: SfCartesianChart(
                                series: controller.seriesSessionsListW,
                                primaryYAxis: NumericAxis(
                                    labelFormat: '{value}',
                                    isVisible: true,
                                ),
                                primaryXAxis: CategoryAxis(
                                    interval: 1,
                                    majorGridLines: MajorGridLines(width: 0),
                                    title: AxisTitle(text: 'semana',),
                                    labelRotation: 315,
                                ),
                                plotAreaBackgroundColor: Colors.grey[100],
                                title: ChartTitle(
                                      text: 'Sessões por semana',
                                      textStyle: TextStyle(fontSize: 16),
                                ),
                                // Enable legend
                                legend: Legend(
                                  isVisible: false,
                                  title: LegendTitle(text: 'timer'),
                                  ),
                                tooltipBehavior: TooltipBehavior(enable: true),
                              )
                      ),
                    ),
                )
                : verticalSpace(6),

                Padding(
                padding: EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                  Text('Sequencias contínuas', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600)),
                  verticalSpace(6),
                  _showLine(title: 'Dias consecutivos - atual', value: controller.actualSequenceOfDaysWithSessionW),
                  _showLine(title: 'Maior sequencia de dias consecutivos', value: controller.greaterSequenceOfDaysWithSessionW),

                  verticalSpace(24),
                  Text('Tempo', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600)),
                  verticalSpace(6),
                  _showLine(title: 'Total', value: controller.totalTimeW),
                  _showLine(title: 'Timer', value: controller.totalTimeTimerW),
                  _showLine(title: 'Meditação conduzida', value: controller.totalTimeMedW),
                  _showLine(title: 'Média diária', value: controller.dailyAverageTimeW),
                  _showLine(title: 'Duração média', value: controller.averageSessionTimeW),
                  _showLine(title: 'Sessão de duração mais longa', value: controller.longestSessionW),

                  verticalSpace(24),
                  Text('Sessões', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600)),
                  verticalSpace(6),
                  _showLine(title: 'Total', value: controller.numberSessionsW),
                  _showLine(title: 'Timer', value: controller.numberTimerSessionsW),
                  _showLine(title: 'Meditação conduzida', value: controller.numberMedSessionsW),
                  _showLine(title: 'Frequencia diária', value: controller.dailyAverageSessionsW),
                  _showLine(title: 'Maior número em único dia', value: controller.greaterNumDailySessionsW),
                   ],),
              )
              ],
            ),
          ),
        ),
      );
    });
  }


  Widget _showMonthly() {
    return Observer(builder: (_) {
      return SingleChildScrollView(
        child: Container(
          child: Padding(
            padding: const EdgeInsets.all(4.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                verticalSpace(12),
                Center(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      'Últimos 12 meses',
                      style: TextStyle(fontSize: 24, fontWeight: FontWeight.w700),
                    ),
                  ),
                ),

                
                controller.seriesTimeListM != null 
                ? Center(
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Container(
                      height: 250,
                      width: MediaQuery.of(context).size.width * 0.95,
                      child: SfCartesianChart(
                                series: controller.seriesTimeListM,
                                primaryYAxis: NumericAxis(
                                    labelFormat: '{value}',
                                    isVisible: true,
                                ),
                                primaryXAxis: CategoryAxis(
                                    interval: 1,
                                    majorGridLines: MajorGridLines(width: 0),
                                    title: AxisTitle(text: 'mês',),
                                ),
                                plotAreaBackgroundColor: Colors.grey[100],
                                title: ChartTitle(
                                      text: 'Tempo por mês (minutos)',
                                      textStyle: TextStyle(fontSize: 16),
                                ),
                                // Enable legend
                                legend: Legend(
                                  isVisible: false,
                                  title: LegendTitle(text: 'timer'),
                                  ),
                                tooltipBehavior: TooltipBehavior(enable: true),
                              )
                      ),
                    ),
                )
                : verticalSpace(6),

                 
                controller.seriesSessionsListM != null
                ? Center(
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Container(
                      height: 250,
                      width: MediaQuery.of(context).size.width * 0.95,
                      child: SfCartesianChart(
                                series: controller.seriesSessionsListM,
                                primaryYAxis: NumericAxis(
                                    labelFormat: '{value}',
                                    isVisible: true,
                                ),
                                primaryXAxis: CategoryAxis(
                                    interval: 1,
                                    majorGridLines: MajorGridLines(width: 0),
                                    title: AxisTitle(text: 'mês',),
                                ),
                                plotAreaBackgroundColor: Colors.grey[100],
                                title: ChartTitle(
                                      text: 'Sessões por mês',
                                      textStyle: TextStyle(fontSize: 16),
                                ),
                                // Enable legend
                                legend: Legend(
                                  isVisible: false,
                                  title: LegendTitle(text: 'timer'),
                                  ),
                                tooltipBehavior: TooltipBehavior(enable: true),
                              )
                      ),
                    ),
                )
                : verticalSpace(6),

                Padding(
                padding: EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Sequencias contínuas', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600)),
                    verticalSpace(6),
                    _showLine(title: 'Dias consecutivos - atual', value: controller.actualSequenceOfDaysWithSessionM),
                    _showLine(title: 'Maior sequencia de dias consecutivos', value: controller.greaterSequenceOfDaysWithSessionM),

                    verticalSpace(24),
                    Text('Tempo', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600)),
                    verticalSpace(6),
                    _showLine(title: 'Total', value: controller.totalTimeM),
                    _showLine(title: 'Timer', value: controller.totalTimeTimerM),
                    _showLine(title: 'Meditação conduzida', value: controller.totalTimeMedM),
                    _showLine(title: 'Média diária', value: controller.dailyAverageTimeM),
                    _showLine(title: 'Duração média', value: controller.averageSessionTimeM),
                    _showLine(title: 'Sessão mais longa', value: controller.longestSessionM),

                    verticalSpace(24),
                    Text('Sessões', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600)),
                    verticalSpace(6),
                    _showLine(title: 'Total', value: controller.numberSessionsM),
                    _showLine(title: 'Timer', value: controller.numberTimerSessionsM),
                    _showLine(title: 'Meditação conduzida', value: controller.numberMedSessionsM),
                    _showLine(title: 'Frequencia diária', value: controller.dailyAverageSessionsM),
                    _showLine(title: 'Maior número em único dia', value: controller.greaterNumDailySessionsM),
                  ],),
              )
              ],
            ),
          ),
        ),
      );
    });
  }


   Widget _showYearly() {
    return Observer(builder: (_) {
      return SingleChildScrollView(
        child: Container(
          child: Padding(
            padding: const EdgeInsets.all(4.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                verticalSpace(12),
                Center(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      'Últimos anos',
                      style: TextStyle(fontSize: 24, fontWeight: FontWeight.w700),
                    ),
                  ),
                ),

                
                controller.seriesTimeListY != null 
                ? Center(
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Container(
                      height: 250,
                      width: MediaQuery.of(context).size.width * 0.95,
                      child: SfCartesianChart(
                                series: controller.seriesTimeListY,
                                primaryYAxis: NumericAxis(
                                    labelFormat: '{value}',
                                    isVisible: true,
                                ),
                                primaryXAxis: CategoryAxis(
                                    interval: 1,
                                    majorGridLines: MajorGridLines(width: 0),
                                    title: AxisTitle(text: 'ano',),
                                ),
                                plotAreaBackgroundColor: Colors.grey[100],
                                title: ChartTitle(
                                      text: 'Tempo por ano (horas)',
                                      textStyle: TextStyle(fontSize: 16),
                                ),
                                // Enable legend
                                legend: Legend(
                                  isVisible: false,
                                  title: LegendTitle(text: 'timer'),
                                  ),
                                tooltipBehavior: TooltipBehavior(enable: true),
                              )
                      ),
                    ),
                )
                : verticalSpace(6),

                controller.seriesSessionsListY != null 
                ? Center(
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Container(
                      height: 250,
                      width: MediaQuery.of(context).size.width * 0.95,
                      child: SfCartesianChart(
                                series: controller.seriesSessionsListY,
                                primaryYAxis: NumericAxis(
                                    labelFormat: '{value}',
                                    isVisible: true,
                                ),
                                primaryXAxis: CategoryAxis(
                                    interval: 1,
                                    majorGridLines: MajorGridLines(width: 0),
                                    title: AxisTitle(text: 'ano',),
                                ),
                                plotAreaBackgroundColor: Colors.grey[100],
                                title: ChartTitle(
                                      text: 'Sessões por ano',
                                      textStyle: TextStyle(fontSize: 16),
                                ),
                                // Enable legend
                                legend: Legend(
                                  isVisible: false,
                                  title: LegendTitle(text: 'timer'),
                                  ),
                                tooltipBehavior: TooltipBehavior(enable: true),
                              )
                      ),
                    ),
                )
                : verticalSpace(6),

              Padding(
                padding: EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Sequencias contínuas', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600)),
                    verticalSpace(6),
                    _showLine(title: 'Dias consecutivos - atual', value: controller.actualSequenceOfDaysWithSessionY),
                    _showLine(title: 'Maior sequencia de dias consecutivos', value: controller.greaterSequenceOfDaysWithSessionY),

                    verticalSpace(24),
                    Text('Tempo', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600)),
                    verticalSpace(6),
                    _showLine(title: 'Total', value: controller.totalTimeY),
                    _showLine(title: 'Timer', value: controller.totalTimeTimerY),
                    _showLine(title: 'Meditação conduzida', value: controller.totalTimeMedY),
                    _showLine(title: 'Média diária', value: controller.dailyAverageTimeY),
                    _showLine(title: 'Duração média', value: controller.averageSessionTimeY),
                    _showLine(title: 'Sessão mais longa', value: controller.longestSessionY),

                    verticalSpace(24),
                    Text('Sessões', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600)),
                    verticalSpace(6),
                    _showLine(title: 'Total', value: controller.numberSessionsY),
                    _showLine(title: 'Timer', value: controller.numberTimerSessionsY),
                    _showLine(title: 'Meditação conduzida', value: controller.numberMedSessionsY),
                    _showLine(title: 'Frequencia diária', value: controller.dailyAverageSessionsY),
                    _showLine(title: 'Maior número em único dia', value: controller.greaterNumDailySessionsY),
                ],),
              )
              ],
            ),
          ),
        ),
      );
    });
  }

  Widget _showLine({
    required String title,
    required String value,
  }) {
    return Container(
        padding: EdgeInsets.fromLTRB(0, 8, 4, 8),
        width: MediaQuery.of(context).size.width,
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(title),
                Text(value),
              ],
            ),
            verticalSpace(4),
            Divider(height: 1, thickness: 0.5, color: Colors.black26),
          ],
        ));
  }
}
