class AgentsManager < Formula
  desc "Web UI for Claude Code, Codex, Grok and Antigravity CLI agents running in herdr"
  homepage "https://github.com/Eden-Sun/agents-manager"
  version "0.1.0"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/Eden-Sun/agents-manager/releases/download/v0.1.0/agents-managerd-v0.1.0-macos-arm64.tar.gz"
      sha256 "0fa402a0bcabf6958a8de89c1b764a1337c21885188889cc9ecd7d6737cb926e"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/Eden-Sun/agents-manager/releases/download/v0.1.0/agents-managerd-v0.1.0-linux-x86_64.tar.gz"
      sha256 "26eea65895c1a813d09e88f368ba206f7c47a6b9bdf4655572953842bcc3cbb2"
    end
    on_arm do
      url "https://github.com/Eden-Sun/agents-manager/releases/download/v0.1.0/agents-managerd-v0.1.0-linux-arm64.tar.gz"
      sha256 "0b981bf8259460edadd2935b8c9b3ed24fdcefd823f0c09561211db3fbed627f"
    end
  end

  depends_on "herdr"

  def install
    bin.install "agents-managerd"
  end

  service do
    run [opt_bin/"agents-managerd", "serve"]
    keep_alive true
    log_path var/"log/agents-manager.log"
    error_log_path var/"log/agents-manager.log"
  end

  def caveats
    <<~EOS
      Start the daemon:
        agents-managerd serve            # or: brew services start agents-manager
      Then open http://127.0.0.1:7788
      Config and data live in ~/.config/agents-manager/.
    EOS
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/agents-managerd --version")
  end
end
