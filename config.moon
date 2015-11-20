
import config from require "lapis.config"

config "heroku", ->
  num_workers 8
  code_cache "on"
  port os.getenv "PORT"
  postgresql_url os.getenv "DATABASE_URL"
