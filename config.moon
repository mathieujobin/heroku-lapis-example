
import config from require "lapis.config"

database_url = os.getenv "DATABASE_URL"
print(database_url)
dbinfo = [x for x in string.gmatch(database_url, "([%u%l%d%-%.]+)")]

config "development", ->
  num_workers 1
  code_cache "off"
  port 8080
  postgresql_url database_url
  postgres ->
    host dbinfo[4]
    user dbinfo[2]
    password dbinfo[3]
    database dbinfo[6]

config "heroku", ->
  num_workers 8
  code_cache "on"
  port os.getenv "PORT"
  postgresql_url database_url
  postgres ->
    host dbinfo[4]
    user dbinfo[2]
    password dbinfo[3]
    database dbinfo[6]
