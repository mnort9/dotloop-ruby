# frozen_string_literal: true

require 'spec_helper'

describe Dotloop::Authenticate do
  let(:app_id) { 'abc' }
  let(:app_secret) { 'secret' }
  let(:application) { 'blah' }
  subject(:dotloop_auth) { Dotloop::Authenticate.new(app_id: app_id, app_secret: app_secret, application: application) }

  describe '#initialize' do
    it 'take an app id' do
      expect(dotloop_auth).to be_a(Dotloop::Authenticate)
      expect(dotloop_auth.app_id).to eq('abc')
    end

    context 'without application' do
      subject(:dotloop_auth) { Dotloop::Authenticate.new(app_id: app_id, app_secret: app_secret) }

      it 'default the application name to dotloop' do
        expect(dotloop_auth.application).to eq('dotloop')
      end
    end

    it 'take an application name' do
      expect(dotloop_auth.application).to eq('blah')
    end

    it 'take an app secret' do
      expect(dotloop_auth.app_secret).to eq('secret')
    end

    context 'without an app id' do
      let(:app_id) { nil }
      it 'raise the error' do
        expect { dotloop_auth }.to raise_error RuntimeError
      end
    end

    context 'without an app secret' do
      let(:app_secret) { nil }
      it 'raise the error' do
        expect { dotloop_auth }.to raise_error RuntimeError
      end
    end
  end
end
