# Bash Demo: use ImageMagick to get image diffs

ImageMagick to the rescue yet again,  the `compare` utility can create diff
images that highlight the diff between two images just like a git diff of two files, it
is as simple as `compare a.png b.png output_diff.png` with an optional flag if
you want it to use the same color scheme as Scuba `-highlight-color Magenta`.


//TODO rename if not using android
```
compare png:<(andriod-screenshot a) png:<(android-screenshot b) diff.png
```

!!! note
    see below for actual code for *android-screenshot* 

## Sample diffs

// TODO sample diffs

## A note about command/process substitution

The bash functions below make extensive use of [`command substitution`](https://www.gnu.org/software/bash/manual/html_node/Command-Substitution.html)
```
stdout_of_foo=$(foo)
```
or
```
process $(foo_that_gets_arg_for_process)
```

This syntax is very powerful and also very dangerous because it is essentially
arbitrary-code-execution, see more here [https://tldp.org/LDP/abs/html/commandsub.html](https://tldp.org/LDP/abs/html/commandsub.html).

### `command substitution`'s lesser known friend `process substitution`

```
process_that_operates_on_foo_args <(process_that_outputs_foo)
```
what happens when `<()` is supplied as an argument is that file-descriptor is
the `stdout` of the contained process is associated with a file-descriptor, and
that same file-descriptor
is supplied as an arg to `$0`.   When is this useful?  When there is a stubborn process
that expects a file arg and refuses to receive piped input (or needs `stdin` for
actual tty input).  Or, and this is relevant to this image diffing project, when
you want to have a process receive the `stdout` of more than one upstream process,
such as a diff tool like `compare`

This doc on the topic of Bash one-liners and redirections [https://catonmat.net/bash-one-liners-explained-part-three](https://catonmat.net/bash-one-liners-explained-part-three) refers to these
`process substitution` args as `anonymous named pipe` and I found that
description to be helpful in understanding/remembering this syntax and how to
use it.

### A note on data formats and `process substitution`

The functions below that invoke `ImageMagick` with `process substitution` args
or receive PNG images on `stdin` over a pipe must specify that it is in fact PNG
formatted data, due to not having a `*.png` file name arg to indicate that.
Hence `png:<()` for `process substitution` or `png:-` for specifying that
reading from `stdin` or writing to `stdout` should use PNG format.

## Compare the screens of two Android devices

!!! Tip
    Notice these files do not have a `#!/bin/bash` shebang at the top, they are
    not shell scripts but collections of shell functions,  so instead of
    `./compareAdb.sh`, they should be used by adding them to `.bashrc` or to a
    seperatly sourced file and invoked by function name.

```
// TODO put in funcs here
```

