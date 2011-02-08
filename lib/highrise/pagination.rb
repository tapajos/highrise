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

      # This is useful only for Company, Person, Note, Comment, Email and Task, but should be safely ignored by other classes
      def find_all_deletions_across_pages(options = {})
        # point to the global deletions feed
        options[:from] = '/deletions.xml'

        records = []
        each_deletions(options) { |record| records << record }
        records
      end

      # This is useful only for Company, Person, Note, Comment, Email and Task, but should be safely ignored by other classes
      def find_all_deletions_across_pages_since(time)
        find_all_deletions_across_pages(:params => { :since => time.utc.strftime("%Y%m%d%H%M%S") })
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

      def each_deletions(options = {})
        options[:params] ||= {}
        # first index for deletions is 1
        options[:params][:n] = 1

        loop do
          if (records = self.find(:all, options)).try(:any?)
            # reject the records whose resource type is different from self
            records.reject!{|r| r.type != self.to_s.split('::').last}

            records.each{ |record| yield record }

            # increment index interval for deletions is 1 per page of 500 resources
            options[:params][:n] += 1
          else
            break # no deletions included on that page, thus no more deletions
          end
        end
      end

    end
  end
end
