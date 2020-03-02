import sys
import os
from os.path import abspath, dirname, join

from PySide2.QtCore import QObject, Slot, QUrl
from PySide2.QtGui import QGuiApplication
from PySide2.QtQml import QQmlApplicationEngine

# это по факту не надо
from PySide2.QtQuick import QQuickView
from PySide2.QtWidgets import QApplication

class Bridge(QObject):
	
	string_information = "test"
	
	@Slot(str, result = str)
	def set_settings(self, arg):
		if (arg == "test"):
			return "Hello"
	
	# в слоту пишется принимаемый объект и результат работы слота	
	@Slot(result = str)
	def set_settings_2(self):
		return "Hello"
		
	#take information from textField
	@Slot (str)
	def get_information(self,string_with_information):
		#launch_diagslave = "./diagslave -m rtu -a 1 -b 115200 -d 8 -s 1 -p none /dev/ttyS0"
		#os.system(launch_diagslave)
		print(string_with_information)
	
	#так же получим инфу от всех полей и запустим diagslave
	#Блочит форму - скорей всего надо запускать в другом треде
	
	#@Slot()

if __name__ == '__main__':
    app = QGuiApplication(sys.argv)
    engine = QQmlApplicationEngine()

    # Instance of the Python object
    bridge = Bridge()

    # Expose the Python object to QML
    context = engine.rootContext()
    context.setContextProperty("obj", bridge)

    # Get the path of the current directory, and then add the name
    # of the QML file, to load it.
    #qmlFile = join(dirname(__file__), 'base.qml')
    qmlFile = join(dirname(__file__), 'gui-main.qml')
    engine.load(abspath(qmlFile))

    if not engine.rootObjects():
        sys.exit(-1)

    sys.exit(app.exec_())
