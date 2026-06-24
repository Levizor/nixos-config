{ inputs, ... }:
{
  flake.nixosModules.nvim =
    { pkgs, system, ... }:
    let
      devNvim = pkgs.runCommand "nvim" { } ''
        mkdir -p $out/bin
        ln -s ${inputs.nvim.packages.${system}.dev}/bin/nvim-dev $out/bin/nvim
      '';
      nvim = inputs.nvim.packages.${system}.default;
    in
    {
      environment = {
        systemPackages = with pkgs; [
          vim
          devNvim
          # nvim
        ];

        variables.EDITOR = "nvim";
      };

      programs.nano.enable = false;
    };
}
