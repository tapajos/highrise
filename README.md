# Highrise (3.0.0) [![Build Status](https://secure.travis-ci.org/tapajos/highrise.png)](http://travis-ci.org/tapajos/highrise)

## What is it?

This gem provides a set of classes to access information on [Highrise][h] via the published [API][api]:

    Account, Comment, Company, Deal, DealCategory, Email, Group, Case, Membership, Note, Party, Person, Recording, Subject, Tag, Task, TaskCategory and User.

All these classes are inherited from ActiveResouce::Base. Refer to the [ActiveResouce][ar] documentation for more information.

## Installing

    gem install highrise

### Dependencies (see <code>highrise.gemspec</code> or run <code>bundle check</code>)

### Documentation

  I'm on [rdoc.info][rdoc]

### Configure your key
    
    require 'highrise'
    
    Highrise::Base.site = 'https://your_site.highrisehq.com'
    Highrise::Base.user = 'api-auth-token'
    Highrise::Base.format = :xml

If you are using this in a Rails application, putting this code in a config/initializers/highrise.rb
file is recommended. See config_initializers_highrise.rb in the examples/ directory.

## Usage

    @tags = Highrise::Tag.find(:all)
    
    @people = Highrise::Person.find_all_across_pages(:params => {:tag_id => 12345})
    
    @person.tag!("VIP")

## License

This code is free to be used under the terms of the [MIT license][mit].

## Bugs, Issues, Kudos and Catcalls

Comments are welcome. Send your feedback through the [issue tracker on GitHub][i]

If you have fixes: Submit via pull requests. Do not include version changes to the 
version file. 

## Authors

* [Marcos Tapajós][tapajos]
* [Ken Mayer][kmayer]

## Contributors

* [Nicolas Bianco][slainer86]
* [Luis Gustavo][luisbebop]
* [Thiago Lelis][ThiagoLelis]
* [Denis Odorcic][odorcicd]



[api]: http://developer.37signals.com/highrise
[ar]: http://api.rubyonrails.org/classes/ActiveResource/Base.html
[c]:  http://api.rubyonrails.org/classes/ActiveSupport/Cache
[h]:  http://www.highrisehq.com/
[i]:  https://github.com/tapajos/highrise/issues
[kmayer]: https://github.com/kmayer
[luisbebop]: https://github.com/luisbebop
[mit]:http://www.opensource.org/licenses/mit-license.php
[slainer86]: https://github.com/slainer86
[odorcicd]: https://github.com/odorcicd
[rdoc]: http://rdoc.info/projects/tapajos/highrise
[tapajos]: http://www.improveit.com.br/en/company/tapajos
[ThiagoLelis]: https://github.com/ThiagoLelis
