
. ~/.bashrc

alias c="clear"
alias x="chmod +x "

if [ $TERM != "dumb" ]; then # emacs sets term to dump; and can't read the color output of ls
	ls --color=always >& /dev/null
	if [ $? -ne 0 ]; then
		alias ls="/bin/ls -FaG"
	else
		alias ls="/bin/ls --color=always -aF"
	fi
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

taskCommit () {
    (cd ${WORK_HOME}; cvs commit -m 'latest updates' Tasks.xls)
}

update () {
    (cd ${WORK_HOME} ; cvs update -d)
}

new () {
    ls -lt $* | head -50
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

cd () { 
    command cd $*; 
    if [ -f .localenv ]; then 
  	  . .localenv
	  test -n "$SSH_TTY" && cat .localenv >&2
    fi
    export CDPATH=$(echo $CDPATH:$(pwd) | tr ":" "\n" | sort -u | perl -ne 'chomp;print "$_:";')
}

load () { 
    eval $(grep $1 ~/.profile) ; 
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

 

# m80chooser () { eval $(m80 --chooser);}

perlshell () 
{ 
    perl -e 'print "-> "; while(<>) {$xyzzy=eval; print "$@" if $@; print "\n-> ";}'
}

m80setEnv () {
    echo 0 | m80directory
    m80chooser
    cd $TOP
    . shelloader.sh
    project-dir
}

tty=$(tty)

if [ -n "${tty}" ]; then
    which m80
    if [ $? -eq 0 ]; then # if m80 is in the path then....
	eval $(m80 --genfuncs)
    fi
fi

rebuild () {
    rm $*
    mexec make $*
    less $*
}

if [ -f /proc/cpuinfo ]; then
    numCPUs=$(awk '$1 == "processor"' < /proc/cpuinfo | wc -l | perl -nle 's/\s+//g;print')
fi

alias pmake="make -j$numCPUs"

dumpLogs () {
    cat /var/www/html/bweinrau.bld-cmbuild4-sm.dev/taskData/$1/* | less
}

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

export PS1='\u@\h:\w($ROVERENV)-> '

mmatch () {
    for f in $(find . -type f | grep -v '~' | grep -v \.svn\/) ; do 
	grep $* "$f" /dev/null 2> /dev/null
    done
}

ematch () {
    for f in $(find . -type f | grep -v '~' | grep -v \.svn\/) ; do 
	egrep "$1" "$f" /dev/null 2> /dev/null
    done
}


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

rvmuse () {
    if [ -d ~/.rvm/gems ]; then
	rvmdir=~/.rvm/gems
    else
	if [ -d /usr/local/rvm/gems ]; then
	    rvmdir=/usr/local/rvm/gems
	else
	    echo "RVM installed?"
	    return
	fi
    fi
    gemsets=$(grep '@' < <(cd $rvmdir; find . -maxdepth 1 -type d )|sort)
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
		new=$(echo $1 | cut -d/ -f2-)
		export RVMUSE=$new
	    echo eval "rvm use "$new
	    eval "rvm use "$new
	fi
	shift
    done
}

hobo_wtf () {
  $EDITOR $(find $(rvm gemdir)/gems/hobo* -iname '*.dryml' -exec grep 'filter-menu' {} + | cut -d: -f 1 | uniq)
}

function gemdir {
  if [[ -z "$1" ]] ; then
    echo "gemdir expects a parameter, which should be a valid RVM Ruby selector"
  else
    rvm "$1"
    cd $(rvm gemdir)
    pwd
  fi
}

if [ -f "${HOME}/dev/bitbucket/aura-rover-config/m81/m81loader.sh" ]; then
    . /home/bret/dev/bitbucket/aura-scripts/m81/m81loader.sh
fi

eline () {
    emacs -nw $1 --eval '(goto-line '$3')'
}

loader () {
    while [ $# -ne 0 ]; do
	if [ -f $1 ]; then
	    echo -n "Loading " $1
	    . $1
	fi
	shift
    done
}

loader ~/.local ~/.localenv  ~/.$(/bin/hostname -s)
export PATH=/usr/local/bin:$PATH

setroverdb () 
{ 
    roverenvs=$(cd .; bin/show_rover_envs )
    set $roverenvs
    x=0
    while [ $# -gt 0 ];do 
	((x=$x+1))
	echo $x"): "$1 >&2
	shift
    done
    read line
    x=0
    set $roverenvs
    while [ $# -gt 0 ];do 
	((x=$x+1))
	if [ "$line" = "$x" ]; then
	    echo eval "export ROVERENV="$(echo $1 | cut -d. -f1)
	    eval "export ROVERENV="$(echo $1 | cut -d. -f1)
	fi
	shift
    done
}

if [ "${TERM}" = "dumb" ]; then
	export PAGER=cat #emacs
fi

if [ -d /usr/local/share/npm/bin ]; then
	export PATH=$PATH:/usr/local/share/npm/bin
fi

if [ -d $HOME/trac ] ; then
	export PATH=$PATH:$HOME/trac
fi

trac () {
	$HOME/trac/trac_curl.rb $* 
}

git-branch () {
	git rev-parse --abbrev-ref HEAD
}

git-push () {
    remotes=$(git remote -v |grep '(push)'|awk '{print $1}')
    for remote in $remotes; do
        echo pushing to $(git-branch) on $remote
        git push $remote $(git-branch)
    done
}

git-clone () {
    git clone git@code.aura-software.com:aura/$1.git
}

git-pull () {
    remotes=$(git remote -v |grep '(push)'|awk '{print $1}')
    for remote in $remotes; do
        echo pulling from $(git-branch) on $remote
        git pull $remote $(git-branch)
    done
}

alias s="sudo"

SourceTree () {
  open -a SourceTree $(pwd)
}


aura-clone () {
  git clone git@bitbucket.org:aura_software/$1.git
}


[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*
