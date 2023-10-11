import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:futsal_client_front/common/component/container/responsive_container.dart';
import 'package:futsal_client_front/common/component/container/stack_container.dart';
import 'package:futsal_client_front/common/styles/sizes.dart';
import 'package:futsal_client_front/common/styles/text_styles.dart';
import 'package:futsal_client_front/common/utils/date_utils.dart';
import 'package:futsal_client_front/reservation_status/component/custom_table_calendar.dart';
import 'package:futsal_client_front/reservation_status/component/reservation_state/reservation_state_list.dart';
import 'package:futsal_client_front/reservation_status/viewmodel/reservation_status_viewmodel.dart';

class ReservationStatusView extends ConsumerWidget {
  const ReservationStatusView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final viewmodel = ref.watch(reservationStatusViewModelProvider);

    return ResponsiveContainer(
      children: [
        ResponsiveWidget(
          wFlex: 7,
          mFlex: 1,
          child: StackContainer(
            child: CustomTimeTable(
              controller: viewmodel.customTimeTableController,
            ),
          ),
        ),
        ResponsiveSizedBox(size: kLayoutGutterSize),
        ResponsiveWidget(
          wFlex: 5,
          mFlex: 1,
          child: Column(
            children: [
              Row(
                children: [
                  SizedBox(width: kPaddingMiddleSize * 3),
                  Expanded(
                    child: Text(
                      '${viewmodel.customTimeTableController.focusedDay.month}월 ${viewmodel.customTimeTableController.focusedDay.day}일 (${getDayOfWeek(viewmodel.customTimeTableController.focusedDay).substring(0, 1)})',
                      style: kTextMainStyle.copyWith(fontSize: kTextLargeSize),
                    ),
                  ),
                ],
              ),
              SizedBox(height: kPaddingLargeSize),
              Expanded(
                child: ReservationStateList(
                  state: viewmodel.statusState,
                  reservationStatusList: viewmodel.reservationStatusList,
                  onClick: viewmodel.onReservationStateItemClicked,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
