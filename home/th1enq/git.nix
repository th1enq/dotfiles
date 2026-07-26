{
  programs.git = {
    enable = true;
    settings = {
      user = {
        name = "th1enq";
        email = "thienchy3305@gmail.com";
      };

      credential = {
        helper = "store";
      };
    };
  };
}
