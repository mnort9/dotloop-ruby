# frozen_string_literal: true

module Dotloop
  module Models
    class Activity
      include Virtus.model
      attribute :message
      attribute :date, DateTime
    
      attr_accessor :client
      attr_accessor :profile_id
      attr_accessor :loop_id
    end
  end
end
