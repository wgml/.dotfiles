if [ -d $HOME/.pyenv ]

  set -gx PATH "$HOME/.jenv/bin" $PATH

  jenv init - | source

end
