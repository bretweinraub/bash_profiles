
export  PATH=/usr/local/m80-0.07/bin:$PATH
export PATH=$PATH:/var/lib/gems/1.8/bin

setVar () {
    _data=$1
    shift
    eval export $_data=\"$*\"
#     if [ -n "$SSH_TTY" ]; then
# 	echo export $_data="$*"
#     fi
}

CVS () {
    setVar CVS_RSH ssh
    case $1 in 
	renwix)
	    setVar CVSROOT :ext:bret@renwix.com:/home/sites/95264840/users/bret/cvsroot;;
	m80)
	    setVar CVSROOT :ext:bretweinraub@cvs.sourceforge.net:/cvsroot/m80;;
	cc)
	    setVar CVSROOT :pserver:anonymous@cvs.cruisecontrol.sourceforge.net:/cvsroot/cruisecontrol;;
	ant)
            setVar CVSROOT :pserver:anoncvs@cvs.apache.org:/home/cvspublic login;;
    esac
}

setVar BG_COLOR SlateBlue4
setVar FG_COLOR white
setVar PATH $PATH:/usr/sbin:/sbin
setVar P4EDITOR "emacs -nw"
setVar BG_COLOR SlateBlue4
setVar FG_COLOR white

alias c="clear"
alias x="chmod +x "

if [ $TERM != "dumb" ]; then # emacs sets term to dump; and can't read the color output of ls
    alias ls="/bin/ls --color=always -aF"
else
    alias ls="/bin/ls -aF"    
fi

alias ll="ls -l"
alias m=less
alias Mkdir=be
Make () {
    m80 --execute make $* ; 
}
alias reload="X=$(pwd); . ~/.profile; cd ${X}"
#alias hg='history | grep'
alias Hg='history | grep'
alias llynx="lynx -nocolor -accept_all_cookies"
alias h=history
alias renwix="ssh -l bret renwix.com"
alias x="chmod +x "
alias rpmg=" rpm -q --all | grep -i"

rpml () {
    rpm -q --list $1
}

recat () {
    rm $1 ; make $1 ; cat $1
}

reless () {
    rm $1 ; make $1 ; less $1
}

f () {
    searchStr="${1:-.};"
    find .| egrep -i '$searchStr'
}

be () {
    mkdir -p $1
    if [ $? -eq 0 ]; then
	cd $1
    fi
}

e () {
    title=${M80_DIRECTORY_SELECTED}:${M80_BDF}
    (emacs -cr gold --title $title -bg $BG_COLOR -fg $FG_COLOR -geometry 160x75+0 --no-splash $* &)
}

erails () {
    if [ -z "${M80_BDF}" ]; then
	echo "this makes no sense when \$M80_BDF is not set"
    else
	e -f rails-start
    fi
}
    

E () {
    ( /usr/bin/emacs -cr gold -bg $BG_COLOR -fg $FG_COLOR -geometry 160x75+0 $* &)
}

bigE () {
    ( /usr/bin/emacs -cr gold -bg $BG_COLOR -fg $FG_COLOR -geometry 135x68+0 -fn "lucidasanstypewriter-14" $* &)
}    

outdoorE () {
    ( /usr/bin/emacs -geometry 135x68+0 -fn "lucidasanstypewriter-14" $* &)
}    


dict () {
    lynx -nocolor -accept_all_cookies http://dictionary.reference.com/search?q=$* 
}

news () {
 lynx -nocolor -accept_all_cookies http://news.google.com/news/gnmainlite.html
}

- () {
    cd ..
}

-- () {
    - ; -
}
--- () {
    - ; - ; -
}


#setVar CVSROOT :ext:bret@renwix.com:/home/sites/95264840/users/bret/cvsroot

alias ll="ls -l"
alias m=less
alias Mkdir=be
alias reload=". ~/.profile"
alias hg='history | grep'
alias sshterm='rxvt --geometry 100x40 -e /bin/bash --login -i &'
alias rrxvt='rxvt --geometry 80x40 -fg white -bg SlateBlue4 -fn "-b&h-lucidalias sans typewriter-*-*-*-*-12-*-*-*-*-*-*-*" -e /bin/bash --login -i &'
alias llynx="lynx -nocolor -accept_all_cookies"
alias h=history
alias renwix="ssh -l bret renwix.com"

f () {
    searchStr=${1:-.};
    find .|grep -i $searchStr
}

be () {
    mkdir -p $1
    if [ $? -eq 0 ]; then
	cd $1
    fi
}


dict () {
    lynx -nocolor -accept_all_cookies http://dictionary.reference.com/search?q=$* 
}

news () {
 lynx -nocolor -accept_all_cookies http://news.google.com/news/gnmainlite.html
}

- () {
    if [ $# -eq 0 ]; then 
	cd ..
    else
	x=$1
	while [ $x -gt 0 ]; do
	    cd ..
	    ((x=$x-1))
	done
    fi
}

-- () {
    - ; -
}
--- () {
    - ; - ; -
}

---- () {
    - ; - ; - ; -
}

dinstall () {
    (cd $* ; sudo make install)
}

tstop () {
    (cd ${CATALINA_HOME}/bin ; ./shutdown.sh ;)
}


trestart () {
    (cd ${CATALINA_HOME}/bin ; ./shutdown.sh ; ./startup.sh)
}

# set display based on who command

mytty=$(tty  | cut -c6-)  
display () {
    if [ -n "$SSH_TTY" ]; then
	set -x
	eval $(who | awk '$2 == "'$mytty'" {print $NF}' | perl -nle 's/.*\((.*)\)/$1/g;print "export DISPLAY=".$_ . ":0"')
	chars=$(echo $DISPLAY  | wc -c)
	if [ $chars -le 8 ]; then
	    echo export DISPLAY=:0
	    export DISPLAY=:0
	else
	    echo export DISPLAY=$DISPLAY
	fi
	set +x
    fi
}

log () {
    tail -f ${CATALINA_HOME}/logs/catalina.out
}

setVar PATH_BASE $PATH

taskCommit () {
    (cd ${WORK_HOME}; cvs commit -m 'latest updates' Tasks.xls)
}

update () {
    (cd ${WORK_HOME} ; cvs update -d)
}

new () {
    ls -lt $* | head
}

profile () {
    $EDITOR ~/.profile
    reload
}

p4dateToWLW () {
    echo $(p4 describe $1 | head -1 | awk '{print $6 " " $7}' | tr "/" "-")".0"
}


client () {
    CLIENT=$1
    CLIENTFILE=~/bdw/."${CLIENT}"
    if [ -f $CLIENTFILE ]; then
	echo loading $CLIENTFILE
	. $CLIENTFILE
    else
	echo no client ${CLIENT} found
    fi
}

mapcar () {
        function=$1
        shift
        while [ $# -ne 0 ]; do
                $function $1
                shift
        done
}


trestart () {
    tcmd stop
    tcmd start
}

SQL () {
    test $# -eq 1 && {
	db $1
    }
    DATABASE_NAME=$(m80 --execute echo \$DATABASE_NAME)
    if [ -n "$DATABASE_NAME" ]; then
	echo sqlplus $DATABASE_NAME
	sqlplus $DATABASE_NAME
    else
	echo Dude .... set \$DATABASE_NAME
    fi
}

bdwcommit () {
    (cd ~/bdw && eval cvs commit -m \"$*\")
}


m80update () {
    (cd ~/m80 && eval cvsupdate)
}

alias cvsupdate="cvs update -P -d"

alias bucket="sort | sc.pl | awk 'NF > 0' | sort -n"
alias grep="grep --color"

m80install () {
    (cd ~/m80/$1 && make)
    (cd ~/m80/$1 && sudo make install)
}


setVar M80_REPOSITORY ~/m80/examples/m80repository

cd () { 
    command cd $*; 
    if [ -f .localenv ]; then 
	. .localenv 
	test -n "$SSH_TTY" && cat .localenv 
    fi
    export CDPATH=$(echo $CDPATH:$(pwd) | tr ":" "\n" | sort -u | perl -ne 'chomp;print "$_:";')
}

load () { 
    eval $(grep $1 ~/.profile) ; 
}

submit () {
    p4 revert -a $1 
    env P4EDITOR="emacs -nw" p4 submit $1
}

sshKeyPromote () {
    sshPubkey=~/.ssh/id_rsa.pub
    if [ $# -ne 2 ]; then
	echo usage: sshKeyPromote user host
    fi
    if [ -f $sshPubkey ]; then
	cat ~/.ssh/id_rsa.pub | ssh -l $1 $2 'cat >> .ssh/authorized_keys'
    else
	echo build yer ssh key first
    fi
}

gzipp () {
    test $(file -b $1 | awk '{print $1}') = "gzip"
    $?
}

explode () {
    while [ $# -gt 0 ]; do
	gzipp $1 && {
	    _zipFlag=z
	}
	tar ${_zipFlag}xvf $1
	_zipFlag=
	shift
    done
}

ediff () {
    while [ $# -gt 1 ]; do
	set $*
	emacs -cr gold -bg $BG_COLOR -fg $FG_COLOR -geometry 120x65+0 --eval '(ediff-files "'$1'" "'$2'")'
	shift
    done
    echo nothing more to do.....
}

loader ()  {
    while [ $# -ne 0 ]; do
	file=$1
	if [ -f $file ]; then
	    . $file
	    echo "loaded $file"
	fi
	shift
    done
}
 
loader ~/.local ~/.localenv  ~/.$(/bin/hostname -s)

m80chooser () { eval $(m80 --chooser);}

renwixTunnel () {
	ssh -l bret -f -q -x -L 1666:localhost:1666 renwix.com "sleep 14400"
}

perlshell () 
{ 
    perl -e 'print "-> "; while(<>) {$xyzzy=eval; print "$@" if $@; print "\n-> ";}'
}


m80setEnv () {
    m80directory
    m80chooser
    cd $TOP
    . shelloader.sh
}

tty=$(tty)

if [ -n "${tty}" ]; then
    eval $(m80 --genfuncs)
#    m80setEnv
#    display
fi

rebuild () {
    rm $*
    mexec make $*
    less $*
}

numCPUs=$(awk '$1 == "processor"' < /proc/cpuinfo | wc -l | perl -nle 's/\s+//g;print')

alias pmake="make -j$numCPUs"


dumpLogs () {
    cat /var/www/html/bweinrau.bld-cmbuild4-sm.dev/taskData/$1/* | less
}
export LS_COLORS='no=00:fi=00:di=01;35:ln=01;36:pi=40;33:so=01;35:do=01;35:bd=40;33;01:cd=40;33;01:or=40;31;01:ex=01;32:*.tar=01;31:*.tgz=01;31:*.arj=01;31:*.taz=01;31:*.lzh=01;31:*.zip=01;31:*.z=01;31:*.Z=01;31:*.gz=01;31:*.bz2=01;31:*.deb=01;31:*.rpm=01;31:*.jar=01;31:*.jpg=01;35:*.jpeg=01;35:*.gif=01;35:*.bmp=01;35:*.pbm=01;35:*.pgm=01;35:*.ppm=01;35:*.tga=01;35:*.xbm=01;35:*.xpm=01;35:*.tif=01;35:*.tiff=01;35:*.png=01;35:*.mov=01;35:*.mpg=01;35:*.mpeg=01;35:*.avi=01;35:*.fli=01;35:*.gl=01;35:*.dl=01;35:*.xcf=01;35:*.xwd=01;35:*.ogg=01;35:*.mp3=01;35:*.wav=01;35:';


pfind () { for f in $(p4 files ... | grep -v delete | cut -d# -f1 | cut -d/ -f7-); do grep $* $f /dev/null; done; }

srcStableInteg () {
    while [ $# -gt 0 ]; do
	p4 integ -it //depot/dev/src_stable/...@=$1 //depot/dev/src/... 
	shift
    done
    p4 resolve //depot/dev/src/...
    p4 submit //depot/dev/src/...
}

pman () {
    local LANG
    unset LANG
    pod2man $1 | nroff -man | ${PAGER:-less -R}
}

repair () {
    f=$(echo $1 | cut -d: -f1)
    l=$(echo $1 | cut -d: -f2)

    vi +$l $f
}

m80edit () { 
    emacs -nw /usr/local/home/bweinrau/dev/sandbox/bweinrau/perf/v3.0_dev/m80repository/bdfs/$M80_BDF.sh.m80 ; 
}

latest () {
    /bin/ls -1rt $* | tail -1
}

export PS1='\u@\h:\w($M80_BDF)-> '

match () {
    for f in $(find . -type f | grep -v '~' | grep -v \.svn\/) ; do 
	grep $* "$f" /dev/null 2> /dev/null
    done
}

export EDITOR="emacs -nw"

unset LANG

devman () {
    (cd ~/dev && ./devman.pl $*)
}

think () {
    history | grep $* | grep -v think | grep -v hg | tail -1 | perl -nle 's/^\s+\d+\s+//; print'
    eval $(history | grep $* | grep -v think | grep -v hg | tail -1 | perl -nle 's/^\s+\d+\s+//; print')
}

alias ..='pushd ..'
alias ...='pushd ../..'
alias ....='pushd ../../..'
alias .....='pushd ../../../..'
alias ......='pushd ../../../../..'

assign_m80directory () {
  val=$(echo | m80 --directory 2>&1 | grep $1 | cut -d')' -f1)
  eval $(echo ${val} | m80 --directory)
}

if [ -n "#{SSH_TTY}" ]; then
    if [ -n "${M80_DIRECTORY_SELECTED}" ]; then
	assign_m80directory $M80_DIRECTORY_SELECTED
    fi
fi

case "$TERM" in
xterm*|rxvt*)
    PROMPT_COMMAND='echo -ne "\033]0;${USER}@${HOSTNAME}: ${PWD/$HOME/~}\007"'
    ;;
*)
    ;;
esac

[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm"  # This loads RVM into a shell session.

# xgem () { gem $* --no-ri --no-rdoc; }
    
rvmuse () {
    gemsets=$(grep '@' < <(cd ~/.rvm/gems; find . -maxdepth 1 -type d )|sort)
    set $gemsets
    x=0
    while [ $# -gt 0 ];do 
	((x=$x+1))
	echo $x"): "$1 >&2
	shift
    done
    read line
    x=0
    set $gemsets
    while [ $# -gt 0 ];do 
	((x=$x+1))
	if [ "$line" = "$x" ]; then
	    eval "rvm use "$(echo $1 | cut -d/ -f2-)
	fi
	shift
    done
}

hobo_wtf () {
  $EDITOR $(find $(rvm gemdir)/gems/hobo* -iname '*.dryml' -exec grep 'filter-menu' {} + | cut -d: -f 1 | uniq)
}
