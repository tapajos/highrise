require 'highrise'
require 'pp'

Highrise::Base.site = 'https://yoursite.highrisehq.com'
Highrise::Base.user = 'xxx'
Highrise::Base.connection.cache_store = :memory_store

@tags = Highrise::Tag.find(:all)

pp @tags