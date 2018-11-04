module Picturable
	extend ActiveSupport::Concern
	# Para que pueda incluir el after en cada modelo
	included do
		after_save :guardar_imagen
	end

	# Asi soluciono por ahora el incoveniente de las imagenes con el mismo nombre
	# debido a los Id
	if self.respond_to?(:nombre)
		PATH_ARCHIVOS = File.join Rails.root, "public", "archivos", "attachments"
	else
		PATH_ARCHIVOS = File.join Rails.root, "public", "archivos", "posts"
	end
	
	# Esto es: /home/josera/Documents/Rails-Projects/curso-backend y le agrego public/archivos

	def archivo=(archivo)
		unless archivo.blank?
			@archivo = archivo
			# Como el modelo Post no tiene un atributo nombre, por eso debemos verificar primero
			# Si esta el atributo
			if self.respond_to?(:nombre)
				self.nombre = archivo.original_filename # Guardamos el nombre del archivo
			end
			self.extension = archivo.original_filename.split(".").last.downcase # guardamos la extension
		end
	end

	def path_archivo
		File.join PATH_ARCHIVOS, "#{self.id}.#{self.extension}"
	end

	def tiene_archivo?
		File.exists? path_archivo
	end

	private
	def guardar_imagen
		if @archivo
			FileUtils.mkdir_p PATH_ARCHIVOS # creamos o abrimos el directorio
			File.open(path_archivo, "wb") do |f|
				f.write(@archivo.read)
			end
			@archivo = nil
		end
	end
end