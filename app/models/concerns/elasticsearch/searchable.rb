module Elasticsearch
  module Searchable
    extend ActiveSupport::Concern

    class Response
      attr_reader :records, :total_count, :es_result

      def initialize(records:, total_count:, es_result:)
        @records = records
        @total_count = total_count
        @es_result = es_result
      end
    end

    included do
      include Elasticsearch::Model
      include Elasticsearch::Model::Callbacks

      __elasticsearch__.client = Elasticsearch::Client.new(
        log: Rails.env.development?,
        url: ENV.fetch('ELASTIC_SEARCH_URL')
      )

      def self.search(query)
        search = __elasticsearch__.search(query)
        total_count = search.total_count

        data_set = search.records

        Response.new(records: data_set, total_count: total_count, es_result: search)
      end
    end
  end
end
