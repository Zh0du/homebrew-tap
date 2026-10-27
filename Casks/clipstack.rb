cask "clipstack" do
  version "1.0.2"
  sha256 "7cf9949514eed0996ce341deba69e126d08977948e900d659a33fb8cf478c851"

  url "https://github.com/Zh0du/clipstack/releases/download/v#{version}/ClipStack.dmg"
  name "ClipStack"
  desc "Free, open-source clipboard manager with screenshot history"
  homepage "https://github.com/Zh0du/clipstack"

  livecheck do
    url :url
    strategy :github_latest
  end

  depends_on macos: ">= :ventura"

  app "ClipStack.app"

  # The app is ad-hoc signed (not notarized), so drop the quarantine flag
  # to let it open without the Gatekeeper "can't be opened" dialog.
  postflight do
    system_command "/usr/bin/xattr",
                   args: ["-dr", "com.apple.quarantine", "#{appdir}/ClipStack.app"]
  end

  uninstall quit: "com.clipstack.app"

  zap trash: [
    "~/Library/Application Support/ClipStack",
    "~/Library/Preferences/com.clipstack.app.plist",
  ]
end
