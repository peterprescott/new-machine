# Slack

There doesn't seem to be an obvious link to install Slack completely
from the command line.

Instead, go to
[https://slack.com/downloads](https://slack.com/downloads) and click on
"Download .DEB app" which for some reason is a `button` which through
some piece of impenetrably minified Javascript causes the Slack `.deb`
file to download.

Then if you try and download the file immediately with `dpkg`, you will
get this error:

```
dpkg: dependency problems prevent configuration of slack-desktop:
 slack-desktop depends on libappindicator3-1; however:
  Package libappindicator3-1 is not installed.
```

Fortunately, there is a solution on [Stack
Overflow](https://stackoverflow.com/questions/65978703/missing-libappindicator3-1-installing-slack).

The recommended script is saved here, so we can just do this:

```
./install-slack-with-fixed-dependency.sh slack*.deb
```
