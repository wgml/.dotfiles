if [ -d $HOME/.pyenv ]

  set -gx PYENV_ROOT $HOME/.pyenv
  set -gx PATH $PYENV_ROOT/bin $PATH

  pyenv init - | source

end
