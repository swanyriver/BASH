function gitty {
	git add -A :/ && git commit -m "${1}" && git push
}

function MYmkdir {
	mkdir $1 && cd $1
}
function public {
	chmod -c 644 $1;
}
function ghelp {
    prog=$1;
    shift;
    $prog --help | grep $* --color=always | less -R
} 

function kindle {
    ebook-covert "$1" "$1.mobi"
}
