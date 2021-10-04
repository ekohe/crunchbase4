# frozen_string_literal: true

require 'httparty'

module Crunchbase
  # Zip file downloads endpoints
  module Downloads
    # using Crunchbase's downloads API endpoints
    class Client
      include HTTParty
      # Will spit out all request details to the console
      debug_output $stdout

      def download_bulk(dir, extract: false)
        FileUtils.mkdir_p(dir) unless Dir.exist?(dir)
        dist_path = Pathname.new(dir).join File.basename(bulk_url)

        download(bulk_url, dist_path) unless File.exist?(dist_path)
        system "tar xfz #{dist_path} -C #{dir}" if extract

        dist_path
      end

      private

      def bulk_url
        Crunchbase.config.bulk_url || [API_DOMAIN, "/bulk/#{API_VERSION}/bulk_export.tar.gz"].join
      end

      def download(url, dist_path)
        File.open(dist_path, 'w') do |file|
          file.binmode
          request(url, stream_body: true) do |buffer|
            file.write(buffer)
          end
        end
      end

      def request(url, options = {}, &block)
        default_options = { query: { user_key: Crunchbase.config.user_key } }
        options.merge!(default_options)

        response = self.class.get(url, options, &block)
        response.content_type.match?(/json/) ? JSON.parse(response.body) : response
      end
    end
  end
end
