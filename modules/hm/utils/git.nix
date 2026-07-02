{ secrets, ... }:
{
  programs.git = {
    enable = true;

    settings = {
      core = {
        pager = "delta";
      };
      interactive = {
        diffFilter = "delta --color-only";
      };
      delta = {
        navigate = true;
        side-by-side = true;
        line-numbers = true;
        syntax-theme = "Catppuccin Mocha";
        hyperlinks = true;
      };
      merge = {
        conflictstyle = "zdiff3";
      };
      diff = {
        colorMoved = "default";
      };
      user = {
        inherit (secrets.git.personal) name;
        inherit (secrets.git.personal) email;
      };
    };

    includes = [
      {
        condition = "hasconfig:remote.*.url:git@${secrets.git.work.github_host}:**/**";
        path = "~/.config/git/work";
      }
      {
        condition = "hasconfig:remote.*.url:git@${secrets.git.work.gitlab_host}:**/**";
        path = "~/.config/git/work";
      }
    ];
  };

  xdg.configFile."git/work".text = ''
    [user]
      name = ${secrets.git.work.name}
      email = ${secrets.git.work.email}
  '';
}
