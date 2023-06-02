import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:unboxedkart/constants/constants.dart';
import 'package:unboxedkart/logic/addresses/addresses_bloc.dart';
import 'package:unboxedkart/logic/order_summary/ordersummary_bloc.dart';
import 'package:unboxedkart/models/store_location/store_location.model.dart';
import 'package:unboxedkart/presentation/models/store_location/store_location.dart';
import 'package:unboxedkart/presentation/pages/order_summary/payment.dart';
import 'package:unboxedkart/presentation/widgets/common_widgets/custom_alert_popup.dart';
import 'package:unboxedkart/presentation/widgets/common_widgets/custom_app_bar.dart';
import 'package:unboxedkart/presentation/widgets/common_widgets/custom_bottom_button.dart';
import 'package:unboxedkart/presentation/widgets/common_widgets/elevated_container.dart';
import 'package:unboxedkart/presentation/widgets/common_widgets/order_summary_status.dart';
import 'package:unboxedkart/presentation/widgets/custom_sized_text.dart';
import 'package:unboxedkart/presentation/widgets/loading_spinner.dart';

int selectedMonthGlobal;
int selectedDayGlobal;
int selectedYearGlobal;
int selectedHourGlobal;
int selectedMinuteGlobal = 0;

class SelectPickUpStore extends StatefulWidget {
  const SelectPickUpStore({Key key}) : super(key: key);

  @override
  State<SelectPickUpStore> createState() => _SelectPickUpStoreState();
}

class _SelectPickUpStoreState extends State<SelectPickUpStore> {
  final CustomAlertPopup _customPopup = CustomAlertPopup();

  @override
  initState() {
    selectedDayGlobal = null;
    selectedHourGlobal = null;
  }

  _showCustomPopup(String title, String subtitle) {
    return _customPopup.show(
      title: title,
      subTitle: subtitle,
      buttonOneText: "Dismiss",
      buttonTwoText: "Okay",
      context: context,
    );
  }

  StoreLocationModel selectedStore;
  int selectedStoreIndex;

  _handleSelectStoreLocation({int index, StoreLocationModel storeLocation}) {
    selectedStore = storeLocation;
    setState(() {
      selectedStoreIndex = index;
    });
  }

  _handleSaveAddressInDb() {
    DateTime pickUpDate = DateTime.utc(
        selectedYearGlobal, selectedMonthGlobal, selectedDayGlobal);
    String pickUpDateInString =
        "$selectedDayGlobal ${months[selectedMonthGlobal - 1]}";
    DateTime pickUpTimeStart = DateTime.utc(selectedYearGlobal,
        selectedMonthGlobal, selectedDayGlobal, selectedHourGlobal, 00);
    DateTime pickUpTimeEnd = DateTime.utc(selectedYearGlobal,
        selectedMonthGlobal, selectedDayGlobal, selectedHourGlobal + 3, 00);
    String pickUpTimeInString =
        "${selectedHourGlobal > 12 ? selectedHourGlobal - 12 : selectedHourGlobal}:00 ${selectedHourGlobal > 12 ? "PM" : "AM"} - ${(selectedHourGlobal + 3) > 12 ? selectedHourGlobal + 3 - 12 : selectedHourGlobal + 3}:00 ${(selectedHourGlobal + 3) > 12 ? "PM" : "AM"}";
    BlocProvider.of<OrdersummaryBloc>(context).add(AddPickUpDetails(
        deliveryType: 0,
        storeLocation: selectedStore,
        pickUpTimeEnd: pickUpTimeEnd,
        pickUpTimeStart: pickUpTimeStart,
        pickUpDate: pickUpDate,
        pickUpTimeInString: pickUpTimeInString,
        pickUpDateInString: pickUpDateInString));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(50),
          child: CustomAppBar(title: 'Select Address', enableBack: true),
        ),
        bottomSheet: CustomBottomButton(
             
            title: "Select Address",
            function: () async {
              if (selectedStoreIndex != null &&
                  selectedDayGlobal != null &&
                  selectedHourGlobal != null) {
                await _handleSaveAddressInDb();
                Navigator.pushNamed(context, '/payment',
                    arguments: const PaymentPage(
                      deliveryType: 0,
                    ));
              } else {
                _showCustomPopup("Please select all required fields",
                    "Store location, pickup date and time are required");
              }
            }),
        body: SafeArea(
          child: BlocProvider(
            create: (context) => AddressesBloc()
              ..add(const LoadSelectStoreLocation(deliveryType: 0)),
            child: BlocBuilder<AddressesBloc, AddressesState>(
              builder: (context, state) {
                if (state is AddressesLoadedState) {
                  return ListView(
                    shrinkWrap: true,
                    physics: const ClampingScrollPhysics(),
                    children: [
                      const orderSummaryStatus(
                        orderStatus: 2,
                      ),
                      _ShowStoreLocations(
                        storeLocations: state.storeLocations,
                        selectedStoreIndex: selectedStoreIndex,
                        function: (val) => _handleSelectStoreLocation(
                            index: val,
                            storeLocation: state.storeLocations[val]),
                      ),
                       
                       
                       
                      _ShowPickupTime(),
                      const SizedBox(
                        height: 100,
                      ),
                    ],
                  );
                } else {
                  return const LoadingSpinnerWidget();
                }
              },
            ),
          ),
        ));
  }
}

class _ShowPickupTime extends StatefulWidget {
  @override
  State<_ShowPickupTime> createState() => _ShowPickupTimeState();
}

class _ShowPickupTimeState extends State<_ShowPickupTime> {
  final date = DateTime.now();

   
  int selectedMonth;
  int selectedDay;
  int selectedYear;
  int selectedHour;
  int selectedMinute;

  DateTime selectedTime;

  _handleSelectTime(int hour, int minute) {
    setState(() {
      selectedHour = hour;
      selectedMinute = minute;
    });
    selectedHourGlobal = hour;
  }

  _handleSelectDate(int day, int month, int year) {
    setState(() {
      selectedDay = day;
      selectedMonth = month;
      selectedYear = year;
    });
    selectedDayGlobal = day;
    selectedMonthGlobal = month;
    selectedYearGlobal = year;
  }

  @override
  Widget build(BuildContext context) {
    return ElevatedContainer(
      elevation: 0,
      child: Padding(
        padding: const EdgeInsets.all(0.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomSizedTextBox(
              textContent: "SELECT PICKUP DATE *",
              isBold: true,
              fontSize: 11,
            ),
            const SizedBox(
              height: 10,
            ),
            SizedBox(
              height: 40,
              child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: 7,
                  itemBuilder: (context, index) {
                    return _DayWidget(
                        date: date.add(Duration(days: index)),
                        function: (val1, val2, val3) {
                          _handleSelectDate(val1, val2, val3);
                        },
                        selectedDay: selectedDay,
                        selectedYear: selectedYear,
                        selectedMonth: selectedMonth);
                  }),
            ),
            const SizedBox(
              height: 20,
            ),
            CustomSizedTextBox(
              textContent: "SELECT PICKUP TIME *",
              isBold: true,
              fontSize: 11,
            ),
            const SizedBox(
              height: 10,
            ),
            SizedBox(
              height: 40,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: [
                  selectedDay != date.day ||
                          (selectedDay == date.day && date.hour < 13)
                      ? _NewTimeWidget(
                          timeInString: "10:00 AM - 01:00 PM",
                          hour: 10,
                          function: (val1, val2) {
                            _handleSelectTime(val1, val2);
                             
                          },
                          selectedHour: selectedHour,
                          selectedMinute: selectedMinute)
                      : const SizedBox(),
                  selectedDay != date.day ||
                          (selectedDay == date.day && date.hour < 16)
                      ? _NewTimeWidget(
                          timeInString: "01:00 PM - 04:00 PM",
                          hour: 13,
                          function: (val1, val2) {
                            _handleSelectTime(val1, val2);
                          },
                          selectedHour: selectedHour,
                          selectedMinute: selectedMinute)
                      : const SizedBox(),
                  selectedDay != date.day ||
                          (selectedDay == date.day && date.hour < 19)
                      ? _NewTimeWidget(
                          timeInString: "04:00 PM - 07:00 PM",
                          hour: 16,
                          function: (val1, val2) {
                            _handleSelectTime(val1, val2);
                          },
                          selectedHour: selectedHour,
                          selectedMinute: selectedMinute)
                      : const SizedBox(),
                  selectedDay == date.day && date.hour >= 19
                      ? CustomSizedTextBox(
                          addPadding: true,
                          textContent:
                              "No Slots are available for the selected date, please select another date",
                          fontSize: 13,
                        )
                      : const SizedBox()

                   
                   
                   
                   
                   
                   
                   
                   
                   
                   
                   
                   
                   
                   
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ShowStoreLocations extends StatelessWidget {
  final List<StoreLocationModel> storeLocations;
  final Function function;
  final int selectedStoreIndex;

  const _ShowStoreLocations(
      {Key key, this.storeLocations, this.function, this.selectedStoreIndex})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomSizedTextBox(
          addPadding: true,
          textContent: "SELECT PICKUP STORE *",
          isBold: true,
          fontSize: 11,
        ),
        ListView.builder(
            physics: const ClampingScrollPhysics(),
            shrinkWrap: true,
            itemCount: storeLocations.length,
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () {
                  function(index);
                },
                child: Container(
                  color: Colors.white,
                  margin: const EdgeInsets.symmetric(vertical: 5),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Radio(
                        value: index,
                        activeColor: CustomColors.blue,
                        groupValue: selectedStoreIndex,
                        onChanged: (val) {},
                      ),
                      Flexible(
                        child: CustomStoreLocation(
                          storeLocation: storeLocations[index],
                        ),
                      )
                    ],
                  ),
                ),
              );
            }),
      ],
    );
  }
}

class _NewTimeWidget extends StatelessWidget {
  final String timeInString;
  final Function function;
  final int hour;
  final int selectedHour;
  final int selectedMinute;

  const _NewTimeWidget(
      {Key key,
      this.function,
      this.hour,
      this.timeInString,
      this.selectedHour,
      this.selectedMinute})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        function(hour, 00);
      },
      child: Container(
        height: 42,
        decoration: BoxDecoration(
          color: selectedHour == hour ? CustomColors.blue : Colors.white,
          border: Border.all(
            color: selectedHour == hour ? CustomColors.blue : Colors.black,
             
          ),
          borderRadius: BorderRadius.circular(5),
        ),
        padding: const EdgeInsets.all(8),
        margin: const EdgeInsets.all(2),
        child: CustomSizedTextBox(
          fontSize: 12,
          isCenter: true,
          textContent: timeInString,
          color: selectedHour == hour ? Colors.white : Colors.black,
          isBold: selectedHour == hour ? true : false,
        ),
      ),
    );
  }
}

class _DayWidget extends StatefulWidget {
  final DateTime date;
  final Function function;
  final int selectedDay;
  final int selectedMonth;
  final int selectedYear;

  const _DayWidget(
      {Key key,
      this.date,
      this.function,
      this.selectedDay,
      this.selectedMonth,
      this.selectedYear})
      : super(key: key);

  @override
  State<_DayWidget> createState() => _DayWidgetState();
}

class _DayWidgetState extends State<_DayWidget> {
  @override
  Widget build(BuildContext context) {
    final String dateInString =
        "${widget.date.day} ${months[widget.date.month - 1]}";
    return GestureDetector(
      onTap: () {
        widget.function(widget.date.day, widget.date.month, widget.date.year);
      },
      child: Container(
        decoration: BoxDecoration(
            color: widget.date.day == widget.selectedDay
                ? CustomColors.blue
                : Colors.white,
            border: Border.all(
              color: widget.date.day == widget.selectedDay
                  ? CustomColors.blue
                  : Colors.black,
            ),
            borderRadius: BorderRadius.circular(5)),
        padding: const EdgeInsets.all(8),
        margin: const EdgeInsets.all(2),
        child: CustomSizedTextBox(
          textContent: dateInString,
          fontSize: 13,
          color: widget.date.day == widget.selectedDay
              ? Colors.white
              : Colors.black,
          isBold: widget.date.day == widget.selectedDay ? true : false,
        ),
      ),
    );
  }
}
