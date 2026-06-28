# frozen_string_literal: true

class CyrusSaslXoauth2 < Formula
  head do
    url 'https://github.com/simonvedl/cyrus-sasl-xoauth2.git', branch: 'master'
    depends_on 'libtool' => :build
    depends_on 'autoconf' => :build
    depends_on 'automake' => :build
  end

  depends_on 'cyrus-sasl'
  
  def install
    system('glibtoolize')
    File.open('./autogen.sh') do |f|
      f.drop(1).each { system(_1) }
    end

    system('./configure', "--with-cyrus-sasl=#{prefix}")
    system('make', 'install')
  end

  def caveats
    <<~EOS
      Before running mbsync set the following variable

      SASL_PATH=$(brew --prefix)/opt/cyrus-sasl/lib/sasl2:$(brew --prefix)/opt/cyrus-sasl-xoauth2/lib/sasl2
    EOS
  end
end
