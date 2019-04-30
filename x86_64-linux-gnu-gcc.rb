require 'formula'

class X8664LinuxGnuGcc < Formula
  homepage 'http://gcc.gnu.org'
  url "http://mirror.tochlab.net/pub/gnu/gcc/gcc-8.3.0/gcc-8.3.0.tar.xz"
  mirror "https://ftp.gnu.org/gnu/gcc/gcc-8.3.0/gcc-8.3.0.tar.xz"
  sha256 "64baadfe6cc0f4947a84cb12d7f0dfaf45bb58b7e92461639596c21e02d97d2c"

  depends_on "gmp"
  depends_on "libmpc"
  depends_on "mpfr"
  depends_on "isl"
  depends_on 'x86_64-linux-gnu-binutils'

  def install
    binutils = Formulary.factory 'x86_64-linux-gnu-binutils'

    ENV['CC'] = '/usr/local/opt/gcc@8/bin/gcc-8'
    ENV['CXX'] = '/usr/local/opt/gcc@8/bin/g++-8'
    ENV['CPP'] = '/usr/local/opt/gcc@8/bin/cpp-8'
    ENV['LD'] = '/usr/local/opt/gcc@8/bin/gcc-8'
    ENV['PATH'] += ":#{binutils.prefix/"bin"}"

    mkdir 'build' do
      system '../configure', '--disable-nls', '--target=x86_64-linux-gnu','--disable-werror',
                             "--prefix=#{prefix}",
                             "--enable-languages=c,c++,go",
                             "--without-headers",
                             "--with-gmp=#{Formula["gmp"].opt_prefix}",
                             "--with-mpfr=#{Formula["mpfr"].opt_prefix}",
                             "--with-mpc=#{Formula["libmpc"].opt_prefix}"
      system 'make all-gcc -j4'
      system 'make install-gcc'
      FileUtils.ln_sf binutils.prefix/"x86_64-linux-gnu", prefix/"x86_64-linux-gnu"
      system 'make all-target-libgcc'
      system 'make install-target-libgcc'
      FileUtils.rm_rf share/"man"/"man7"
    end
  end
end
