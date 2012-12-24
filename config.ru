require "bundler"
Bundler.require :default

base = File.dirname(__FILE__)
$:.unshift File.join(base, "lib")

require "open_city"

Sinatra::Base.set(:root) { base }

if memcache_servers = ENV["MEMCACHE_SERVERS"]
  use Rack::Cache,
    verbose: true,
    metastore:   "memcached://#{memcache_servers}",
    entitystore: "memcached://#{memcache_servers}"
end

run OpenCity::Application