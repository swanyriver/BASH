# Tools for a great workflow

the following are things that can be built to improve ones productivity


## A way to query for buildable/testable targets
input: changed files (names)
intermediate: query for units that can be compiled or tests that can be run
intermediate: all || choose-via `comment | vipe | uncomment` || regex for targets
output: run and print resulting commands


## A command for text->url,  like paste-bucket
<command> | paste /dev/stdin
   http://.............

## A command to share a file to a shared dir &&|| a url
    remote_file="$sharedDir/$(basename $1)"
    cp $1 $remote_file;
    chmod 755 $remote_file
    echo $remote_file
    echo "https://$url_prefix/$(basename $1)" | teetotmux


## A command to get issue links/descriptions from cli, todo-comments from vim
Req: an api for querying issues
pipe through fzy

### a vim command to insert a TODO in prefered format for issues


## A function to run all changed files through formatting and conformance checks
preferably across a stack of revisions
remember that
  * a formatter can be applied to bottom revision
  * then the next revision force merged on top
  * and the formatter just ran again
  * repeat


## wrap long-running task in tmux bel, for hop-between ease
function ______ {
  command ___ "$@"
  tput bel
}


## A function to fuzzy select a file and get a link
  srcdir="root/dir"
  file=$(
    for f in $PROJECT_PATHS; do
      echo "${srcdir}$f";
    done | xargs -P 20 -n 1 fd -t f . | fzf | grep -oP "${srcdir}\K.*"
  )
  echo "http://$url_prefix/${file}"


## A function for sharing images

## A fuction for taking screenshots of results combined with image-share

## A function for deploying latest/chosen pre-built artifacts
Req: an api for querying scheduled builds
Req: an api for downloading said artifacts
Req: a function for installing/deploying said artifacts

getlatest: query, choose-most-recent, download, deploy
chooseLatest: query, fzy, !*


## Functions for saving and restoring tmux names + dir

### TODO add dir column if not inferable from name
function tmsave {
  for p in $(tmux list-panes -s | grep -oP "^.*?(?=: )"); do
    tmux display-message -p -t "$p" '#{pane_current_path}';
  done | uniq | grep "^/$prefix-dir" > ~/.tmux_windows_save
  cat ~/.tmux_windows_save
}

function tmrestore {
  for d in $(cat ~/.tmux_windows_save | cut -f 6 -d "/"); do
    tmux new-window -n $d -c $prefix-dir/$d/
  done
}

## A function to report changes (who/what) to a file or dir succinctly
a one line:  who, date, link, desc

## reviewpatch
checkout a revision in my attention set, and open in vim for `review`
req: a way to query pending revisions
req: a way to import said revisions
choose with fzy
open with `review` function

## Squash branch system
some system for combining many small revisions (local) to a single revision (public)
  a commit flag that manages this with multiple in a stack (a->b->c)->(x->y) is best
  failing that a system for managing a dev branch and a squash branch


## get qf-results that combine rg of locally modified files and remote search results
function quickfix_search {(
  if [[ "${1}" == "-r" ]]; then
    local useRegex="1"
    shift
  fi

  local query="$1"
  shift

  # rg changed files
  # xargs -r ensures nothing runs if there are no args
  if [[ $useRegex != "1" ]]; then
    local rgFixed="-F"
  fi
  hgnames | xargs -r rg --no-config --vimgrep $rgFixed "$query"

  if [[ $useRegex != "1" ]]; then
    # qoute the query, search exactly,  good for copied code
    query="\"${query}\""
  fi
  <Some remote file search api file,line,col,text>
  <quick-fix sed if needed>
  <adapt to local file format if needed>

  # remove matches that are from changed files
  rg --no-config -v -f <(echo "BRANDON_NOT_EMPTY"; hgnames) -
)}


## A function sourced when in tmux that starts a new project or finds and resumes and sets the tmux window name accordingly
  name=$( <project-list> | fzy)
  while [[ -z $name ]]; do
    echo -n "New-project-Name:"
    read name
  done

  dir="<project-dir>/$name/"

  if [[ ! -d "$dir" ]]; then
    <make new project>
  fi

  tmux new-window -n $name -c "$dir"


## Find particular url formats in tmux buffer and then give them to teetotmux (show and clipboard)
  get-entire-tmux-pane
  cat $TMUX_CAPTURE_FILE |
    tac |
    grep -o -m 1 -P "http:\/\/<regex>" - |
    teetotmux


## a way to publish markdown notes to html url
markdeep works well,  make a copy of  markdeep.min.js and slate theme and use the following overrides
https://casual-effects.com/markdeep/slate.md.html

### style overrides

h1:before, h2:before, h3:before { content: none !important; }
.md .longTOC { display: none !important; }
/* TODO possibly better margin, with code and headings able to be wider */
/* margin auto centers it */
body {
    max-width: 1000px !important;
    margin: auto !important;
    left: 0px !important;
}
/* move weird bar to under heading */
.md h1 {
    border-top: none !important;
    border-bottom: 6px solid #5a5a5a !important;
}

### append to *.md.html

<link rel="stylesheet" href="https://$url-prefix/markdeepcopy/slate.css">
<!-- style overrides --> <link rel="stylesheet" href="https://$url-prefix/markdeepcopy/slate_overrides.css">
<style class="fallback">body{visibility:hidden}</style><script>markdeepOptions={tocStyle:'long'};</script>
<!-- Markdeep: --><script src="https://$url-prefix/markdeepcopy/markdeep.min.js" charset="utf-8"></script>

### write a script to:
* Move $1 to local git repo
* change its extension to .md.html
* append the above markdeep footer

### after verify with pyserve, script to
* copy that file to remote dir
* set permission
* return url

### a script to retrieve said urls
  fd -t f . $remote_dir | \
    sed "s|^$remote_dir||" | \
    fzf --preview="if [[ {} =~ \.md\.html$ ]]; then batcat --language=md --color=always $MY_X20{}; else batcat --color=always $remote_dir{}; fi" | \
    echo "${remote_url_prefix}$(cat /dev/stdin)"


## draw grids or other guidelines over screenshots

use imagemagick to draw lines programitcally
```
# stdin image goes to stdout with drawings
img_out=$(mktemp --suffix=".png")
echo "temp_file: $img_out" > /dev/stderr
cat /dev/stdin > $img_out

width=$(identify -format "%w" $img_out)
height=$(identify -format "%h" $img_out)
echo "captured dimens: ${width}x${height}" > /dev/stderr

# example brush-settings and draw commands
convert $img_out \
  -strokewidth 0 -fill "rgba( 255, 0, 0 , 0.3 )" \
  -draw "rectangle 0,0 $x,$height" \
  -stroke red -strokewidth 3 \
  -draw "line ${line_xs[2]},0 ${line_xs[2]},$height" \
  ...
  $img_out

cat $img_out
rm $img_out
```

### get dimens of android
width for example
  adb -s $1 shell dumpsys window | grep  mGlobalConfiguration | grep -oP "\bw\d+dp\b" | grep -oP "\d+"


## all_do  some cli way to perform under-dev action across multiple clients/users
From canned file or from stdin
  action=${@:-"$(next_in_file ${HOME}/actions.txt)"}
for-all-x: x-do-$action


## neovim/lua  call some api, and then insert results into buffer
``` someapipicker.lua
local pickers = require "telescope.pickers"
local finders = require "telescope.finders"
local conf = require("telescope.config").values
local actions = require "telescope.actions"
local action_state = require "telescope.actions.state"

local some_picker_choose = function(opts)
  opts = opts or {}
  some_command = opts.some_command or {"<command>", "<action>", "<--flags>"}
  pickers.new(opts, {
    prompt_title = "<helpful title at top of telescope window>",
    finder = finders.new_oneshot_job(some_command, opts),
    sorter = conf.generic_sorter(opts),
    --- this sets what happens when keys (like enter for select) are pressed
    attach_mappings = function(prompt_bufnr, map)
      actions.select_default:replace(function()
        actions.close(prompt_bufnr)
        local selection = action_state.get_selected_entry()
        vim.call("someFormatVimFunction", selection[1])
      end)
      return true
    end,

  }):find()
end

-- for dev with :luafile %
-- some_picker_choose()

return {
  choose = some_picker_choose,
}

-- use:
-- :lua require("someapipicker").choose()
```

```some_formmatter.vim
function! someFormatVimFunction(resultText)
  let saved_unnamed_register = @@
  let l:extracted_text = ....

  if &filetype == "gitcommit" || &filetype == "hgcommit"
    let saved_unnamed_register = @@
    let @@="<prefix>" . l:extracted_text . "\n"
    norm p
  else
    let @@="<prefix>" . l:extracted_text . " -  \n"
    normal P==
    Commentary
    startinsert!
  endif

let @@ = saved_unnamed_register
endfunction

function! InsertSomething()
  lua require("someapipicker").choose()
endfunction

nnoremap <KEY-COMBO> :<c-u>call InsertSomething()<cr>
```


## A vim tool for getting shareable links to code along with code-blocks
Good for sharing and for note-taking

### a matching gf override that can go-to-file local copy or remote-view from noted urls

## A vim tool for opening revision description/message, author, and date for a given line (better blame)
