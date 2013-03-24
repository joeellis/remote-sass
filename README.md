# Remote::Sass

RemoteSass is a small gem that allows Sass to import remote sass/scss stylsheets over HTTP/S.  With this, you can set up a central server to serve your stylesheet assets and share css among your many applications.

## Installation

Add this line to your application's Gemfile:

    gem 'remote-sass'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install remote-sass

## Usage

You'll need a couple of things for this to work:

1. You need a remote server capable of serving sass/scss assets
2. You need to tell RemoteSass where that server is located (preferably somewhere in an initializer file before your app starts up), ex:

    RemoteSass.location = "http://remote-server.com/path/to/assets/"

From this, RemoteSass will add your remote server as the last part of Sass's lookup path.  When importing, Sass will initially look for the file at the filesystem level first; if it finds the file, no extra connection is made.  If it fails to find a matching file, it will try to make a remote connnection to your defined server to find the file.

Example:

    @import "css/colors";

Sass will first try locally find a sass/scss file at "css/colors". Failing this, it will look to RemoteSass to connect and import from http://remote-server.com/css/colors".  Be aware of this look up order in case Sass doesn't seem to be loading the file you want.

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
