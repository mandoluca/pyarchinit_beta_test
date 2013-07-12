#!/usr/bin/env python



import os
import time


import sys
from PyQt4 import QtCore, QtGui
from PyQt4.QtCore import *
from PyQt4.QtGui import *
import PyQt4.QtGui
try:
	from qgis.core import *
	from qgis.gui import *
except:
	pass

from  pyarchinit_db_manager import *

from psycopg2 import *

#--import pyArchInit modules--#
from  dbmanagment_ui import Ui_DBmanagment
from  dbmanagment_ui import *
from  pyarchinit_utility import *
from  pyarchinit_error_check import *

from  pyarchinit_pyqgis import Pyarchinit_pyqgis

class pyarchinit_dbmanagment(QDialog, Ui_DBmanagment):
	MSG_BOX_TITLE = "PyArchInit - pyarchinit_version 0.4 - Scheda gestione DB"

	def __init__(self, iface):
		self.iface = iface
		self.pyQGIS = Pyarchinit_pyqgis(self.iface)
		QDialog.__init__(self)
		self.setupUi(self)
		#self.customize_GUI() #call for GUI customizations

		self.currentLayerId = None
		
	
	def enable_button(self, n):
		

		self.beckup.setEnabled(n)

	def enable_button_search(self, n):

		

		self.beckup.setEnabled(n)	

	
	def on_beckup_pressed (self):
                
	     	from pyarchinit_OS_utility import *
		import os
		import time

		if os.name == 'posix':
			home = os.environ['HOME']
		elif os.name == 'nt':
			home = os.environ['HOMEPATH']
		PDF_path = ('%s%s%s') % (home, os.sep, 'pyarchinit_db_beckup')
		filename = ('%s%s%s') % (PDF_path, os.sep, 'semivariogramma.png')
		username = 'postgres'

		defaultdb = 'pyarchinit'

		port = '5432'
		backupdir='/home/enzo/pyarchinit_db_beckup/'
		date = time.strftime('%Y-%m-%d-%H-%M-%S')

		#GET DB NAMES
		get_db_names="psql -U%s -d%s -p%s --tuples-only -c '\l' | awk -F\| '{ print $1 }' | grep -E -v '(template0|template1|^$)'" % (username, defaultdb, port)

		#MAKE BACKUP OF SYSTEMGRANTS
		os.popen("pg_dumpall -p%s -g|gzip -9 -c > %s/system.%s.gz" % (port, backupdir, date))

		#MAKING DB BACKUP
		for base in os.popen(get_db_names).readlines():
			base = base.strip()
			fulldir = backupdir + base
			if not os.path.exists(fulldir):
				os.mkdir(fulldir)
			filename = "%s/%s-%s.sql" % (fulldir, base, date)
			os.popen("nice -n 19 pg_dump -C -F c -U%s -p%s %s > %s" % (username, port, base, filename))


	def on_upload_pressed(self):
		self.percorso = QtGui.QFileDialog.getOpenFileName(self, 'Open file', '/')
		#QMessageBox.warning(self, "Messaggio", str(self.FILE), QMessageBox.Ok)


	def on_restore_pressed (self):
		path = self.percorso
		os.popen ("dropdb pyarchinit")
		os.popen ("createdb -p 5432 -h localhost -E UTF8 -e pyarchinit -T postgis2")
		os.popen ("pg_restore --host localhost --port 5432 --username 'postgres' --dbname 'pyarchinit' --role 'postgres' --no-password  --verbose %s" % (str(path)))
		

if __name__ == "__main__":
	app = QApplication(sys.argv)
	ui = pyarchinit_dbmanagment()
	ui.show()
	sys.exit(app.exec_())
		

	
