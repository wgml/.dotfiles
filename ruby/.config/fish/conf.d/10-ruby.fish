set ruby_dir (ruby -e 'print Gem.user_dir')/bin

if [ -d "$ruby_dir" ]
  set -gx PATH $ruby_dir $PATH
end
