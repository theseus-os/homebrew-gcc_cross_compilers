require 'formula'

class ArmElfBinutils < Formula
  homepage 'http://gcc.gnu.org'
  url 'http://ftp.gnu.org/gnu/binutils/binutils-2.27.tar.gz'
  sha256 '26253bf0f360ceeba1d9ab6965c57c6a48a01a8343382130d1ed47c468a3094f'

  depends_on 'gcc@8' => :build
  def install
    ENV['CC'] = '/usr/local/opt/gcc@8/bin/gcc-8'
    ENV['CXX'] = '/usr/local/opt/gcc@8/bin/g++-8'
    ENV['CPP'] = '/usr/local/opt/gcc@8/bin/cpp-8'
    ENV['LD'] = '/usr/local/opt/gcc@8/bin/gcc-8'

    mkdir 'build' do
      system '../configure', '--disable-nls', '--target=x86_64-elf','--disable-werror',
                             '--enable-gold=yes',
                             "--prefix=#{prefix}"
      system 'make all'
      system 'make install'
    end
  end
end
