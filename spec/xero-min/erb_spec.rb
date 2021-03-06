# -*- encoding: utf-8 -*-
require 'spec_helper'
require 'xero-min/erb'

describe XeroMin::Erb do
  let(:erb) {XeroMin::Erb.new}
  describe "#template_dir" do
    it "is default ./templates from source file" do
      erb.template_dir.should =~ %r(xero-min/templates$)
    end
  end

  describe "#infered_template" do
    [:contact, :invoice].each do |sym|
      it "is #{sym}.xml.erb for #{sym}" do
        erb.infered_template(sym).should == "#{sym}.xml.erb"
      end
    end
  end

  describe "#render" do
    let(:contact) {{name: 'Héloise Dupont', first_name: 'Héloise', last_name: 'Dupont', email: 'heloise@dupont.com'}}
    it "should be nice" do
      erb.render(contact: contact).should =~ %r(<Name>Héloise Dupont</Name>)
    end
    it "post processes erb output with #post_process_proc, that compacts xml" do
      erb.render(contact: contact).should =~ %r(^<Contact><ContactNumber>)
    end
  end
end