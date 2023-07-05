import 'package:cigarKey/controllers/userController.dart';
import 'package:cigarKey/presentation/custom__icons_icons.dart';
import 'package:cigarKey/screens/Menu/Tabs/FavoritesPage.dart';
import 'package:cigarKey/screens/Lounges/LocationPage.dart';
import 'package:cigarKey/screens/Menu/Tabs/MenuPage.dart';
import 'package:cigarKey/screens/Profile/Profile.dart';
import 'package:cigarKey/screens/Menu/Tabs/ScanQRPage.dart';
import 'package:cigarKey/utils/notification_api.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:geofence_service/geofence_service.dart';
// import 'package:location/location.dart' as locate;
import 'package:cigarKey/utils/notification_api.dart';
import 'dart:async';

import '../../providers/provider.dart';

class TabBarPage extends StatefulWidget {
  const TabBarPage({Key? key}) : super(key: key);

  @override
  State<TabBarPage> createState() => _TabBarPageState();
}

class _TabBarPageState extends State<TabBarPage>
    with SingleTickerProviderStateMixin {
  UserController user = Get.put(UserController());

  // locate.Location location = locate.Location();
  List? cor;

  final _geofenceStreamController = StreamController<Geofence>();
  final _activityStreamController = StreamController<Activity>();

  final _geofenceService = GeofenceService.instance.setup(
      interval: 5000,
      accuracy: 100,
      loiteringDelayMs: 60000,
      statusChangeDelayMs: 10000,
      useActivityRecognition: true,
      allowMockLocations: false,
      printDevLog: false,
      geofenceRadiusSortType: GeofenceRadiusSortType.DESC);
  final _geofenceList = <Geofence>[
    Geofence(
      id: 'place_1',
      latitude: 39.9635637,
      longitude: -75.1352307,
      radius: [
        GeofenceRadius(id: 'radius_100m', length: 150),
      ],
    ),
    Geofence(
      id: 'place_2',
      latitude: 39.9494832,
      longitude: -75.1693014,
      radius: [
        GeofenceRadius(id: 'radius_100m', length: 150),
      ],
    ),
    Geofence(
      id: 'place_3',
      latitude: 39.948392,
      longitude: -75.1643196,
      radius: [
        GeofenceRadius(id: 'radius_100m', length: 150),
      ],
    ),
    Geofence(
      id: 'place_4',
      latitude: 39.9656374,
      longitude: -75.1377072,
      radius: [
        GeofenceRadius(id: 'radius_100m', length: 150),
      ],
    ),
    Geofence(
      id: 'place_5',
      latitude: 40.0747381,
      longitude: -75.3080796,
      radius: [
        GeofenceRadius(id: 'radius_100m', length: 150),
      ],
    ),
    Geofence(
      id: 'place_6',
      latitude: 40.0946817,
      longitude: -75.360919,
      radius: [
        GeofenceRadius(id: 'radius_100m', length: 150),
      ],
    ),
    Geofence(
      id: 'place_7',
      latitude: 40.1013428,
      longitude: -75.154344,
      radius: [
        GeofenceRadius(id: 'radius_100m', length: 150),
      ],
    ),
    Geofence(
      id: 'place_7',
      latitude: 28.203029,
      longitude: -105.464386,
      radius: [
        GeofenceRadius(id: 'radius_100m', length: 150),
      ],
    ),
  ];
  Future<void> _onGeofenceStatusChanged(
      Geofence geofence,
      GeofenceRadius geofenceRadius,
      GeofenceStatus geofenceStatus,
      Location location) async {
    print('geofence: ${geofence.toJson()}');
    print('geofenceRadius: ${geofenceRadius.toJson()}');
    print('geofenceStatus: ${geofenceStatus.toString()}');
    if (geofenceStatus.toString() == "GeofenceStatus.ENTER") {
      NotificationApi.showNotification(
          title: "Cigar Key Location", body: "The lounge Cigar Key is close");
    }
    _geofenceStreamController.sink.add(geofence);
  }

  void _onLocationChanged(Location location) {
    print('location now: ${location.toJson()}');
  }

  void _onLocationServicesStatusChanged(bool status) {
    print('isLocationServicesEnabled: $status');
  }

  void _onActivityChanged(Activity prevActivity, Activity currActivity) {
    print('prevActivity: ${prevActivity.toJson()}');
    print('currActivity: ${currActivity.toJson()}');
  }

  void _onError(error) {
    final errorCode = getErrorCodesFromError(error);
    if (errorCode == null) {
      print('Undefined error: $error');
      return;
    }

    print('ErrorCode: $errorCode');
  }

  _TabBarPageState() : super();

  TabController? _tabController;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _geofenceService
          .addGeofenceStatusChangeListener(_onGeofenceStatusChanged);
      _geofenceService.addLocationChangeListener(_onLocationChanged);
      _geofenceService.addLocationServicesStatusChangeListener(
          _onLocationServicesStatusChanged);
      _geofenceService.addActivityChangeListener(_onActivityChanged);
      _geofenceService.addStreamErrorListener(_onError);
      user.notification.value
          ? _geofenceService.start(_geofenceList).catchError(_onError)
          : null;
    });
    NotificationApi.init();
    var provider = Provider.of<MyProvider>(context, listen: false);
    if (_tabController?.index != null) {
      _tabController = new TabController(
          vsync: this, length: 5, initialIndex: _tabController!.index);
    } else {
      _tabController = new TabController(
          vsync: this,
          length: 5,
          initialIndex: provider.myIndex != 0 ? provider.myIndex : 0);
    }
  }

  @override
  void dispose() {
    _tabController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // TabController _tabController =
    //     TabController(length: 5, vsync: this, initialIndex: 1);

    // final widthSize = MediaQuery.of(context).size.width;
    final heightSize = MediaQuery.of(context).size.height;
    return WillStartForegroundTask(
      onWillStart: () async {
        // You can add a foreground task start condition.
        return _geofenceService.isRunningService;
      },
      foregroundTaskOptions: ForegroundTaskOptions(),
      androidNotificationOptions: AndroidNotificationOptions(
        channelId: 'geofence_service_notification_channel',
        channelName: 'Geofence Service Notification',
        channelDescription:
            'This notification appears when the geofence service is running in the background.',
        channelImportance: NotificationChannelImportance.LOW,
        priority: NotificationPriority.LOW,
        isSticky: false,
      ),
      iosNotificationOptions: const IOSNotificationOptions(),
      notificationTitle: 'Geofence Service is running',
      notificationText: 'Tap to return to the app',
      child: Scaffold(
          resizeToAvoidBottomInset: false,
          body: Stack(children: [
            Container(
              height: heightSize * 1,
              child: TabBarView(controller: _tabController, children: [
                MenuPage(_tabController!),
                LocationPage(),
                ScanQRMenu(),
                FavoritesPage(),
                ProfilePage(_tabController),
              ]),
            ),
            Container(
              child: Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                    decoration: BoxDecoration(
                        color: Color.fromRGBO(34, 30, 31, 1),
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(21),
                            topRight: Radius.circular(21))),
                    width: double.maxFinite,
                    height: heightSize * .08,
                    child: TabBar(
                        onTap: (_) =>
                            FocusManager.instance.primaryFocus?.unfocus(),
                        controller: _tabController,
                        labelColor: Color.fromRGBO(156, 27, 23, 1),
                        unselectedLabelColor: Color.fromRGBO(107, 97, 100, 1),
                        indicator:
                            CircleTabIndicator(color: Colors.white, radius: 3),
                        tabs: [
                          Tab(
                            icon: Icon(
                              CustomIcons.home,
                              size: heightSize * 0.028,
                            ),
                          ),
                          Tab(
                            icon: Icon(
                              CustomIcons.location,
                              size: heightSize * 0.028,
                            ),
                          ),
                          Tab(
                              icon: Icon(
                            CustomIcons.scan,
                            size: heightSize * 0.028,
                          )),
                          Tab(
                            icon: Icon(
                              CustomIcons.favorites_1,
                              size: heightSize * 0.028,
                            ),
                          ),
                          Tab(
                            icon: Icon(
                              CustomIcons.profile,
                              size: heightSize * 0.028,
                            ),
                          ),
                        ])),
              ),
            ),
          ])),
    );
  }
}

class CircleTabIndicator extends Decoration {
  final BoxPainter _painter;

  CircleTabIndicator({required Color color, required double radius})
      : _painter = _CirclePainter(color, radius);

  @override
  BoxPainter createBoxPainter([VoidCallback? onChanged]) => _painter;
}

class _CirclePainter extends BoxPainter {
  final Paint _paint;
  final double radius;

  _CirclePainter(Color color, this.radius)
      : _paint = Paint()
          ..color = color
          ..isAntiAlias = true;

  @override
  void paint(Canvas canvas, Offset offset, ImageConfiguration cfg) {
    final Offset circleOffset =
        offset + Offset(cfg.size!.width / 2, cfg.size!.height - radius - 5);
    canvas.drawCircle(circleOffset, radius, _paint);
  }
}
