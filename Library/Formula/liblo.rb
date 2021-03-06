require 'formula'

class Liblo < Formula
  homepage 'http://liblo.sourceforge.net/'
  url 'https://downloads.sourceforge.net/project/liblo/liblo/0.28/liblo-0.28.tar.gz'
  sha1 '949d5f0c9919741c67602514786b9c7366fa001b'

  bottle do
    cellar :any
    revision 1
    sha1 "4e54400bfd62515b26619c7ed1e281c747467ed5" => :yosemite
    sha1 "c05b222b88ebf22eedb74a41c5a22a6af867d82c" => :mavericks
    sha1 "1245b84f62785f894cdb77aae345fbc9b4c3d974" => :mountain_lion
  end

  head do
    url 'git://liblo.git.sourceforge.net/gitroot/liblo/liblo'

    depends_on 'autoconf' => :build
    depends_on 'automake' => :build
    depends_on 'libtool' => :build
  end

  option "enable-ipv6", "Compile with support for ipv6"
  option :universal

  def install
    ENV.universal_binary if build.universal?

    args = %W[--disable-debug
              --disable-dependency-tracking
              --prefix=#{prefix}]

    args << "--enable-ipv6" if build.include? "enable-ipv6"

    if build.head?
      system "./autogen.sh", *args
    else
      system "./configure", *args
    end

    system "make install"
  end
end
