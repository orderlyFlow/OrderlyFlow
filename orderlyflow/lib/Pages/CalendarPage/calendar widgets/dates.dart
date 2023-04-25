import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:orderlyflow/custom_widgets/palette.dart';

class calendarDate extends StatefulWidget {
  const calendarDate({super.key});

  @override
  State<calendarDate> createState() => _calendarDateState();
}

class _calendarDateState extends State<calendarDate> {
  DateTime _selectedDate = DateTime.now();
  @override
  Widget build(BuildContext context) {
    late double ScreenWidth = MediaQuery.of(context).size.width;
    late double ScreenHeight = MediaQuery.of(context).size.height;
    final date = DateTime(_selectedDate.year, _selectedDate.month, 1);
    final daysInMonth =
        DateTime(_selectedDate.year, _selectedDate.month + 1, 0).day;

    final monthName = DateFormat('MMMM y').format(_selectedDate);
    return Container(
      height: ScreenHeight * 0.4,
      width: ScreenWidth * 0.91,
      decoration: BoxDecoration(
          color: Paletter.containerLight,
          borderRadius: BorderRadius.circular(15)),
      child: Padding(
        padding: EdgeInsets.fromLTRB(0.02 * ScreenWidth, 0.02 * ScreenHeight,
            0.02 * ScreenWidth, 0.02 * ScreenHeight),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Development Team - Calendar',
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 35,
                  fontFamily: "conthrax"),
            ),
            SizedBox(
              height: ScreenHeight * 0.01,
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                IconButton(
                  icon: Icon(Icons.arrow_back),
                  onPressed: () {
                    setState(() {
                      _selectedDate = DateTime(_selectedDate.year,
                          _selectedDate.month - 1, _selectedDate.day);
                    });
                  },
                ),
                SizedBox(
                  width: ScreenWidth * 0.2,
                ),
                Text(
                  monthName,
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 25,
                      fontFamily: "conthrax"),
                ),
                SizedBox(
                  width: ScreenWidth * 0.2,
                ),
                IconButton(
                  icon: Icon(Icons.arrow_forward),
                  onPressed: () {
                    setState(() {
                      _selectedDate = DateTime(_selectedDate.year,
                          _selectedDate.month + 1, _selectedDate.day);
                    });
                  },
                ),
              ],
            ),
            SizedBox(
              height: ScreenHeight * 0.01,
            ),
            Expanded(
              child: GridView.builder(
                itemCount: daysInMonth,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 7,
                  childAspectRatio: 6,
                  mainAxisSpacing: 10,
                ),
                itemBuilder: (context, index) {
                  final day = index + 1;
                  final isToday = DateTime.now().day == day &&
                      DateTime.now().month == _selectedDate.month &&
                      DateTime.now().year == _selectedDate.year;
                  final isSelected = _selectedDate.day == day;

                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        _selectedDate = DateTime(
                            _selectedDate.year, _selectedDate.month, day);
                      });
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: isSelected ? Paletter.logInText : Colors.white,
                        shape: BoxShape.circle,
                      ),
                      child: Center(
                        child: Text(
                          '$day',
                          style: TextStyle(
                            color:
                                isSelected ? Colors.white : Paletter.blackText,
                            fontFamily: 'Iceland',
                            fontSize: 20,
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
