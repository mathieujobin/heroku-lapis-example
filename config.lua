local config
config = require("lapis.config").config
local database_url = os.getenv("DATABASE_URL")
local dbinfo
do
  local _accum_0 = { }
  local _len_0 = 1
  for x in string.gmatch(database_url, "([%u%l%d%-%.]+)") do
    _accum_0[_len_0] = x
    _len_0 = _len_0 + 1
  end
  dbinfo = _accum_0
end
config("development", function()
  num_workers(1)
  code_cache("off")
  port(8080)
  postgresql_url(database_url)
  return postgres(function()
    host(dbinfo[4])
    user(dbinfo[2])
    password(dbinfo[3])
    return database(dbinfo[6])
  end)
end)
return config("heroku", function()
  num_workers(8)
  code_cache("on")
  port(os.getenv("PORT"))
  postgresql_url(database_url)
  return postgres(function()
    host(dbinfo[4])
    user(dbinfo[2])
    password(dbinfo[3])
    return database(dbinfo[6])
  end)
end)
