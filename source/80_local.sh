# Sources local files for machine-specific things like paths, etc

if [ -f ~/.bashrc.local ]; then
    source ~/.bashrc.local
fi

if [ -d ~/bin ]; then
    export PATH=~/bin:$PATH
fi
