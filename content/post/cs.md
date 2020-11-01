+++
showonlyimage = false
draft = false
image = "img/cs.png"
date = "2019-12-26"
title = "C# Installation"
writer = "Martin Strohmayer"
categories = ["GC2", "Raspberry Pi Zero", "Raspberry Pi"]
keywords = ["c#", "Sharp", "C", "mono", ".NET"]
weight = 1
+++

Um zur aktuellsten C# Mono Version zu kommen muss diese manuell installiert werden. Diese Anleitung zeigt wie und hilft einen Stolperstein für die Raspberry Pi Zero zu vermeiden. 
<!--more-->

## Beschreibung ##

Wer C# auf dem Raspberry Pi Zero programmieren bzw. verwenden möchte ist auf das [Mono Projekt](https://www.mono-project.com/) angewiesen. Es unterstützt sowohl den alten ARM11-Prozessor mit ARMv6 Architektur als auch die neuen ARMv7 kompatiblen Prozessoren. Ein einfacher Aufruf von "sudo apt-get install mono-complete" reicht eigentlich zur Installation aus. Dann erhält man aber eine etwas ältere Version. 

```
mono -V
```
```
Mono JIT compiler version 5.18.0.240 (Debian 5.18.0.240+dfsg-3 Sat Apr 20 05:16:08 UTC 2019)
Copyright (C) 2002-2014 Novell, Inc, Xamarin Inc and Contributors. www.mono-project.com
	TLS:           
	SIGSEGV:       normal
	Notifications: epoll
	Architecture:  armel,vfp+hard
	Disabled:      none
	Misc:          softdebug 
	Interpreter:   yes
	LLVM:          supported, not enabled.
	Suspend:       preemptive
	GC:            sgen (concurrent by default)
```
 
Möchte man die neuste Version installieren muss man manuell einige Schritte durchführen.


## Installation ##

```
sudo apt-get install apt-transport-https dirmngr gnupg ca-certificates
sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys 3FA7E0328081BFF6A14DA29AA6A19B38D3D831EF
echo "deb https://download.mono-project.com/repo/debian stable-raspbianbuster main" | sudo tee /etc/apt/sources.list.d/mono-official-stable.list
sudo apt-get update
sudo apt-get install mono-complete
```

```
mono -V
```

```
Mono JIT compiler version 6.4.0.198 (tarball Tue Sep 24 01:45:47 UTC 2019)
Copyright (C) 2002-2014 Novell, Inc, Xamarin Inc and Contributors. www.mono-project.com
	TLS:           __thread
	SIGSEGV:       normal
	Notifications: epoll
	Architecture:  armel,vfp+hard
	Disabled:      none
	Misc:          softdebug 
	Interpreter:   yes
	LLVM:          yes(610)
	Suspend:       preemptive
	GC:            sgen (concurrent by default)
```

## Raspberry Pi Zero ##

### Problembeschreibung ###

Untypisch bei der Installation des mono-complete Paketes ist, dass Bibliotheken am Zielsystem kompiliert werden. 
Auf den ersten Blick kann man das ja als verständlich erachten, bei näherer Betrachtung ergeben sich aber Probleme.  
Ja nach System auf dem installiert wird, werden binär unterschiedliche Bibliotheken erzeugt. Wird nun mono auf einer neueren Raspberry Pi (ab Version 2) erzeugt, so kann diese SD-Karte nicht mehr in einer Raspberry Pi Zero eingesetzt werden. Offensichtlich sind die erzeugen Bibliotheken nicht kompatibel mit der alten ARMv6 Architektur. Sobald das Programm "mono" bzw. "/usr/bin/mono-sgen" ausgeführt wird, kommt es zum Absturz.  
Durch den Aufruf von "dpkg-reconfigure" können die Bibliotheken am Zielsystem neu erzeugt werden. Dazu muss man aber jedes der problematischen Pakete kennen.
Mir ist es bisher nicht gelungen auf diese Art mono korrekt neu zu erzeugen! Die folgende unvollständige Liste der Pakte habe ich bisher ermittelt:

```
sudo dpkg-reconfigure libmono-corlib4.5-cil 
Mono precompiling /usr/lib/mono/4.5/mscorlib.dll for arm (LLVM disabled due to missing SSE4.1)...
```
```
sudo dpkg-reconfigure mono-mcs
Mono precompiling /usr/lib/mono/4.5/mcs.exe for arm (LLVM disabled due to missing SSE4.1)...
```
```
sudo dpkg-reconfigure mono-roslyn
Mono precompiling /usr/lib/mono/4.5/csc.exe for arm (LLVM disabled due to missing SSE4.1)...
Mono precompiling /usr/lib/mono/4.5/vbc.exe for arm (LLVM disabled due to missing SSE4.1)...
Mono precompiling /usr/lib/mono/4.5/VBCSCompiler.exe for arm (LLVM disabled due to missing SSE4.1)...
Mono precompiling /usr/lib/mono/4.5/Microsoft.CodeAnalysis.CSharp.dll for arm (LLVM disabled due to missing SSE4.1)...
Mono precompiling /usr/lib/mono/4.5/Microsoft.CodeAnalysis.VisualBasic.dll for arm (LLVM disabled due to missing SSE4.1)...
Mono precompiling /usr/lib/mono/4.5/Microsoft.CodeAnalysis.dll for arm (LLVM disabled due to missing SSE4.1)...
Mono precompiling /usr/lib/mono/4.5/System.Collections.Immutable.dll for arm (LLVM disabled due to missing SSE4.1)...
Mono precompiling /usr/lib/mono/4.5/System.Reflection.Metadata.dll for arm (LLVM disabled due to missing SSE4.1)...
```

Die besagten problematischen Bibliotheken befinden sich alle im Verzeichnis "/usr/lib/mono/aot-cache/arm". Mit dem Tool "md5sum" kann man einen Hash der binären Dateien errechnen und erkennt dann, dass auf unterschiedlichen Systemen andere Bibliotheken erzeugt wurden.  


**Raspberry Pi 3+:**
```
5a171770d300363e3ec2eb60a854c481  csc.exe.so
df8506376fdf137d863e3bba99716b07  mcs.exe.so
4015357bc969c8a9be7193d59555debc  Microsoft.CodeAnalysis.CSharp.dll.so
4c55c6475790d96c7a245df5afa22358  Microsoft.CodeAnalysis.dll.so
c3c739f4753d6fa2770be8704f6f61a6  Microsoft.CodeAnalysis.VisualBasic.dll.so
405641746541bb05ea82ac45f20f5696  mscorlib.dll.so
8a32754f92db9671bd3beacc0bc3689d  System.Collections.Immutable.dll.so
1a4ec59a04636afaa39112fef86e7229  System.Reflection.Metadata.dll.so
32fcdc11684481eb72f638b3dce0cf8e  vbc.exe.so
ce4d8efa2c3ddac3b42b8e8ffa6407f6  VBCSCompiler.exe.so
```

**Raspberry Pi Zero:**
```
85ad88c49857e8ca89ba4ae00e8c1fd3  csc.exe.so
3bef36c9fe11d7e99367cf9b23c32853  mcs.exe.so
322fdde542e899c12479c71f3d7b1dec  Microsoft.CodeAnalysis.CSharp.dll.so
28666816903d4a5d16312cf21320833e  Microsoft.CodeAnalysis.dll.so
d146515c05c29292c401789f0bb4fdf2  Microsoft.CodeAnalysis.VisualBasic.dll.so
b0f1c0f302c96d49ec699152445fa96d  mscorlib.dll.so
33bb1dcc310d5db62bcf4f06df475976  System.Collections.Immutable.dll.so
be3df82bb795a9224f916113f5bbeeab  System.Reflection.Metadata.dll.so
5dc11adaa95f1e942f1fb98ca4673b1f  vbc.exe.so
bd646f0b1c23b90cf0ea90f15231e439  VBCSCompiler.exe.so
```

Der genaue Grund warum die Bibliotheken am Raspberry Pi Zero nicht funktionieren ist mir nicht bekannt. Die Dateien werden möglicherweise mit dem Assembler "as" erzeugt. Hier wird der Optimierungsparameter "-mfpu=vfp3" verwendet. Als Beschreibung findet man "Enable the ARMv7 VFPv3 floating-point extension. Disable the Advanced SIMD extension". Dieser Optimierung sollte eigentlich auf dem ARM11 nicht funktionieren, ob dies aber zum Absturz führt, ist nicht bekannt.  
Aktualisierung 1.11.2020: Auch bei Update/Installation auf einem Raspberry Pi 1 wird beim Kompilieren der Parameter "-mfpu=vfp3" angewendet.

### Lösung (GC2 Raspjamming) ###

Das Problem trifft vor allem bei unserem Raspjamming Image auf, wenn das Image auf einem ARMv7 System erzeugt wird. Auf einem x86_64-System bei dem eine Emulation (qemu) Verwendung findet, tritt das Problem nicht auf.  
Als Lösung wird von uns nach der Installation von mono, die Library-Dateien überschrieben. Sie wurden einmalig von einem Raspberry Pi Zero System gesichert. 
Diese sind dann auch für neue Raspberry Pi Einplatinencomputer geeignet. 


<!--
Raspberry Pi Zero - working:
============================
file /usr/bin/mono-sgen
/usr/bin/mono-sgen: ELF 32-bit LSB executable, ARM, EABI5 version 1 (SYSV), dynamically linked, interpreter /lib/ld-linux-armhf.so.3, for GNU/Linux 3.2.0, BuildID[sha1]=c2ba638f985376a32d8c831482a3f498b45c344b, stripped
file /usr/lib/mono/4.5/mcs.exe
/usr/lib/mono/4.5/mcs.exe: PE32 executable (console) Intel 80386 Mono/.Net assembly, for MS Windows
md5sum /usr/lib/mono/4.5/mcs.exe 
bfc12cba4917ca5793bbb1c74aa59e24  /usr/lib/mono/4.5/mcs.exe
/usr/lib/mono/4.5/mscorlib.dll?

ldd /usr/bin/mono-sgen
	/usr/lib/arm-linux-gnueabihf/libarmmem-${PLATFORM}.so => /usr/lib/arm-linux-gnueabihf/libarmmem-v6l.so (0xb6ec7000)
	libz.so.1 => /lib/arm-linux-gnueabihf/libz.so.1 (0xb6e9c000)
	librt.so.1 => /lib/arm-linux-gnueabihf/librt.so.1 (0xb6e85000)
	libdl.so.2 => /lib/arm-linux-gnueabihf/libdl.so.2 (0xb6e72000)
	libpthread.so.0 => /lib/arm-linux-gnueabihf/libpthread.so.0 (0xb6e48000)
	libstdc++.so.6 => /lib/arm-linux-gnueabihf/libstdc++.so.6 (0xb6d01000)
	libm.so.6 => /lib/arm-linux-gnueabihf/libm.so.6 (0xb6c7f000)
	libgcc_s.so.1 => /lib/arm-linux-gnueabihf/libgcc_s.so.1 (0xb6c52000)
	libc.so.6 => /lib/arm-linux-gnueabihf/libc.so.6 (0xb6b04000)
	/lib/ld-linux-armhf.so.3 (0xb6eda000)

pi@raspberrypi:~ $ ls -l /usr/lib/arm-linux-gnueabihf/libarmmem*
lrwxrwxrwx 1 root root    16 Apr 30  2019 /usr/lib/arm-linux-gnueabihf/libarmmem-aarch64.so -> libarmmem-v7l.so
-rw-r--r-- 1 root root  9512 Apr 30  2019 /usr/lib/arm-linux-gnueabihf/libarmmem-v6l.so
-rw-r--r-- 1 root root 17708 Apr 30  2019 /usr/lib/arm-linux-gnueabihf/libarmmem-v7l.so
lrwxrwxrwx 1 root root    16 Apr 30  2019 /usr/lib/arm-linux-gnueabihf/libarmmem-v8l.so -> libarmmem-v7l.so

pi@raspberrypi:~ $ md5sum /usr/bin/mono-sgen
aa939291a2fc89daeec93f21e8877628  /usr/bin/mono-sgen

/usr/lib/mono/aot-cache/arm/mscorlib.dll.so: ELF 32-bit LSB pie executable, ARM, EABI5 version 1 (SYSV), dynamically linked, BuildID[sha1]=26f36ecfd75cc8c83d404a485d6c50e0adbffd35, with debug_info, not stripped
md5sum /usr/lib/mono/aot-cache/arm/mscorlib.dll.so
b0f1c0f302c96d49ec699152445fa96d  /usr/lib/mono/aot-cache/arm/mscorlib.dll.so


cd /usr/lib/mono/aot-cache/arm
md5sum *
85ad88c49857e8ca89ba4ae00e8c1fd3  csc.exe.so
3bef36c9fe11d7e99367cf9b23c32853  mcs.exe.so
322fdde542e899c12479c71f3d7b1dec  Microsoft.CodeAnalysis.CSharp.dll.so
28666816903d4a5d16312cf21320833e  Microsoft.CodeAnalysis.dll.so
d146515c05c29292c401789f0bb4fdf2  Microsoft.CodeAnalysis.VisualBasic.dll.so
b0f1c0f302c96d49ec699152445fa96d  mscorlib.dll.so
33bb1dcc310d5db62bcf4f06df475976  System.Collections.Immutable.dll.so
be3df82bb795a9224f916113f5bbeeab  System.Reflection.Metadata.dll.so
5dc11adaa95f1e942f1fb98ca4673b1f  vbc.exe.so
bd646f0b1c23b90cf0ea90f15231e439  VBCSCompiler.exe.so



Raspberry Pi Zero - not working:
================================
/usr/bin/mono-sgen: ELF 32-bit LSB executable, ARM, EABI5 version 1 (SYSV), dynamically linked, interpreter /lib/ld-linux-armhf.so.3, for GNU/Linux 3.2.0, BuildID[sha1]=c2ba638f985376a32d8c831482a3f498b45c344b, stripped

pi@raspberrypi:~ $ md5sum /usr/bin/mono-sgen
aa939291a2fc89daeec93f21e8877628  /usr/bin/mono-sgen

file /usr/lib/mono/aot-cache/arm/mscorlib.dll.so
/usr/lib/mono/aot-cache/arm/mscorlib.dll.so: ELF 32-bit LSB pie executable, ARM, EABI5 version 1 (SYSV), dynamically linked, BuildID[sha1]=e8160770d19945fdc8db0153a4e61517dd9a6acc, with debug_info, not stripped
md5sum /usr/lib/mono/aot-cache/arm/mscorlib.dll.so
405641746541bb05ea82ac45f20f5696  /usr/lib/mono/aot-cache/arm/mscorlib.dll.so

/usr/lib/mono/4.5/mcs.exe: PE32 executable (console) Intel 80386 Mono/.Net assembly, for MS Windows
bfc12cba4917ca5793bbb1c74aa59e24  /usr/lib/mono/4.5/mcs.exe

pi@raspberrypi:~ $ ldd /usr/bin/mono-sgen
	/usr/lib/arm-linux-gnueabihf/libarmmem-${PLATFORM}.so => /usr/lib/arm-linux-gnueabihf/libarmmem-v6l.so (0xb6fb4000)
	libz.so.1 => /lib/arm-linux-gnueabihf/libz.so.1 (0xb6f89000)
	librt.so.1 => /lib/arm-linux-gnueabihf/librt.so.1 (0xb6f72000)
	libdl.so.2 => /lib/arm-linux-gnueabihf/libdl.so.2 (0xb6f5f000)
	libpthread.so.0 => /lib/arm-linux-gnueabihf/libpthread.so.0 (0xb6f35000)
	libstdc++.so.6 => /lib/arm-linux-gnueabihf/libstdc++.so.6 (0xb6dee000)
	libm.so.6 => /lib/arm-linux-gnueabihf/libm.so.6 (0xb6d6c000)
	libgcc_s.so.1 => /lib/arm-linux-gnueabihf/libgcc_s.so.1 (0xb6d3f000)
	libc.so.6 => /lib/arm-linux-gnueabihf/libc.so.6 (0xb6bf1000)
	/lib/ld-linux-armhf.so.3 (0xb6fc7000)

ls -l /usr/lib/arm-linux-gnueabihf/libarmmem*
lrwxrwxrwx 1 root root    16 Apr 30  2019 /usr/lib/arm-linux-gnueabihf/libarmmem-aarch64.so -> libarmmem-v7l.so
-rw-r--r-- 1 root root  9512 Apr 30  2019 /usr/lib/arm-linux-gnueabihf/libarmmem-v6l.so
-rw-r--r-- 1 root root 17708 Apr 30  2019 /usr/lib/arm-linux-gnueabihf/libarmmem-v7l.so
lrwxrwxrwx 1 root root    16 Apr 30  2019 /usr/lib/arm-linux-gnueabihf/libarmmem-v8l.so -> libarmmem-v7l.so

cat /usr/bin/mcs
  #!/bin/sh
  exec /usr/bin/mono $MONO_OPTIONS /usr/lib/mono/4.5/mcs.exe "$@"


Raspberry Pi 3+:
file /usr/bin/mono-sgen
/usr/bin/mono-sgen: ELF 32-bit LSB executable, ARM, EABI5 version 1 (SYSV), dynamically linked, interpreter /lib/ld-linux-armhf.so.3, for GNU/Linux 3.2.0, BuildID[sha1]=c2ba638f985376a32d8c831482a3f498b45c344b, stripped
file /usr/lib/mono/4.5/mcs.exe
/usr/lib/mono/4.5/mcs.exe: PE32 executable (console) Intel 80386 Mono/.Net assembly, for MS Windows
md5sum /usr/lib/mono/4.5/mcs.exe 
bfc12cba4917ca5793bbb1c74aa59e24  /usr/lib/mono/4.5/mcs.exe

5a171770d300363e3ec2eb60a854c481  csc.exe.so
df8506376fdf137d863e3bba99716b07  mcs.exe.so
4015357bc969c8a9be7193d59555debc  Microsoft.CodeAnalysis.CSharp.dll.so
4c55c6475790d96c7a245df5afa22358  Microsoft.CodeAnalysis.dll.so
c3c739f4753d6fa2770be8704f6f61a6  Microsoft.CodeAnalysis.VisualBasic.dll.so
405641746541bb05ea82ac45f20f5696  mscorlib.dll.so
8a32754f92db9671bd3beacc0bc3689d  System.Collections.Immutable.dll.so
1a4ec59a04636afaa39112fef86e7229  System.Reflection.Metadata.dll.so
32fcdc11684481eb72f638b3dce0cf8e  vbc.exe.so
ce4d8efa2c3ddac3b42b8e8ffa6407f6  VBCSCompiler.exe.so

-->

<!-- 
gcc -v

Raspberry Pi Zero und 2 identisch:

Using built-in specs.
COLLECT_GCC=gcc
COLLECT_LTO_WRAPPER=/usr/lib/gcc/arm-linux-gnueabihf/8/lto-wrapper
Target: arm-linux-gnueabihf
Configured with: ../src/configure -v --with-pkgversion='Raspbian 8.3.0-6+rpi1' --with-bugurl=file:///usr/share/doc/gcc-8/README.Bugs --enable-languages=c,ada,c++,go,d,fortran,objc,obj-c++ --prefix=/usr --with-gcc-major-version-only --program-suffix=-8 --program-prefix=arm-linux-gnueabihf- --enable-shared --enable-linker-build-id --libexecdir=/usr/lib --without-included-gettext --enable-threads=posix --libdir=/usr/lib --enable-nls --enable-bootstrap --enable-clocale=gnu --enable-libstdcxx-debug --enable-libstdcxx-time=yes --with-default-libstdcxx-abi=new --enable-gnu-unique-object --disable-libitm --disable-libquadmath --disable-libquadmath-support --enable-plugin --with-system-zlib --with-target-system-zlib --enable-objc-gc=auto --enable-multiarch --disable-sjlj-exceptions --with-arch=armv6 --with-fpu=vfp --with-float=hard --disable-werror --enable-checking=release --build=arm-linux-gnueabihf --host=arm-linux-gnueabihf --target=arm-linux-gnueabihf
Thread model: posix
gcc version 8.3.0 (Raspbian 8.3.0-6+rpi1) 



gcc -Q --help=target

The following options are target specific:
  -mabi=                      		aapcs-linux
  -mabort-on-noreturn         		[disabled]
  -mandroid                   		[disabled]
  -mapcs                      		[disabled]
  -mapcs-frame                		[disabled]
  -mapcs-reentrant            		[disabled]
  -mapcs-stack-check          		[disabled]
  -march=                     		armv6+fp
  -marm                       		[enabled]
  -masm-syntax-unified        		[disabled]
  -mbe32                      		[enabled]
  -mbe8                       		[disabled]
  -mbig-endian                		[disabled]
  -mbionic                    		[disabled]
  -mbranch-cost=              		-1
  -mcallee-super-interworking 		[disabled]
  -mcaller-super-interworking 		[disabled]
  -mcmse                      		[disabled]
  -mcpu=                      		
  -mfix-cortex-m3-ldrd        		[disabled]
  -mflip-thumb                		[disabled]
  -mfloat-abi=                		hard
  -mfp16-format=              		none
  -mfpu=                      		vfp
  -mglibc                     		[enabled]
  -mhard-float                		
  -mlittle-endian             		[enabled]
  -mlong-calls                		[disabled]
  -mmusl                      		[disabled]
  -mneon-for-64bits           		[disabled]
  -mpic-data-is-text-relative 		[enabled]
  -mpic-register=             		
  -mpoke-function-name        		[disabled]
  -mprint-tune-info           		[disabled]
  -mpure-code                 		[disabled]
  -mrestrict-it               		[disabled]
  -msched-prolog              		[enabled]
  -msingle-pic-base           		[disabled]
  -mslow-flash-data           		[disabled]
  -msoft-float                		
  -mstructure-size-boundary=  		8
  -mthumb                     		[disabled]
  -mthumb-interwork           		[disabled]
  -mtls-dialect=              		gnu
  -mtp=                       		soft
  -mtpcs-frame                		[disabled]
  -mtpcs-leaf-frame           		[disabled]
  -mtune=                     		
  -muclibc                    		[disabled]
  -munaligned-access          		[enabled]
  -mvectorize-with-neon-double 		[disabled]
  -mvectorize-with-neon-quad  		[enabled]
  -mword-relocations          		[disabled]

  Known ARM ABIs (for use with the -mabi= option):
    aapcs aapcs-linux apcs-gnu atpcs iwmmxt

  Known __fp16 formats (for use with the -mfp16-format= option):
    alternative ieee none

  Known ARM FPUs (for use with the -mfpu= option):
    auto crypto-neon-fp-armv8 fp-armv8 fpv4-sp-d16 fpv5-d16 fpv5-sp-d16 neon neon-fp-armv8 neon-fp16 neon-vfpv3 neon-vfpv4 vfp vfp3 vfpv2 vfpv3 vfpv3-d16 vfpv3-d16-fp16
    vfpv3-fp16 vfpv3xd vfpv3xd-fp16 vfpv4 vfpv4-d16

  Valid arguments to -mtp=:
    auto cp15 soft

  Known floating-point ABIs (for use with the -mfloat-abi= option):
    hard soft softfp

  TLS dialect to use:
    gnu gnu2
-->



