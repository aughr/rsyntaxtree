# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_rsyntaxtree_session',
  :secret      => '9c833889f7bd338b77be146a2388c3694fa8bac631f5c27dbf72842a8bd21fd3f0e8ad9f478f2da05fc981e81154b5a1a359a706aa7d298c1dd9e9fcbe244288'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
