class Mangabinder < Formula
  desc "Download manga chapters, convert them to PDF, bind volumes and export CBZ"
  homepage "https://github.com/Preygle/manga-downloader"
  url "https://github.com/Preygle/manga-downloader/releases/download/v0.1.1/mangabinder-0.1.1.tar.gz"
  sha256 "c470e3a4fb1c6204cfb9c971b825835cc8695c00307f08030b68fd282216f348"
  license "MIT"

  depends_on "python@3.13"

  def install
    # A private virtualenv; Pillow and pypdfium2 come as prebuilt wheels from PyPI
    system Formula["python@3.13"].opt_bin/"python3.13", "-m", "venv", libexec
    system libexec/"bin/python", "-m", "pip", "install", "--no-cache-dir", buildpath
    bin.install_symlink libexec/"bin/mangabinder"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/mangabinder --version")
    system libexec/"bin/python", "-c", "import mangabinder.web, mangabinder.cbz, mangabinder.volumes"
  end
end
