import QtQuick 2.9
import QtQuick.Window 2.2
import QtQuick.Controls 1.6

Window {
    id: root

    visible: true
    width: 640
    height: 500
    title: qsTr("guidiagslave")

    Text {
        id: element
        x: 8
        y: 3
        width: 124
        height: 15
        text: qsTr("Settings for connection")
        font.pixelSize: 18

    }

    Rectangle {
        id: rectangle
        x: 8
        y: 28
        width: 215
        height: 463
        color: "#f7fbdb"
        border.color: "#665d5d"

        Text {
            id: element1
            x: 13
            y: 8
            text: qsTr("Serial port")
            font.pixelSize: 16
        }

        ComboBox {
            id: serialport
            x: 13
            y: 34

            model: ListModel
            {
                id: items_serialports
                ListElement {text: "ttyS0";}
                ListElement {text: "ttyS1"; }
            }
        }

        Text {
            id: element2
            x: 12
            y: 126
            text: qsTr("Baubrate")
            font.pixelSize: 16
        }

        ComboBox {
            id: baubrate
            x: 12
            y: 152

            currentIndex:3


            model: ListModel
            {
                id: items_baubrate

                ListElement {text: "1200";}
                ListElement {text: "2400";}
                ListElement {text: "4800";}
                ListElement {text: "9600";}
                ListElement {text: "19200";}
                ListElement {text: "38400";}
                ListElement {text: "57600";}
                ListElement {text: "115200";}
                ListElement {text: "125000";}
                ListElement {text: "230400";}
                ListElement {text: "250000";}
                ListElement {text: "460800";}
                ListElement {text: "500000";}
                ListElement {text: "921600";}
                ListElement {text: "1000000";}
                ListElement {text: "2000000";}
            }
        }

        Text {
            id: element3
            x: 12
            y: 185
            text: qsTr("Data bits")
            font.pixelSize: 16
        }

        ComboBox {
            id: databits
            x: 12
            y: 211


            currentIndex: 3


            model: ListModel
            {
                id: items_databits
                ListElement {text: "5";}
                ListElement {text: "6";}
                ListElement {text: "7";}
                ListElement {text: "8";}
                ListElement {text: "9";}
            }
        }

        Text {
            id: element4
            x: 13
            y: 244
            text: qsTr("Stop bits")
            font.pixelSize: 16
        }

        ComboBox {
            id: stopbits
            x: 13
            y: 270

            currentIndex: 0


            model: ListModel
            {
                id: items_stopbits
                ListElement {text: "1";}
                ListElement {text: "2";}
            }
        }

        Text {
            id: element5
            x: 12
            y: 303
            text: qsTr("Parity")
            font.pixelSize: 16
        }

        ComboBox {
            id: parity
            x: 12
            y: 329

            currentIndex: 0


            model: ListModel
            {
                id: items_parity
                ListElement {text: "none";}
                ListElement {text: "odd";}
                ListElement {text: "even";}
            }
        }

        Text {
            id: element6
            x: 13
            y: 67
            text: qsTr("Protocols")
            font.pixelSize: 16
        }

        ComboBox {
            id: protocols
            x: 13
            y: 93

            currentIndex: 0

            model: ListModel
            {
                id: items_protocols
                ListElement {text: "rtu";}
                ListElement {text: "ascii"; }
                ListElement {text: "tcp"; }
            }
        }

        Text {
            id: element7
            x: 14
            y: 362
            text: qsTr("Number register")
            font.pixelSize: 16
        }

        Button {
            id: button_connection
            x: 40
            y: 428
            width: 148
            height: 27
            text: qsTr("Connection")

            onClicked: {

                // example -
                // "./diagslave -m rtu -a 1 -b 115200 -d 8 -s 1 -p none /dev/ttyS0"

                /*var string_for_diagslave = "./diagslave -m " + protocols.currentText +
                                           " -a " + spinBox.value +
                                           " -b " + baubrate.currentText +
                                           " -d " + databits.currentText +
                                           " -s " + stopbits.currentText +
                                           " -p " + parity.currentText +
                                           " /dev/" + serialport.currentText
                */

                var string_for_diagslave = "ping www.yahoo.com"

                var stop_connection = "stop"

                if (button_connection.text == "Connection")
                {
					obj.giveNumber()
                    //obj.get_information(string_for_diagslave)
                    button_connection.text = "Disconnection"
                }
                else
                {
					obj.giveNumber()
                    //obj.get_information(stop_connection)
                    button_connection.text = "Connection"
                }



                /*  Позже посмотреть
                if (button_connection.state === true){
                    text: qsTr("Connection")
                }
                else {
                    text: qsTr("Disconnection")
                }
                */
            }
        }

        SpinBox {
            id: spinBox
            x: 14
            y: 388
            width: 123
            height: 25
            maximumValue: 255
            value: 0
            stepSize: 1
            minimumValue: 1
            decimals: 0
        }

    }


    Rectangle {
        id: rectangle1
        x: 235
        y: 28
        width: 4
        height: 463
        color: "#282525"
        border.color: "#ffffff"
    }

    TextArea {
        id: textArea
        x: 250
        y: 29
        width: 379
        height: 463
        font.pixelSize: 8
        font.weight: Font.Normal
    }

    Text {
        id: element8
        x: 250
        y: 3
        text: qsTr("Output")
        font.pixelSize: 18
    }
    
    
    // Signal argument names are not propagated from Python to QML, so we need to re-emit the signal
    signal reNextNumber(string number)
    Component.onCompleted: obj.nextNumber.connect(reNextNumber)
    //Component.onCompleted: obj.LinePrinted.connect(reNextNumber)
    
    Connections {
        target: root
        onReNextNumber: textArea.text = number
        
    }
    
    /*

    signal NewLinePrinted(var str)

    Component.onCompleted: obj.LinePrinted.connect(NewLinePrinted)

    Connections
    {
        target: root

        onNewLinePrinted: {
            textArea.text = str
        }


    }
    */
}
