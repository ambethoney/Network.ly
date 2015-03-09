require 'uri'
require 'httparty'
require 'redis'

require 'sinatra/base'
require 'sinatra/reloader'

require_relative 'linkedin_helper'
require_relative 'github_helper'
require_relative 'dribbble_helper'
require_relative 'server'


run ProjectDashboard::Server



