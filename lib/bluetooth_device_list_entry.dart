
import 'package:flutter/material.dart';
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';
import 'package:google_fonts/google_fonts.dart';

import 'core/colors.dart';
import 'core/functions.dart';

class BluetoothDeviceListEntry extends ListTile {
  BluetoothDeviceListEntry({
    Key? key,
    required BluetoothDevice device,
    BluetoothDeviceType? a,
    int? rssi,
    GestureTapCallback? onTap,
    GestureLongPressCallback? onLongPress,
    bool enabled = true,
  }) : super(
          key: key,
          onTap: onTap,
          onLongPress: onLongPress,
          enabled: enabled,
          leading: const Icon(
              Icons.devices), // @TODO . !BluetoothClass! class aware icon
          title: Text(
            device.name ?? "",
            style: enabled
                ? GoogleFonts.sourceSansPro(fontSize: 16, color: switchesColor)
                : null,
          ),
          subtitle: Row(
            children: [
              Text(device.address.toString()),
              const SizedBox(
                width: 10,
              ),
              if (device.isBonded)
                Text(
                  "Bonded",
                  style: getTextStyle(color: switchesColor),
                ),
            ],
          ),
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              rssi != null
                  ? Container(
                      margin: const EdgeInsets.all(8.0),
                      child: DefaultTextStyle(
                        style: _computeTextStyle(rssi),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            Text(rssi.toString()),
                            const Text('dBm'),
                          ],
                        ),
                      ),
                    )
                  : const SizedBox(width: 0, height: 0),
              if (device.isConnected) const Icon(Icons.import_export)
            ],
          ),
        );

  static TextStyle _computeTextStyle(int rssi) {
    /**/ if (rssi >= -35) {
      return getTextStyle(color: Colors.greenAccent[700]);
    } else if (rssi >= -45) {
      return getTextStyle(
          color: Color.lerp(
              Colors.greenAccent[700], Colors.lightGreen, -(rssi + 35) / 10));
    } else if (rssi >= -55) {
      return getTextStyle(
          color: Color.lerp(
              Colors.lightGreen, Colors.lime[600], -(rssi + 45) / 10));
    } else if (rssi >= -65) {
      return getTextStyle(
          color: Color.lerp(Colors.lime[600], Colors.amber, -(rssi + 55) / 10));
    } else if (rssi >= -75) {
      return getTextStyle(
          color: Color.lerp(
              Colors.amber, Colors.deepOrangeAccent, -(rssi + 65) / 10));
    } else if (rssi >= -85) {
      return getTextStyle(
          color: Color.lerp(
              Colors.deepOrangeAccent, Colors.redAccent, -(rssi + 75) / 10));
    } else {
      return getTextStyle(color: Colors.redAccent);
    }
  }
}
