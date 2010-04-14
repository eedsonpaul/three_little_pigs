# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_three_little_pigs_session',
  :secret      => '6e7d42deeec5c7b3a8b2a7fe8ef602f949c20158b3edf72340a51616adbc6a35d20b4f8d2e89221df0820d0b05671ef1add8c5fd296bb204bf4d92d20f441cdb'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
