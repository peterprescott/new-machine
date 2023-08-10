# new-machine

This is for me, to make setting up a new computer as swift as possible.
Perhaps it will be useful to someone else. But mainly it's public to
make it easier for me to get hold of it, without needing to authenticate
my identity on a computer not yet set up.

I begin by [installing Debian](https://www.debian.org/download)
*without* any desktop environment, and then manually install the [`xorg`
graphical server](https://wiki.debian.org/Xorg) and [`i3` tiling/window
manager](https://i3wm.org/docs/userguide.html), build the [ly TUI login
manager](https://github.com/fairyglade/ly), and only then switch to a
very minimal graphical environment.

But when I say 'manually', all I mean is that the way I want things
setup isn't one of the Debian installer's default options. So these
scripts are my attempt to simplify things.

Having installed Debian with no desktop environment -- and I'm assuming
there's a working ethernet connection to the internet --

First, login as root, and:

```
who=peterprescott
apt install -y git
cd /home/$who
git clone https://github.com/$who/new-machine
./new-machine/grant-sudo.sh $who
```

Now that `git` and `sudo` are installed, and I've been given `sudo`
rights, I can `exit`, and login as myself, and:

```
./new-machine/start.sh
```

This should then run various scripts to:

- setup my [.dotfiles](https://github.com/peterprescott/.dotfiles);
- install the other basic system tools I need as soon as possible;
- download the vim-plug plug-in manager I still use;
- update `grub` to avoid the annoying blue screen when Debian loads;
- clone the `ly` repo, make and install;
- try various strategies to silence those ear-splitting terminal beeps;
- install Miniconda;
- install Brave browser;
- install the Github CLI;
- install Docker;
- connect to WiFi.

If everything is working perfectly, nothing else should be required.
Just reboot and it will load in graphical mode.

Even if everything's not working perfectly, those scripts should help
give an idea of how to do the things I want to do.
