import 'package:flutter/material.dart';
import 'package:softvance_task/helpers/alarm_helper.dart';

class Alarm {
  DateTime time;
  bool isActive;
  Alarm(this.time, {this.isActive = true});
}

class HomeScreen extends StatefulWidget {
  static const routeName = '/home';

  const HomeScreen({super.key});
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Alarm> alarms = [];
  String location = "Selected Location";

  @override
  void initState() {
    super.initState();
    AlarmHelper.initialize();
  }

  void _addAlarm(DateTime time) async {
    setState(() {
      alarms.add(Alarm(time));
    });
    await AlarmHelper.scheduleAlarm(time);
  }

  Future<void> _pickDateTime() async {
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(Duration(days: 365)),
    );
    if (picked != null) {
      TimeOfDay? pickedTime = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.now(),
      );
      if (pickedTime != null) {
        DateTime fullDateTime = DateTime(
          picked.year,
          picked.month,
          picked.day,
          pickedTime.hour,
          pickedTime.minute,
        );
        _addAlarm(fullDateTime);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final locArg = ModalRoute.of(context)?.settings.arguments as String?;
    if (locArg != null) location = locArg;

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                location,
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 6),
              Divider(color: Colors.white24),
              Text('Alarms', style: TextStyle(fontSize: 16)),
              Expanded(
                child: ListView.builder(
                  itemCount: alarms.length,
                  itemBuilder: (_, i) {
                    final alarm = alarms[i];
                    return ListTile(
                      title: Text(
                        TimeOfDay.fromDateTime(alarm.time).format(context),
                        style: TextStyle(fontSize: 22, color: Colors.white),
                      ),
                      subtitle: Text(
                        '${alarm.time.day}/${alarm.time.month}/${alarm.time.year}',
                      ),
                      trailing: Switch(
                        value: alarm.isActive,
                        onChanged: (val) =>
                            setState(() => alarm.isActive = val),
                      ),
                    );
                  },
                ),
              ),
              Align(
                alignment: Alignment.bottomRight,
                child: FloatingActionButton(
                  onPressed: _pickDateTime,
                  child: Icon(Icons.add),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
