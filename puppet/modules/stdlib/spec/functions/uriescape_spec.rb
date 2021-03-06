#! /usr/bin/env ruby -S rspec
require 'spec_helper'

describe "the uriescape function" do
  let(:scope) { PuppetlabsSpec::PuppetInternals.scope }

  it "should exist" do
    expect(Puppet::Parser::Functions.function("uriescape")).to eq("function_uriescape")
  end

  it "should raise a ParseError if there is less than 1 arguments" do
    expect { scope.function_uriescape([]) }.to( raise_error(Puppet::ParseError))
  end

  it "should uriescape a string" do
    result = scope.function_uriescape([":/?#[]@!$&'()*+,;= \"{}"])
    expect(result).to(eq(':/?%23[]@!$&\'()*+,;=%20%22%7B%7D'))
  end

  it "should do nothing if a string is already safe" do
    result = scope.function_uriescape(["ABCdef"])
    expect(result).to(eq('ABCdef'))
  end
end
