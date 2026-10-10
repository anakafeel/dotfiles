import QtQuick
import Quickshell
import qs.Common
import qs.Modules.Plugins

// Day name, dot-matrix time with AM/PM, and two date/month tiles.
DesktopPluginComponent {
    id: root

    implicitWidth: 260
    implicitHeight: 200
    minWidth: 200
    minHeight: 150

    readonly property color textColor: "#ffffff"
    readonly property color tileColor: Qt.rgba(1, 1, 1, 0.92)
    readonly property color tileTextColor: "#3a3a3a"
    readonly property real s: Math.min(width / 260, height / 200)

    SystemClock {
        id: clock
        precision: SystemClock.Minutes
    }

    Column {
        anchors.left: parent.left
        anchors.bottom: parent.bottom
        spacing: 6 * root.s

        Text {
            text: clock.date.toLocaleDateString(Qt.locale(), "dddd").toUpperCase()
            color: root.textColor
            font.family: SettingsData.fontFamily
            font.pixelSize: 15 * root.s
            font.weight: Font.Medium
            font.letterSpacing: 1.5 * root.s
            style: Text.Raised
            styleColor: Qt.rgba(0, 0, 0, 0.25)
        }

        Row {
            spacing: 6 * root.s

            Text {
                id: timeText
                text: Qt.formatTime(clock.date, SettingsData.use24HourClock ? "HH:mm" : "hh:mm")
                color: root.textColor
                font.family: "Doto"
                font.pixelSize: 54 * root.s
                font.weight: Font.Black
                font.variableAxes: { "wght": 900, "ROND": 100 }
                style: Text.Raised
                styleColor: Qt.rgba(0, 0, 0, 0.25)
            }

            Text {
                anchors.baseline: timeText.baseline
                text: clock.date.getHours() < 12 ? "AM" : "PM"
                color: Qt.rgba(1, 1, 1, 0.85)
                font.family: SettingsData.fontFamily
                font.pixelSize: 12 * root.s
                style: Text.Raised
                styleColor: Qt.rgba(0, 0, 0, 0.25)
                font.weight: Font.Medium
            }
        }

        Row {
            spacing: 8 * root.s

            Repeater {
                model: [
                    { value: Qt.formatDate(clock.date, "dd"), label: "DATE" },
                    { value: Qt.formatDate(clock.date, "MM"), label: "MONTH" }
                ]

                delegate: Column {
                    required property var modelData
                    spacing: 3 * root.s

                    Rectangle {
                        width: 52 * root.s
                        height: 40 * root.s
                        radius: 10 * root.s
                        color: root.tileColor

                        Text {
                            anchors.centerIn: parent
                            text: modelData.value
                            color: root.tileTextColor
                            font.family: SettingsData.fontFamily
                            font.pixelSize: 18 * root.s
                            font.weight: Font.DemiBold
                        }
                    }

                    Text {
                        anchors.horizontalCenter: parent.horizontalCenter
                        text: modelData.label
                        color: Qt.rgba(1, 1, 1, 0.85)
                        font.family: SettingsData.fontFamily
                        font.pixelSize: 8 * root.s
                        font.weight: Font.Medium
                        style: Text.Raised
                        styleColor: Qt.rgba(0, 0, 0, 0.35)
                        font.letterSpacing: 1 * root.s
                    }
                }
            }
        }
    }
}
