require 'remote-sass'
require 'ostruct'

describe RemoteSass do
  it "can define a server location" do
    RemoteSass.location = "http://example.com"
    RemoteSass.location.should == "http://example.com"
  end
end

describe "Sass Importer" do
  before do
    @importer = Sass::Importers::HTTP.new "http://example.com"
  end

  it "can return a unique key for Sass caching purposes" do
    # http://sass-lang.com/docs/yardoc/Sass/Importers/Base.html#key-instance_method

    @importer.key("http://example.com", {}).should == ["Sass::Importers::HTTP", "http://example.com"]
  end

  it "can make a remote connection for absolute urls" do
    uri = URI.parse "http://example.com/style.scss"
    http = mock :http
    options = { importer: @importer, filename: uri.to_s, syntax: :scss }
    response = OpenStruct.new :body => "scss code"

    Net::HTTP.should_receive(:start).with(uri.host, uri.port, :use_ssl => false).and_yield http
    http.should_receive(:get).and_return response
    Sass::Engine.should_receive(:new).with response.body, options

    @importer.send :_find, uri, {}
  end

  it "can make a remote connection for absolute https urls" do
    Net::HTTP.should_receive :start

    @importer.send :_find, URI.parse("https://example.com/style.scss"), {}
  end

  it "should raise any error when connecting with other protocols" do
    lambda {
      @importer.send :_find, URI.parse("ftp://example.com/style.scss"), {}
    }.should raise_error(ArgumentError)
  end

  it "should raise any error unless given an absolute url" do
    lambda {
      @importer.send :_find, URI.parse("www.example.com/style.scss"), {}
    }.should raise_error(ArgumentError)
  end

  it "can figure out the correct syntax for a given url" do
    @importer.send(:get_syntax, URI.parse("http://example.com/css/style.scss")).should == :scss
    @importer.send(:get_syntax, URI.parse("http://example.com/css/style.sass")).should == :sass
  end

  it "can figure the correct syntax for a given url even if the extension is left off" do
    @importer.should_receive(:exists?).and_return true
    @importer.send(:get_syntax, URI.parse("http://example.com/css/style")).should == :sass
  end
end