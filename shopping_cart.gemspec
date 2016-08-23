$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "shopping_cart/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "shopping_cart"
  s.version     = ShoppingCart::VERSION
  s.authors     = ["Igor"]
  s.email       = ["igor12306@mail.ru"]
  s.homepage    = "https://github.com/rockandruby/shopping_cart"
  s.summary     = "Shopping cart and checkout"
  s.description = "Adds shopping cart and checkout functionality to your shop. "
  s.license     = "MIT"

  s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.md"]


  s.add_dependency "rails", "~> 5.0.0"
  s.add_dependency 'haml'
  s.add_dependency 'bootstrap-sass', '~> 3.3.6'
  s.add_dependency 'devise'
  s.add_dependency 'cancancan', '~> 1.10'
  s.add_dependency 'aasm'
  s.add_dependency 'rails-i18n', '~> 5.0.0'
end
