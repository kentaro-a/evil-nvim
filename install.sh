# install deno
curl -fsSL https://deno.land/install.sh | sh
# export DENO_INSTALL="/Users/kentaro-a/.deno"
# export PATH="$DENO_INSTALL/bin:$PATH"

# install vim-plug
sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
	       https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
