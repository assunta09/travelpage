require 'sinatra'
require 'active_record'
require 'pathname' #requires the ruby pathname library
require 'logger'


# Identify the root directory for the application
# so that we can later reference files from APP_ROOT
APP_ROOT = Pathname.new(File.expand_path('../', __FILE__))
# APP_ROOT = Pathname.new(File.expand_path(File.join(File.dirname(__FILE__), '..')))
APP_NAME = APP_ROOT.basename.to_s

DB_PATH = APP_ROOT.join('db', APP_NAME + ".db").to_s

if ENV['DEBUG']
  ActiveRecord::Base.logger = Logger.new(STDOUT)
end

Dir[APP_ROOT.join('app', 'models', '*.rb')].each do |model_file|
  filename = File.basename(model_file).gsub('.rb', '')
  autoload ActiveSupport::Inflector.camelize(filename), model_file
end

# Configure the database
database_config = { :adapter  =>  "sqlite3",
                    :database => DB_PATH}

ActiveRecord::Base.establish_connection(database_config)

require_relative 'controllers/traveling'
require_relative 'app/models/traveldata'
