# .bash_profile

if [ -f ~/.profile ]; then
    . ~/.profile
fi

# Get the aliases and functions
if [ -f ~/.bashrc ]; then
    . ~/.bashrc
fi

# Added by `rbenv init` on Sat Aug  9 21:48:03 -03 2025
eval "$(rbenv init - --no-rehash bash)"
. <(asdf completion bash)
