require 'uri'
require 'httparty'


require 'sinatra/base'
require 'sinatra/reloader'

require_relative 'linkedin_helper'
require_relative 'server'


run ProjectDashboard::Server



