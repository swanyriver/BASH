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
	username=$(echo auth | cut -f1 -d ":")
	json="{\"name\":\"$name\", \"description\":\"$2\"}"
	url="https://api.github.com/user/repos"

	#returned output other than http response is lost, packet information shown	
	htresp=$(curl --write-out %{http_code} --output /dev/null -u "$auth" $url -d "$json" )

	return 1  #remove later

	if [[ $htresp == 201 ]] ; then
		echo "created github repo $name"
		if [[ ! $3 ]] ; then
			commitmsg="first commit"
		else
			commitmsg=$3
		fi

		git init && git add -A :/ && git commit -m "$commitmsg" && git remote add origin git@github.com:${username}/${name}.git && git push -u origin master
		return 0
	else
		echo "FAILED: github response code $htresp"
		return 1
	fi
}

