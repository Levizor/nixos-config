{
  programs.oh-my-posh = {
    enable = true;
    enableZshIntegration = true;
    settings = builtins.fromJSON ''
      {
        "$schema": "https://raw.githubusercontent.com/JanDeDobbeleer/oh-my-posh/main/themes/schema.json",
        "blocks": [
          {
            "alignment": "left",
            "segments": [
              {
                "foreground": "#5ef1ff",
                "style": "plain",
                "template": "<#5ea1ff>\u250f[</>{{ .UserName }}<#5ea1ff>]</>",
                "type": "session"
              },
              {
                "foreground": "#bd5eff",
                "properties": {
                  "fetch_stash_count": true,
                  "fetch_status": true,
                  "fetch_upstream_icon": true
                },
                "style": "plain",
                "template": "<#5ea1ff>--[</>{{ .HEAD }}{{if .BranchStatus }} {{ .BranchStatus }}{{ end }}{{ if .Working.Changed }}<#5eff6c> \u25cf </>{{ end }}{{ if .Staging.Changed }}<#5ef1ff> \u25cf </>{{ end }}<#5ea1ff>]</>",
                "type": "git"
              },
              {
                "foreground": "#bd5eff",
                "style": "plain",
                "template": "<#5ea1ff>--[</>{{.Profile}}{{if .Region}}@{{.Region}}{{end}}<#5ea1ff>]</>",
                "type": "aws"
              },
              {
                "foreground": "#bd5eff",
                "style": "plain",
                "template": "<#5ea1ff>--[</>{{.Context}}{{if .Namespace}} :: {{.Namespace}}{{end}}<#5ea1ff>]</>",
                "type": "kubectl"
              },
              {
                "foreground": "#ffffff",
                "style": "plain",
                "template": "<#5ea1ff>[</>\uf0e7<#5ea1ff>]</>",
                "type": "root"
              },
              {
                "foreground": "#ffffff",
                "style": "plain",
                "template": "<#5ea1ff>[x</>{{ reason .Code }}<#5ea1ff>]</>",
                "type": "status"
              }
            ],
            "type": "prompt"
          },
          {
            "alignment": "left",
            "newline": true,
            "segments": [
              {
                "foreground": "#5ef1ff",
                "properties": {
                  "style": "full"
                },
                "style": "plain",
                "template": "<#5ea1ff>\u2516[</>{{ .Path }}<#5ea1ff>]</>",
                "type": "path"
              }
            ],
            "type": "prompt"
          },
          {
            "alignment": "left",
            "newline": true,
            "segments": [
              {
                "foreground": "#5ea1ff",
                "style": "plain",
                "template": " \ue602 ",
                "type": "text"
              }
            ],
            "type": "prompt"
          }
        ],
        "final_space": true,
        "version": 3,

        "transient_prompt": {
          "background": "transparent",
          "foreground": "#ffffff",
          "template": "> "
        }
      }
    '';
  };
}
