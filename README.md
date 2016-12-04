Name
====

opsboy - Automating deployment

Table of Contents
=================

* [Name](#name)
* [Synopsis](#synopsis)
* [Description](#description)
* [Copyright & License](#copyright--license)

Synopsis
========

Basic usage

```

# assignment in opsboy file scope.
foo = bar; # opsboy's assignment syntax. variables can be interpolated like in shell.

# comment in opsboy file.
#foo = bar; # opsboy use # as comment syntax.

# rule and target.

Basically,

    foo {
	directive1;
	directive2;
    }

is a rule. And foo is the target. It's quite similar to Makefile's rules per se.

We use the opsboy compiler to generate standalone Perl scripts that can build a 
system environment incrementally through a specification of rules.

./openresty-test.pl make foo 

# command
All opsboy syntactic structures and directives are listed below.

# git
git git@github.com location;  # git clone resource to location.

# file
file location; # check if file exist, if not create.

# running
running 'process matching part'; # check the existence of running processes 
through the specified command-line string pattern. if no processes match the 
pattern, make the current rule fail immediately.

# dep
dep block1 block2 block3; # specifying dependency rule names which must be 
checked and fulfilled before running the current rule.

# cwd
 cwd location; # change working directory.

# test
test cmd; # test if the command cmd can run successfully. If not, make the 
current rule fail without executing any other commands associated with the 
current rule.

# env
env key value; # working like bash's export command;
env PATH '~/git/lua-nginx-module/work/nginx/sbin:$PATH'; # we can interpolate 
other environment variables inside the envirment variable values here. 

# always
always; # exec blocking without conditions.

# sh
sh 'CMD'; # exec some shell command.

# yum
yum 'PKG'; # package installation through supported package manager (brew, yum,
dnf and pkg_add available now).

# debuginfo
debuginfo 'kernel-`uname -r`'; # install debuginfo.

# prog
prog program; # check whether the program exists and executable in the system's PATH environment.

# fetch
fetch source; # download source from internet with timestamp-checking.

# tarball
tarball file; # tar -xvf or -jxvf file.

# cpan
cpan package; # install perl CPAN packages.

```

Description
===========

This is a rule-based script generator for system environment incremental deployment.

    # on the developer host machine
    ./opsboy samples/openresty-tester.ob -o openresty-tester.pl

    # on the target machine
    ./openresty-test.pl make t-ngx_lua tv-ngx_srcache --git-pull force=1

Installation on the Developer Host Machine

    $ sudo cpan Pegex File::Copy

    This is not required on the target machine though. The target
    machine only needs to have perl 5 installed.

Copyright & License
===================

The bundle itself is licensed under the 2-clause BSD license.

Copyright (c) 2012-2016, Yichun "agentzh" Zhang (章亦春) <agentzh@gmail.com>, CloudFlare Inc.

This module is licensed under the terms of the BSD license.

Redistribution and use in source and binary forms, with or without
modification, are permitted provided that the following conditions are
met:

* Redistributions of source code must retain the above copyright notice, this list of conditions and the following disclaimer.
* Redistributions in binary form must reproduce the above copyright notice, this list of conditions and the following disclaimer in the documentation and/or other materials provided with the distribution.

THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS
IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED
TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A
PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT
HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED
TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR
PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF
LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING
NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.


