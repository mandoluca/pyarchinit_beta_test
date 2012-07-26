"""
/***************************************************************************
 testerDialog
								 A QGIS plugin
 test print
							 -------------------
		begin				 : 2012-06-20
		copyright			 : (C) 2012 by luca
		email				 : pyarchinit@gmail.com
 ***************************************************************************/

/***************************************************************************
 *																		   *
 *	 This program is free software; you can redistribute it and/or modify  *
 *	 it under the terms of the GNU General Public License as published by  *
 *	 the Free Software Foundation; either version 2 of the License, or	   *
 *	 (at your option) any later version.								   *
 *																		   *
 ***************************************************************************/
"""
from PyQt4 import QtCore, QtGui
from PyQt4.QtCore import *
from PyQt4.QtGui import *
import PyQt4.QtGui

from qgis.core import *
from qgis.gui import *

#from ui_tester import Ui_tester
# create the dialog for zoom to point
class print_utility:
	layerUS = ""
	layerQuote = ""
	height = ""
	width = ""
	USLayerId = ""
	
	def __init__(self, data):
		self.data = data
	
	"""
	def on_pushButton_runTest_pressed(self):
		self.first_batch_try()
    """

	def first_batch_try(self):
		for i in self.data:
			self.charge_layer_postgis(i[0].gid)
			self.test_bbox()
			self.print_map(i)
		
		
	def converter_1_20(self, n):
		n *= 100
		res = n / 20
		return res

	def test_bbox(self):
		self.layerUS.select( [] ) # recuperi tutte le geometrie senza attributi
		featPoly = QgsFeature() # crei una feature vuota per il poligono

		dizionario_id_contains = {}
		lista_quote = []

		self.layerUS.nextFeature( featPoly ) # cicli sulle feature recuperate, featPoly conterra la feature poligonale attuale
		bbox = featPoly.geometry().boundingBox() # recupera i punti nel bbox del poligono

		self.height = self.converter_1_20(float(bbox.height()))
		self.width = self.converter_1_20(float(bbox.width()))
		mis = "H: " + str(self.height) + ", W: " + str(self.width)
		
		f = open("/test_bbox.txt", "w")
		f.write(str(mis))
		f.close()
		
	def getMapExtentFromMapCanvas(self,	 mapWidth, mapHeight, scale):
		print "in methode: " + str(scale)

		xmin = self.canvas.extent().xMinimum()
		xmax = self.canvas.extent().xMaximum()
		ymin = self.canvas.extent().yMinimum()
		ymax = self.canvas.extent().yMaximum()
		xcenter = xmin + (xmax - xmin) / 2
		ycenter = ymin + (ymax - ymin) / 2 

		mapWidth = mapWidth * scale / 1000
		mapHeight = mapHeight * scale / 1000
		minx = xcenter - mapWidth / 2
		miny = ycenter - mapHeight / 2
		maxx = xcenter + mapWidth / 2
		maxy = ycenter + mapHeight / 2 

		return QgsRectangle(minx,  miny,  maxx,	 maxy)

	def print_map(self, tav_num):
		self.tav_num = tav_num
		
		mapRenderer = self.iface.mapCanvas().mapRenderer()
		mapRenderer.setScale(20.0)
		mapRenderer.updateScale()
		
		c = QgsComposition(mapRenderer)
		c.setPlotStyle(QgsComposition.Print)

		#map - this item tells the libraries where to put the map itself. Here we create a map and stretch it over the whole paper size:
		x, y = 10,10
		
		w, h = c.paperWidth(), c.paperHeight()
		composerMap = QgsComposerMap(c, x, y, w, h)
		rect = self.getMapExtentFromMapCanvas(c.paperWidth(), c.paperHeight(),	 20.0)
		composerMap.setNewExtent(rect)
		
		c.addItem(composerMap)

		#scale bar
		item = QgsComposerScaleBar(c)
		item.setStyle('Numeric') # optionally modify the style
		item.setComposerMap(composerMap)
		item.applyDefaultSize()
		c.addItem(item)

		width = 490
		height = 420
		dpi = 100

		c.setPaperSize(width, height)
		c.setPrintResolution(dpi)

		#Output to a raster image
		#The following code fragment shows how to render a composition to a raster image:

		dpi = c.printResolution()
		dpmm = dpi / 25.4
		width = int(dpmm * c.paperWidth())
		height = int(dpmm * c.paperHeight())

		# create output image and initialize it
		image = QImage(QSize(width, height), QImage.Format_ARGB32)
		image.setDotsPerMeterX(dpmm * 1000)
		image.setDotsPerMeterY(dpmm * 1000)
		image.fill(0)

		# render the composition
		imagePainter = QPainter(image)
		sourceArea = QRectF(0, 0, c.paperWidth(), c.paperHeight())
		targetArea = QRectF(0, 0, width, height)
		c.render(imagePainter, targetArea, sourceArea)
		imagePainter.end()
		tav_name = "/pyarchinit_image_tester" + str(self.tav_num) +".png"
		try:
			image.save(str(tav_name), "png")
		except Excpetion, e:
			f = open("/test_print.txt", "w")
			f.write(str(e))
			f.close()
			
		
		#QgsMapLayerRegistry.instance().removeMapLayer(layer_id)

		#Output to PDF
		#The following code fragment renders a composition to a PDF file:

		printer = QPrinter()
		printer.setOutputFormat(QPrinter.PdfFormat)
		printer.setOutputFileName("/out.pdf")
		printer.setPaperSize(QSizeF(c.paperWidth(), c.paperHeight()), QPrinter.Millimeter)
		printer.setFullPage(True)
		printer.setColorMode(QPrinter.Color)
		printer.setResolution(c.printResolution())

		pdfPainter = QPainter(printer)
		paperRectMM = printer.pageRect(QPrinter.Millimeter)
		paperRectPixel = printer.pageRect(QPrinter.DevicePixel)
		c.render(pdfPainter, paperRectPixel, paperRectMM)
		pdfPainter.end()
		
		QgsMapLayerRegistry.instance().removeMapLayer(self.USLayerId)


	def charge_layer_postgis(self, gid):
		uri = QgsDataSourceURI()
		# set host name, port, database name, username and password

		uri.setConnection('127.0.0.1','5432', 'pyarchinit', 'postgres', 'alajolla39')

		srs = QgsCoordinateReferenceSystem(3004, QgsCoordinateReferenceSystem.PostgisCrsId)

		gidstr = "gid = %d" % gid
		uri.setDataSource("public", "pyunitastratigrafiche", "the_geom", gidstr)
		self.layerUS = QgsVectorLayer(uri.uri(), "US", "postgres")

		if	self.layerUS.isValid() == True:
			self.layerUS.setCrs(srs)
			self.USLayerId = self.layerUS.getLayerID()
			#self.mapLayerRegistry.append(USLayerId)
			#style_path = ('%s%s') % (self.LAYER_STYLE_PATH, 'us_caratterizzazioni.qml')
			# self.layerUS.loadNamedStyle(style_path)
			self.iface.mapCanvas().setExtent(self.layerUS.extent())
			QgsMapLayerRegistry.instance().addMapLayer( self.layerUS, True)
		else:
			print "Layer US is not valid!!!"
		
		"""
		gidstr = "sito = 'test'"
		uri.setDataSource("public", "pyarchinit_punti_rif", "the_geom", gidstr)
		self.layerGriglia = QgsVectorLayer(uri.uri(), "Griglia a 50 cm", "postgres")

		if	self.layerGriglia.isValid() == True:
			self.layerGriglia.setCrs(srs)
			layerGrigliaId =  self.layerGriglia.getLayerID()
			#self.mapLayerRegistry.append(USLayerId)
			#style_path = ('%s%s') % (self.LAYER_STYLE_PATH, 'stile_griglia.qml')
			#self.layerGriglia.loadNamedStyle(style_path)
			#self.iface.mapCanvas().setExtent(self.layerUS.extent())
			QgsMapLayerRegistry.instance().addMapLayer( self.layerGriglia, True)
		else:
			print "layerGriglia US is not valid!!!"



		
		uri.setDataSource("public", "pyarchinit_uscaratterizzazioni_view", "the_geom", gidstr)
		layerCar = QgsVectorLayer(uri.uri(), "Unita' Stratigrafiche", "postgres")

		if	layerCar.isValid() == True:
			layerCar.setCrs(srs)
			CARLayerId = layerCar.getLayerID()
			self.mapLayerRegistry.append(CARLayerId)
			#style_path = ('%s%s') % (self.LAYER_STYLE_PATH, 'us_caratterizzazioni.qml')
			# self.layerUS.loadNamedStyle(style_path)
			QgsMapLayerRegistry.instance().addMapLayer(layerCar, True)
		else:
			print "Layer Caratterizzazioni is not valid!!!"

		
		gidstr = "gid = 2257  or gid = 2849 or gid = 2443  or gid = 2370 or gid = 2297	 or gid = 2852	or gid = 2299  or gid = 2225 or gid = 2226	or gid = 2448 or gid = 2862 or gid = 2863 or gid = 2717 or gid = 2718  or gid = 2427  or gid = 2429	 or gid = 2245	or gid = 2652  or gid = 2285 or gid = 2287 or gid = 2288 or gid = 2289 or gid = 2844  or gid = 2290 or gid = 2475 or gid = 2845 or gid = 2328"

		uri.setDataSource("public", "pyarchinit_quote", "the_geom", gidstr)
		self.layerQuote = QgsVectorLayer(uri.uri(), "Quote", "postgres")

		if	self.layerQuote.isValid() == True:
			self.layerQuote.setCrs(srs)
			QuoteLayerId = self.layerQuote.getLayerID()
			#self.mapLayerRegistry.append(QuoteLayerId)
			#style_path = ('%s%s') % (self.LAYER_STYLE_PATH, 'us_caratterizzazioni.qml')
			# self.layerUS.loadNamedStyle(style_path)
			QgsMapLayerRegistry.instance().addMapLayer(self.layerQuote, True)
		else:
			print "Layer Quote is not valid!!!"

		#Print section

		# create image
		"""


	def serch_points_in_plygons(self):
		if self.layerUS.isValid():
			print "Layer polygons loaded!" 

		if self.layerQuote.isValid(): 
			print "Layer points loaded!" #si testa se il punto e' stato caricato correttamente

		####################################################################################################################################################
		#--------------Blocco per il test contains tra punti e poligoni e generazione del dizionario degli id delle features-------------------------------#
		####################################################################################################################################################
		self.layerUS.select( [] ) # recuperi tutte le geometrie senza attributi
		featPoly = QgsFeature() # crei una feature vuota per il poligono

		self.layerQuote.select( [] ) # recuperi tutte le geometrie senza attributi
		featPoint = QgsFeature() # crei una feature vuota per il punto

		dizionario_id_contains = {}
		lista_quote = []

		while self.layerUS.nextFeature( featPoly ): # cicli sulle feature recuperate, featPoly conterra la feature poligonale attuale
			self.layerQuote.select( [], featPoly.geometry().boundingBox() ) # recupera i punti nel bbox del poligono
			featPoint = QgsFeature() # crei una feature vuota per il punto

			while self.layerQuote.nextFeature( featPoint ): # cicli sulle feature recuperate, featPoint conterra la feature puntale attuale
				if featPoly.geometry().contains( featPoint.geometry() ): # adesso con la contains() verifichi che effettivamente sia contenuto nel poligono
					lista_quote.append(featPoint.id())
			dizionario_id_contains[featPoly.id()] = lista_quote
			lista_quote = []

		print "dizionario_id_contains", dizionario_id_contains #il dizionario contiene come chiave l'id del poligono e come valore una lista di id delle quote contenute nel poligono

		####################################################################################################################################################
		#-------------------Blocco che recupera degli id contenuti in tabella dei punti a partire dal dizionario_id_contains-------------------------------#
		####################################################################################################################################################

		vlPointProvider = self.layerQuote.dataProvider() #viene definito il provider del layer
		pointsFieldmap = vlPointProvider.fields() #viene realizzata la mappatura dei singoli campi

		self.layerUSProvider = self.layerUS.dataProvider() #viene definito il provider del layer
		polygonsFieldmap = self.layerUSProvider.fields() #viene realizzata la mappatura dei singoli campi

		vlPointProvider.rewind()
		self.layerUSProvider.rewind()

		for (k,attr) in pointsFieldmap.iteritems(): #itera sul layer nella mappa delle colonne
			if "gid" == attr.name(): #se trova un campo con nome "id_punto" col assume il numero della chiave corrispondente a quel valore
				col = k #<-[1]
		allAttrs = vlPointProvider.attributeIndexes() #viene assegnato al point provider indice degli attributi
		vlPointProvider.select(allAttrs) #il point provider seleziona tutte le geometrie con gli attributi

		id_selection = []
		values_selection = []

		fPoints=QgsFeature() #crea una feature vuota per i punti a cui passare i valori che ci interessano
		fPolygons=QgsFeature() #crea una feature vuota per i poligoni per recuperare l'id del poligono

		allAttrsPolygons = self.layerUSProvider.attributeIndexes() #viene assegnato al point provider indice degli attributi
		self.layerUSProvider.select(allAttrsPolygons) #il point provider seleziona tutte le geometrie con gli attributi

		dizionario_id_poligono = {}

		for (k,attr) in dizionario_id_contains.iteritems():
			while (self.layerUSProvider.nextFeature(fPolygons)): #itera su pointProvider passando le singole feature a f
				polygonsFieldmap=fPolygons.attributeMap()

				if fPolygons.id() == k:
					valore = polygonsFieldmap[0].toString()

					while (vlPointProvider.nextFeature(fPoints)): #itera su pointProvider passando le singole feature a f
						pointsFieldmap=fPoints.attributeMap() #viene definita la fieldmap della singola feauture contenuta in 
						elenco_quote = dizionario_id_contains[fPolygons.id()]
						for id_punto in elenco_quote:
							if fPoints.id() == id_punto: #se l'id contenuto nel dizionario, corrisponde all'id del punto
								self.layerUS.nextFeature(fPolygons) #recupera l'id del poligono dalla chiave del dizionario strati

								id_selection.append(fPoints.id()) #viene passata alla lista selection l'id della singola feauture
								values_selection.append(pointsFieldmap[col].toString())
					dizionario_id_poligono[int(valore)] = values_selection

		self.layerQuote.setSelectedFeatures(id_selection) #seleziona i punti in base al valore dell'id
		
		f = open("/test_contains.txt", "w")
		f.write(str(dizionario_id_poligono))
		f.close()

		print "dizionario_id_poligono", dizionario_id_poligono
		print "#################################################################################"
		print "###########################----Risultato-----###################################"
		for (k,values) in dizionario_id_poligono.iteritems():
			print "Il poligono ID: ", k, " contiene i seguenti punti: "
			for i in values:
				print "id_punto: ", i
