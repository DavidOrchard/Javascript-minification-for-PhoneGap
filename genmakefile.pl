print <<FOO;
SHELL = /bin/sh
CHMOD = chmod
CP = cp
MV = mv
NOOP = \$(SHELL) -c true
RM_F = rm -f
RM_RF = rm -rf
TEST_F = test -f
TOUCH = touch
UMASK_NULL = umask 0
DEV_NULL = > /dev/null 2>&1
MKPATH = mkdir -p
CAT = cat
MAKE = make
OPEN = open
ECHO = echo
ECHO_N = echo -n
JAVA = java
DOXYGEN = 
IPHONE_DOCSET_TMPDIR = docs/iphone/tmp
YUI = '../../util/yuicompressor-2.4.2.jar'
NAME = $ARGV[1]
NAME_MIN = $ARGV[1]-min


all :: \$(NAME) 

clean :: clean_libs

clean_libs:
	\$(RM_RF) js/\$(NAME_MIN).js
	\$(RM_RF) js/\$(NAME).js

www/\$(NAME).js: js/\$(NAME_MIN).js
	\$(CP) js/\$(NAME_MIN).js \$@

\$(NAME): js/\$(NAME_MIN).js

js/\$(NAME_MIN).js: js/\$(NAME).js
	\$(JAVA) -jar \$(YUI) --charset UTF-8 -o \$@ js/\$(NAME).js  

js/config/config_dev.js:
	echo "" \> js/config/config_dev.js

FOO
open(FILE, $ARGV[0]);
print "js/\$(NAME).js: ";
while(<FILE>) {
if (m{<script src="(\S*?)"} && $1 ne "phonegap.js" && $1 ne "js/\$(NAME).js" && $1 ne "js/\$(NAME_MIN).js" && $1 ne "js/common/contrib/jquery-1.4.2.min.js" && $1 ne "js/common/contrib/iscroll-3.6b1.min.js") {
print "$1\ ";
} 
}
close(FILE);
print "\n";
print "	\$\(RM_F\) \$\@\n";
open(FILE, $ARGV[0]);
while(<FILE>) {
if (m{<script src="(\S*?)"} && $1 ne "phonegap.js" && $1 ne "js/\$(NAME).js" && $1 ne "js/\$(NAME_MIN).js" && $1 ne "js/common/contrib/jquery-1.4.2.min.js" && $1 ne "js/common/contrib/iscroll-3.6b1.min.js") {
print "\t\$(CAT) $1\  \>\> \$\@\n";
print "\t\$(ECHO) \";\" \>\> \$\@\n";
} 
}
close(FILE);