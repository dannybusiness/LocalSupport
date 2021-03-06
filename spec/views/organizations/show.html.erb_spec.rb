require 'spec_helper'

describe "organizations/show.html.erb" do

  let(:organization) do
    stub_model Organization, :name => 'Friendly', :address => "12 pinner rd", :telephone => "1234", :email => 'admin@friendly.org'
  end

  before(:each) do
    assign(:organization, organization)
    render
  end

  context 'page styling' do
    it 'organization name should be wrapped in h3 tag' do
      rendered.should have_css('h3', :text => organization.name)
    end

    it 'organization email should be a mailto hyperlink' do
      rendered.should have_css("a[href='mailto:#{organization.email}']")
    end
  end

  context "some information is private" do
    it "should not show telephone and address by default" do
      rendered.should_not have_content organization.address
      rendered.should_not have_content organization.telephone
    end
    
    it "should not show edit link by default" do
      rendered.should_not have_link 'Edit'
    end
  end

  context "has donation info url" do
    let(:organization) do
      stub_model Organization, :name => 'Friendly', :donation_info => 'http://www.friendly-charity.co.uk/donate'
    end

    it "renders donation info" do
      rendered.should have_selector 'a', :content => "Donate to #{organization.name} now!", :href => organization.donation_info, :target => '_blank'
    end
  end

  context "has website url" do
    let(:organization) do
      stub_model Organization, :website => 'http://www.friendly-charity.co.uk/'
    end

    it "renders website link" do
      rendered.should have_selector 'a', :content => "#{organization.website}", :href => organization.website, :target => '_blank'
    end
  end

  context "has no website url" do
    let(:organization) do
      stub_model Organization, :website => ''
    end
    it "renders no donation link" do
      rendered.should_not have_link "", :href => ""
    end
    it "renders no website text message" do
      rendered.should have_content "We don't yet have a website link for them"
    end
  end

  context "has no donation info url" do
    let(:organization) do
      stub_model Organization, :name => 'Charity with no donation URL'
    end
    it "renders no donation link" do
      rendered.should_not have_link "Donate to #{organization.name} now!", :href => organization.donation_info
    end
    it "renders no donation text message" do
      rendered.should have_content "We don't yet have any donation link for them."
    end
  end

  context 'edit button' do
    let(:organization) do
      stub_model Organization, :id => 1
    end
    it 'renders edit button if editable true' do
      @editable = assign(:editable, true)
      render
      rendered.should have_link "Edit", :href => edit_organization_path(organization.id)
    end
    it 'does not render edit button if editable false' do
      @editable = assign(:editable, false)
      render
      rendered.should_not have_link :href => edit_organization_path(organization.id)
    end
    it 'does not render edit button if editable nil' do
      @editable = assign(:editable, nil)
      render
      rendered.should_not have_link :href => edit_organization_path(organization.id)
    end
  end

  context 'this is my organization button' do
    let(:organization) do
      stub_model Organization, :id => 1
    end
    let(:user) do
      stub_model User, :id => 2
    end
    it 'renders grab button if grabbable true' do
      @grabbable = assign(:grabbable, true)
      view.stub(:current_user).and_return(user)
      render
      rendered.should have_link 'This is my organization', :href => organization_user_path(organization.id, user.id)
      #TODO should check hidden value for put
    end
    it 'does not render grab button if grabbable false' do
      @grabbable = assign(:grabbable, false)
      render
      rendered.should_not have_button("This is my organization")
    end
  end
end
