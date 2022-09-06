# examples/
This is a space for example code.

## example-script.sh
This is an example Bash script. The actual function of it is incredibly pointless (ultimately it takes in some placeholder parameters/flags, prints out the values it was given, and tries to list the contents of two directories - one you likely have, and one you likely don't have), but might help give you a framework for how you might structure your code. Take what you like, leave what you don't. Some of this is probably more than you need (like the logging, maybe).

All Bash scripts start with this special comment:
```
#! /bin/bash
```

When you createa new script file, make sure that you add execute permissions to your script files before you commit them to the repository for the first time:
```
chmod a+x examples/example-script.sh
```

### Random thoughts about Bash
Bash is a shell scripting language that you will find on most Linux/Unix (often "*nix") based systems, including Mac OS X. When you hear people refer to doing stuff "in (the) terminal" or "in/at the shell", theyre likely talking about a Bash environment. Bash is useful for writing scripts to run on *nix machines, as well as for text-based navigation of those systems. It is incredibly useful to be familiar with it if you're going to do any work on a server at all.

Bash is a procedural language; there's no object-oriented stuff at all. Bash is made up of many small, incredibly specialized commands that can be strung together to accomplish more complex tasks. Because all of the commands are so small, there is usually at _least_ 4 ways to accomplish any given task so don't get too hung up on the perfect way to do something.

In general, Bash commands and scripts will end with an exit code of 0 if they are successful and a non-zero code otherwise. This lets you check the exit code after running a command (using `$?`) to determine whether there was an error.

You preface the variable with `$` when you're using it/getting its value, but leave the `$` off when you set the variable to a value. Where Abby learned about Bash, there was a convention to make variable names ALL_CAPS_AND_SEPARATED_BY_UNDERSCORES so that you can distinguish them in the code at a glance, but it's not required.

### Other Bash resources
- [Luke has a set of learning material for the command line](https://sites.google.com/a/mtholyoke.edu/the-cs-help-site/home/command-line-resources)
- Incredibly dry/old-school, but a definitive source for bash: [Bash Guide for Beginners](https://tldp.org/LDP/Bash-Beginners-Guide/html/)
- This is also decent for getting oriented to what bash is and has an intro to navigating at the command line, but doesn’t really talk about scripting: [Basics of Bash for Beginners](https://towardsdatascience.com/basics-of-bash-for-beginners-92e53a4c117a)
- Navigating around a computer using Bash is a different beast than writing scripts (little programs) in Bash. 
  - For day-to-day navigation, consider:
    - `man`, `ls`, `cd`, `pwd`, `mv`, `rm/rmdir`, `grep`, `sed`/`awk` (remember how there's at least 4 ways to do things in Bash? just choose a favorite), `less`/`more`, `cat`, `head`/`tail`, `echo`, `wc`, `sort`, `uniq`
  - Other good things to know about: 
    - `|` ("pipe"), `>`, `<`, `>>`, `&`, `*` ("star", usually)
  - Advanced/more targeted commands include: 
    - `sudo`, `chmod`, `bg`/`fg`, `top`/`htop`, `ping`, `nslookup`, `ssh`, `scp`, `sftp`, `nohup` 
  - Make sure you check the `man` pages for flags/options and arguments too! 
  - It's good to pick a command-line text editor and get at least passingly comfy with it so that you can tweak stuff on servers in a hurry. It's kind of a chaotic choice to _develop_ in a command-line text editor in the 2020s, but some people do it. Command-line text editors tend to rely heavily on astonishingly unintuitive keyboard shortcuts/macros, but using them can be incredibly powerful for certain tasks.
    - Most developers/administrators/programmers/engineers of a certain era will have a strong preference between `vi`/`vim` and `emacs` (two major text editors), although some prefer `pico` or some other program.
  - `^c` (control+c) or `q` will usually quit a running command/program within Bash - some programs (like `vi` or `emacs`) are more complicated to exit.
  - You can use `apropos` to look for Bash commands relating to a keyword or keywords, but honestly just using your choice of search engine (Google, etc) is probably faster.

