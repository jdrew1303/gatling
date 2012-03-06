module Gatling
  class FileHelper

    def make_required_directories
      Gatling::Configuration.paths.each { | key, directory | make_dir directory  }
    end

    def save_image(image, image_name, type)
      path = File.join(path_from_type(type), "#{image_name}")
      image.write path 
      path
    end

    def save_gatling_image(image)
      path = File.join(image.type, "#{image.name}.png")
      image.rmagic_image.write path 
    end

    def exists?(file, type)
      File.exists?(File.join(path_from_type(type), file))
    end

    def load(file, type)
      if exists?(file, type)
        return Magick::Image.read(File.join(path_from_type(type), file)).first
      end
      return false
    end

    private

    def make_dir(path)
      FileUtils::mkdir_p(File.join(path))
    end
    
    def path_from_type(type)
      if Gatling::Configuration.paths.keys.include? type
        return Gatling::Configuration.paths[type]
      else
        raise "Unkown image type '#{type}'"
      end
    end 

  end
end