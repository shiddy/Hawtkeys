# Hawtkeys

The *nix&macOS glue code that maps your Hotkey Daemon to your Needs

# Requirements

## *nix
* rofi - https://github.com/davatorium/rofi
   * Mechanism to choose from a list (similar to dmenu)
* sxhkd - https://github.com/baskerville/sxhkd
   * Mechanism to enable global hotkeys
### Optional
* mpg123 - http://mpg123.org/
   * means to play audio files from the command line

## macOS
* choose-gui - https://github.com/chipsenkbeil/choose
  * Mechanism to choose from a list
* skhd - https://github.com/koekeishiya/skhd
   * Mechanism to enable global hotkeys

# Installation

Assuming that you have your requirements installed ( including your global hotkey service enabled in your init system ) you can run the following to get everything installed

```
git clone https://github.com/shiddy/Hawtkeys.git
HKD="$PWD/Hawtkeys"

if [[ "$OSTYPE" == "linux-gnu" ]]; then
    #mkdir -p $HOME/.config/somethingsomewhereidk
    #echo "cmd - 1 : $HKD/chooser.sh emoji" >> $HOME/.config/
    #echo "cmd - 2 : $HKD/chooser.sh macros" >> $HOME/.config/
    #echo "cmd - 3 : $HKD/chooser.sh sfx" >> $HOME/.config/skhd/skhdrc
elif [[ "$OSTYPE" == "darwin"* ]]; then
    mkdir -p $HOME/.config/skhd
    echo "cmd - 1 : $HKD/chooser.sh emoji" >> $HOME/.config/skhd/skhdrc
    echo "cmd - 2 : $HKD/chooser.sh macros" >> $HOME/.config/skhd/skhdrc
    echo "cmd - 3 : $HKD/chooser.sh sfx" >> $HOME/.config/skhd/skhdrc
fi
```

# Configuration

There are a few freebees thrown in that you can modify pretty easily to suit your needs.

Firstly if you need to modify any hotkeys look in
``
$HOME/.config/skhd
``
respectively and feel free to modify them to whatever you like.

If you want to copy something from a file, look at the emoji switch case section in `.../Hawtkeys/chooser.sh` You can see we cat the file into our $CHOOSE program and simply copy the output to our keyboard

What if I want labels for the choices?

Check out the macros switch case in `.../Hawtkeys/chooser.sh` You can see with a little awk we can use tabs as a delimeter in our choice file, and have an action associated with a label instead.

Finally I included something a little different to perhaps get your brain juices flowing as to how this can do a lot of different things. The sfx directory in `.../Hawtkeys/choices` contains some mp3 files, we can list the contents of that directory as ls into $CHOOSE and then play the file as the output.
