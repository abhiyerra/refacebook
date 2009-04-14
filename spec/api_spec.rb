$:.push('lib/')

require 'rubygems'
require 'json'
require "refacebook"

describe ReFacebook::API do
  before(:each) do
    @api = ReFacebook::API.new('2a7a86cd4ea39bb7ea4eaabb938acb86', '662361041ddcb4b3f7df0f4b092249ee')

    violated "api was not created" unless @api
  end

  it "does a sample call without parameter" do
    begin
      token = @api.auth_createToken
      token.class.should == String
    rescue ReFacebook::APIError => e
      violated "failed with #{e.error_code}: #{e.error_msg}"
    end
  end

  it "does a sample call with parameter" do
    begin
      app_properties = @api.admin_getAppProperties :properties => ['application_name','callback_url']
      app_properties = JSON.parse(app_properties)
      app_properties['application_name'].should == 'traytwo'
    rescue ReFacebook::APIError => e
      violated "failed with #{e.error_code}: #{e.error_msg}"
    end
  end

  it "does a call with an incorrect api key" do
    # Bad secret key
    @api = ReFacebook::API.new('2a7a86cd4ea39bb7ea4eaabb938acb8', '662361041ddcb4b3f7df0f4b092249ee')
    begin
      token = @api.auth_createToken
      violated "api did not throw error"
    rescue ReFacebook::APIError => e
      e.error_code.should == 101
    end
  end

  it "does a call with an incorrect secret key" do
    # Bad secret key
    @api = ReFacebook::API.new('2a7a86cd4ea39bb7ea4eaabb938acb86', '662361041ddcb4b3f7df0f4b092249e')
    begin
      token = @api.auth_createToken
      violated "api did not throw error"
    rescue ReFacebook::APIError => e
      e.error_code.should == 104
    end
  end

  it "does a batch.run" do
    ret = @api.batch do |b|
      b.auth_createToken
      b.admin_getAppProperties :properties => ['application_name','callback_url']
    end

    ret.length.should == 2

    # TODO: Error in JSON.parse. Right now just check that application_name is availiable
    app_properties = ret[1]
    app_properties['application_name'].should == 'application_name'
    app_properties['traytwo'].should == 'traytwo'
  end 
end
