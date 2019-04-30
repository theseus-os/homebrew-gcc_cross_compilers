require 'formula'

class ArmElfGdb < Formula
  homepage 'http://gcc.gnu.org'
  url 'http://ftp.gnu.org/gnu/gdb/gdb-7.11.1.tar.xz'
  sha256 'e9216da4e3755e9f414c1aa0026b626251dfc57ffe572a266e98da4f6988fc70'

  depends_on 'arm-elf-binutils'
  depends_on 'arm-elf-gcc'

  def install
    ENV['CC'] = '/usr/local/opt/gcc@8/bin/gcc-8'
    ENV['CXX'] = '/usr/local/opt/gcc@8/bin/g++-8'
    ENV['CPP'] = '/usr/local/opt/gcc@8/bin/cpp-8'
    ENV['LD'] = '/usr/local/opt/gcc@8/bin/gcc-8'

    mkdir 'build' do
      system '../configure', '--target=arm-elf-eabi', "--prefix=#{prefix}" ,'--disable-werror'
      system 'make'
      system 'make install'
      FileUtils.rm_rf share/"locale"
    end
  end
end
