if Rails.env != 'test' then
  Highrise::Base.site = 'https://example.com.i'
  Highrise::Base.user = 'my_fancy_auth_token'
end