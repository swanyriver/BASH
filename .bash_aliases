alias gitlibs="git clone git@github.com:swanyriver/SwansonObjects.git && git clone git@github.com:swanyriver/SwansonLibs.git"
alias flip="ssh swansonb@flip2.engr.oregonstate.edu"
#alias gitty="git add -A && git commit && git push"

#alias get="sudo apt-get install"
alias get="sudo aptitude install"

alias phperr="tail -f //var/log/apache2/error.log"

alias syslog='watch -d dmesg | tail'

alias mflip='sshfs swansonb@flip.engr.oregonstate.edu://nfs/stak/students/s/swansonb ~/FLIP'

alias umflip='fusermount -u ~/FLIP'

alias clipboard='xclip -sel clip'

alias findtabs="grep -P '\t' *"

alias rapache="sudo service apache2 restart"

function geditb { gedit $@ & > /dev/null 2>&1;};
alias gedit="geditb"
alias allfunctions="declare -f"

alias sonid='ssh swansonb@shell.onid.oregonstate.edu'

alias stapp='ssh -i ~/CRED/skilltapp.pem ubuntu@ec2-52-24-190-135.us-west-2.compute.amazonaws.com'


