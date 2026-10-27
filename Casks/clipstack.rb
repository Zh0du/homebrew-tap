cask "clipstack" do
  version "1.0.1"
  sha256 "b73fa3f3d9483436ae4e9a591e60da78e6d9cd21a0e0801660147380b3f9ca6e"

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
