require "remote-sass/version"
require "remote-sass/importer"

module RemoteSass
  class << self
    def location
      @location
    end

    def location= location
      @location = location
      Sass.load_paths << Sass::Importers::HTTP.new(location)
    end
  end
end
