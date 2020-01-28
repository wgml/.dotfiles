set rust_dir "$HOME/.cargo/bin"

if [ -d "$rust_dir" ]
  set -gx PATH $rust_dir $PATH
end
