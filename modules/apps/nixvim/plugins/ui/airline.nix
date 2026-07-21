{
  plugins.airline = {
    enable = true;
    settings = {
      # exclude_filetypes = [ "snacks_layout_box" ];
      theme = "catppuccin";
      symbols = {
        branch = "";
        colnr = " ℅:";
        readonly = "";
        linenr = " :";
        maxlinenr = "☰ ";
        # dirty = "⚡";
      };
      right_sep = "";
      left_sep = "";
      section_a = " %{airline#util#wrap(airline#parts#mode(), 0)} ";
      section_b = " %{airline#extensions#branch#get_head()} ";
      section_c = "  %f ";
      section_x = " %{airline#extensions#hunks#get_hunks()} ";
      section_y = "  %Y ";
      section_z = "  %l/%L · ℅ %c ";
    };
  };
}
