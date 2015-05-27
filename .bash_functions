function gitty {
	git add -A :/ && git commit -m "${1}" && git push
}

function MYmkdir {
	mkdir $1 && cd $1
}
function public {
	sudo chmod -c 644 $1;
}
function ghelp {
	$1 --help | grep -i $2;
} 


