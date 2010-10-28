require 'highrise'
require 'pp'

Highrise::Base.site = 'https://yoursite.highrisehq.com'
Highrise::Base.user = 'xxx'

@tags = Highrise::Tag.find(:all)

pp @tags