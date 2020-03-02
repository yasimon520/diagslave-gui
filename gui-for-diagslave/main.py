import sys
import os
import subprocess
import random
from os.path import abspath, dirname, join

from PySide2.QtCore import QObject, Slot, QUrl, Signal
from PySide2.QtGui import QGuiApplication
from PySide2.QtQml import QQmlApplicationEngine


class Bridge(QObject):
	
	def __init__(self):
		QObject.__init__(self)
	
	
	nextNumber = Signal(str)
	
	# for test
	@Slot()
	def giveNumber(self):
		#self.nextNumber.emit(random.randint(0, 99))
		self.nextNumber.emit("test")
		
	#take information from textField and btn(connection)
	@Slot (str) 
	def get_information(self,
						string_with_cmd):
							
							
		#launch_diagslave = "./diagslave -m rtu -a 1 -b 115200 -d 8 -s 1 -p none /dev/ttyS0"
		#os.system(launch_diagslave)
		
		if (string_with_cmd == "stop"):
			print("ya iz pythona")
		else:
			p = subprocess.Popen(string_with_cmd, stdout=subprocess.PIPE,shell=True)
			
			for line in iter(p.stdout.readline, b''):
				#тут сигнал должны испустить
				#self.line_printed.emit(str(line.rstrip))
				self.LinePrinted.emit(line.decode('utf-8', errors='ignore'))
				#print(">>>" + line.decode('utf-8', errors='ignore'))
		
		
		print(string_with_cmd)


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
