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
function makegit {

	if [[ ! $1 ]] ; then
		echo "must provide name"
		return 1
	fi

	name=$( echo $1 | tr ' ' '-' )

	auth=$(cat ~/BASH/github.cred)

	#totally silent
	#htresp=$(curl --write-out %{http_code} --silent --output /dev/null -u "swanyriver:l00tsc00t" https://api.github.com/user/repos -d "{\"name\":\"$name\", \"description\":\"$2\"}" )

	#verbose and with log of returned json  #better version will pipe output to different process, get the exact ssh url instead of parse it
	#htresp=$(curl --write-out %{http_code} --output ~/BASH/log -u "$auth" https://api.github.com/user/repos -d "{\"name\":\"$name\", \"description\":\"$2\"}" )

	#returned output other than http response is lost, packet information shown	
	htresp=$(curl --write-out %{http_code} --output /dev/null -u "$auth" https://api.github.com/user/repos -d "{\"name\":\"$name\", \"description\":\"$2\"}" )

	if [[ $htresp == 201 ]] ; then
		echo "created github repo $name"
		if [[ ! $3 ]] ; then
			commitmsg="first commit"
		else
			commitmsg=$3
		fi

		git init && git add -A :/ && git commit -m "$commitmsg" && git remote add origin git@github.com:swanyriver/${name}.git && git push -u origin master
		return 0
	else
		echo "FAILED: github response code $htresp"
		return 1
	fi
}


