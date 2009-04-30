module Highrise
  module VERSION #:nodoc:
    version = YAML::load_file(File.expand_path(File.dirname(__FILE__)+"/../../VERSION.yml"))
    MAJOR = version[:major]
    MINOR = version[:minor]
    TINY  = version[:patch]

    STRING = [MAJOR, MINOR, TINY].join('.')
  end
end
