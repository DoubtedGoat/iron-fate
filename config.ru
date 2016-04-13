require './src/fe_tool.rb'
require 'sass/plugin/rack'

use Sass::Plugin::Rack

run FEService