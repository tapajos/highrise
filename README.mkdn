# Highrise

## What

Highrise is a gem that provides an easy way to use the Highrise API.

## Installing

    gem install tapajos-highrise

## Dependencies

* ActiveResorce

## Configure your key.
    
    require 'rubygens'
    require 'highrise'
    Highrise::Base.site = "http://your_api:login@your_site.highrisehq.com/"
    
## Usage

This gem provides a set of classes to access all available informations on Highrise. 

These are the list of classes:

    Comment, Company, Email, Group, Note, Membership, Person, Subject, Task and User. 

All these classes are inherited of ActiveResouce::Base. For more informations see the ActiveResouce documentation.

## License

This code is free to be used under the terms of the [MIT license][mit].

## Contact

Comments are welcome. Send your feedback through [this page][co]

## Authors

[Marcos Tapajós][mt]  

## Shameless advertisement

This plugin is brought to you by [Improve It][ii].

[![Improve It][logo]][ii]

[logo]: 	http://www.improveit.com.br/images/logo/logo_improve_it_screen.gif "Improve It"

[mt]:		http://www.improveit.com.br/en/company/tapajos
[ii]:		http://www.improveit.com.br/en
[co]:		http://www.improveit.com.br/en/contact
[mit]:	http://www.opensource.org/licenses/mit-license.php
