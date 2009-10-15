#
# Example of extending a class when you need to synthesize an attribute.
#
# Adds Highrise::Person.{phone,fax,email} to the Person class inside your
# module
#

module MyModule
  include Highrise
  
  Highrise::Person.class_eval do
    class << self
      def lookup(id, list, item, location)
        module_eval <<-EOT
          def #{id}
            contact_data.#{list}.each do |i|
              return i.#{item}.strip if i.location == "#{location}"
            end
            ''
          end
        EOT
      end
    
      private :lookup
    end
  
    lookup(:phone, 'phone_numbers',   'number',  'Work')
    lookup(:fax,   'phone_numbers',   'number',  'Fax')
    lookup(:email, 'email_addresses', 'address', 'Work')
  end
end