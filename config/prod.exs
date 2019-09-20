use Mix.Config

# For production, don't forget to configure the url host
# to something meaningful, Phoenix uses this information
# when generating URLs.
#
# Note we also include the path to a cache manifest
# containing the digested version of static files. This
# manifest is generated by the `mix phx.digest` task,
# which you should run after static files are built and
# before starting your production server.
config :camping, CampingWeb.Endpoint,
  url: [host: "camping-env.tamfv6m3tv.sa-east-1.elasticbeanstalk.com", port: 80],
  cache_static_manifest: "priv/static/cache_manifest.json"

config :logger, level: :info

# Configure your database
config :camping, Camping.Repo,
  username: "etori",
  password: "San240297",
  database: "camping_prod",
  hostname: "aa490tn3jlo0ow.c0kjdlsnhsft.sa-east-1.rds.amazonaws.com",
  pool_size: 20
