# frozen_string_literal: true

RSpec.describe Jekyll::MastodonWebfinger::Generator do
  describe "without a mastodon config setting" do
    let(:site) { make_site }

    before { site.process }
    after { FileUtils.rm_r(dest_dir) }

    it "does nothing" do
      generator = described_class.new
      generator.generate(site)
      expect(Dir.exist?(dest_dir(".well-known"))).to be(false)
    end
  end

  describe "with a mastodon username but no instance" do
    let(:site) { make_site("mastodon" => { "username" => "philnash" }) }

    before { site.process }
    after { FileUtils.rm_r(dest_dir) }

    it "does nothing" do
      generator = described_class.new
      generator.generate(site)
      expect(Dir.exist?(dest_dir(".well-known"))).to be(false)
    end
  end

  describe "with a mastodon instance but no username" do
    let(:site) { make_site("mastodon" => { "instance" => "mastodon.social" }) }

    before { site.process }
    after { FileUtils.rm_r(dest_dir) }

    it "does nothing" do
      generator = described_class.new
      generator.generate(site)
      expect(Dir.exist?(dest_dir(".well-known"))).to be(false)
    end
  end

  describe "with a mastodon username and instance" do
    let(:username) { "philnash" }
    let(:instance) { "mastodon.social" }
    let(:generator) { described_class.new }
    let(:webfinger_file) { dest_dir(".well-known", "webfinger") }

    before do
      site = make_site("mastodon" => { "username" => username, "instance" => instance })
      site.process
      generator.generate(site)
    end

    after { FileUtils.rm_r(dest_dir) }

    it "generates a .well-known directory" do
      expect(Dir.exist?(dest_dir(".well-known"))).to be(true)
    end

    it "generates a webfinger file" do
      expect(File.exist?(webfinger_file)).to be(true)
    end

    describe "the webfinger file" do
      let(:webfinger) do
        file = File.open(webfinger_file)
        contents = file.read
        file.close
        JSON.parse(contents)
      end

      it "has a subject" do
        expect(webfinger["subject"]).to eq("acct:#{username}@#{instance}")
      end

      it "has two aliases" do
        expect(webfinger["aliases"]).to include("https://#{instance}/@#{username}", "https://#{instance}/users/#{username}")
      end

      it "has a link for a profile page" do
        expect(webfinger["links"]).to include(
          "rel" => "http://webfinger.net/rel/profile-page",
          "type" => "text/html",
          "href" => "https://#{instance}/@#{username}"
        )
      end

      it "has a link for the JSON activity feed" do
        expect(webfinger["links"]).to include(
          "rel" => "self",
          "type" => "application/activity+json",
          "href" => "https://#{instance}/users/#{username}"
        )
      end

      it "has a link for ostatus" do
        expect(webfinger["links"]).to include(
          "rel" => "http://ostatus.org/schema/1.0/subscribe",
          "template" => "https://#{instance}/authorize_interaction?uri={uri}"
        )
      end
    end
  end
end
