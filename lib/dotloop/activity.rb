# frozen_string_literal: true

module Dotloop
  class Activity
    include Dotloop::QueryParamHelpers
    attr_accessor :client

    BATCH_SIZE = 50

    def initialize(client:)
      @client = client
    end

    def all(options = {})
      options[:batch_size] ||= BATCH_SIZE
      Array.new.tap do |arr|
        (1..MAX_LOOPS).each do |i|
          options[:batch_number] = i
          current_batch = batch(options)
          arr.push current_batch
          break if current_batch.size < options[:batch_size]
        end
      end.flatten
    end

    def batch(options = {})
      @client.get("/profile/#{profile_id(options)}/loop/#{loop_id(options)}/activity", query_params(options))[:data].map do |attrs|
        activity = Dotloop::Models::Activity.new(attrs)
        activity.client = client
        activity.profile_id = profile_id(options)
        activity.loop_id = loop_id(options)
        activity
      end
    end

    private

    def query_params(options)
      {
        batch_number:        batch_number(options),
        batch_size:          batch_size(options),
      }.delete_if { |_, v| should_delete(v) }
    end
  end
end
