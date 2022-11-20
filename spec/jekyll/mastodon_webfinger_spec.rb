# frozen_string_literal: true

RSpec.describe Jekyll::MastodonWebfinger do
  it "has a version number" do
    expect(Jekyll::MastodonWebfinger::VERSION).not_to be nil
  end

  describe "hooks" do
    it "adds '.well-known/webfinger' to the keep_files config" do
      site = make_site
      expect(site.config["keep_files"]).to include(".well-known/webfinger")
    end
  end
end
