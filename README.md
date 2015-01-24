# Alfredpi

TODO: Write a gem description

## Installation

- RASPBIAN image
- IR on GPIO :
http://ozzmaker.com/2013/10/24/how-to-control-the-gpio-on-a-raspberry-pi-with-an-ir-remote/

- wifi
- Rbenv + gems and co :
```
git clone https://github.com/sstephenson/rbenv.git ~/.rbenv
echo 'export PATH="$HOME/.rbenv/bin:$PATH"' >> ~/.bashrc
echo 'eval "$(rbenv init -)"' >> ~/.bashrc
git clone https://github.com/sstephenson/ruby-build.git ~/.rbenv/plugins/ruby-build
```
restart terminal
```
rbenv install 2.1.5
rbenv global 2.1.5
gem install specific_install
gem specific_install https://github.com/ombr/alfredpi.git
```
- specific_install
Add this line to your application's Gemfile:

```ruby
gem 'alfredpi'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install alfredpi

## Usage

TODO: Write usage instructions here

## Contributing

1. Fork it ( https://github.com/[my-github-username]/alfredpi/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
