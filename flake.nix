{
  outputs = {self}: {
    zshPlugin = {
      name = "zsh-johnnydecimal";
      file = "johnnydecimal.zsh";
      src = ./.;
    };
  };
}
