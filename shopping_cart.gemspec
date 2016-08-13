$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "shopping_cart/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "shopping_cart"
  s.version     = ShoppingCart::VERSION
  s.authors     = ["Igor"]
  s.email       = ["example@example.com"]
  s.homepage    = "https://github.com/rockandruby/shopping_cart"
  s.summary     = "Summary of ShoppingCart."
  s.description = "Description of ShoppingCart."
  s.license     = "MIT"

  s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.md"]


  s.add_dependency "rails", "~> 5.0.0"
  s.add_dependency 'haml'
  s.add_dependency 'bootstrap-sass', '~> 3.3.6'
  s.add_dependency 'devise'
  s.add_dependency 'cancancan', '~> 1.10'
end
