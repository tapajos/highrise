module Highrise
  module Pagination
    def self.included(base)
      base.extend(ClassMethods)
    end

    module ClassMethods
      def find_all_across_pages(options = {})
        records = []
        each(options) { |record| records << record }
        records
      end

      # This only is usefull for company, person & recordings, but should be safely ignored by other classes
      def find_all_across_pages_since(time)
        find_all_across_pages(:params => { :since => time.utc.strftime("%Y%m%d%H%M%S") })
      end

      private
      
      def each(options = {})
        options[:params] ||= {}
        options[:params][:n] = 0

        loop do
          if (records = self.find(:all, options)).try(:any?)
            records.each { |record| yield record }
            options[:params][:n] += records.size
          else
            break # no people included on that page, thus no more people total
          end
        end
      end
    end
  end
end