if Rails.env != 'test' then
  Highrise::Base.site = 'https://example.com.i'
  # For backward compatability
  if Highrise::Base.respond_to? :user
    Highrise::Base.user = 'my_fancy_auth_token'
  else 
    Highrise::Base.site = 'https://my_fancy_auth_token@example.com.i'
  end
  # The cache store can be anything that ActiveSupport can handle
  Highrise::Base.cache_store = ActiveSupport::Cache.lookup_store :mem_cache_store
  Highrise::Base.store_options = { :expires_in => 60.seconds }
end