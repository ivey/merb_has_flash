require File.dirname(__FILE__) + '/../spec_helper'
require 'merb_has_flash/flash_hash'

describe "merb_has_flash FlashHash" do
  before(:each) do
    @hash = MerbHasFlash::FlashHash.new
  end

  it "should not be a kind of Hash" do
    # Merb 0.9.6 now transmutes all Hashes in sessions into Mashes.. destroying the functionality.
    @hash.should_not be_a_kind_of(Hash)
  end

  it "should keep appropriate variables on sweep" do
    @hash[:a] = true
    @hash[:b] = false
    @hash[:c] = 90928

    @hash.sweep

    @hash[:a].should eql(true)
    @hash[:b].should eql(false)
    @hash[:c].should eql(90928)
  end

  it "should not keep variables when using now" do
    @hash.now[:a] = true
    @hash[:b] = true
    @hash.instance_variable_get(:@keepers).should_not include(:a)
  end

  it "should discard appropriate variables on sweep" do
    @hash.now[:a] = true
    @hash[:b] = false
    @hash[:c] = 90928
    @hash.discard(:c)
    @hash[:d] = 'Sir, the smurfs are eating your lunch...'

    @hash.sweep

    @hash[:a].should be_nil
    @hash[:b].should eql(false)
    @hash[:c].should be_nil
    @hash[:d].should  eql('Sir, the smurfs are eating your lunch...')
  end

end