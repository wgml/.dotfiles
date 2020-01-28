for directory in ~/local-root/*
  if [ -d $directory/bin ]
    set -gx PATH "$directory/bin" $PATH
  end

  if [ -d $directory/usr/local/bin ]
    set -gx PATH "$directory/usr/local/bin" $PATH
  end
end
