local config
config = require("lapis.config").config
return config("heroku", function()
  num_workers(8)
  code_cache("on")
  port(os.getenv("PORT"))
  return postgresql_url(os.getenv("DATABASE_URL"))
end)
