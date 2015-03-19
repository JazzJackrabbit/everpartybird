# Framework
require 'cuba'
require "cuba/render"

# Custom classes & constants applied in server/cuba.rb
require_relative 'mime_type'
require_relative 'constants'

# Fancy HTML, CSS & JS
#require 'sass'
#require 'coffee-script'
require 'slim'

# ----
# App specific stuff
require_relative 'miscellaneous'
require_relative 'everbird_paint'
