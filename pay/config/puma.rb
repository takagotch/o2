threads_count = ENV.fetch() {}.to_i
threads threads_count, threads_count

port ENV.fetch("PORT") { 3000 }

environment ENV.fetch("RAILS_ENV") { "development" }

plugin :tmp_restart



