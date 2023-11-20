-- vim:ft=haskell
Config { -- font = "-*-Fixed-Bold-R-Normal-*-13-*-*-*-*-*-*-*"
        font = "xft:FreeMono:Bold:size=10,JetBrainsMono Nerd Font:bold:size=10"
        -- , additionalFonts = [ "xft:Bitstream Vera Sans Mono:size=8:antialias=true", "FontAwesome:size=10", "Source Code Pro:size=10:regular:antialias=true"]
        , additionalFonts = ["FontAwesome:size=10", "Source Code Pro:size=10:regular:antialias=true"]
        , borderColor = "black"
        , border = TopB
        , bgColor = "black"
        , fgColor = "grey"
        , position = TopW L 100
        -- , position = Static { xpos = 0, ypos = 0, width = 1346, height = 20 }
        , commands = [ Run Weather "CYVR" ["-t","<tempC>C","-L","18","-H","25","--normal","green","--high","red","--low","lightblue"] 36000
                        -- , Run Network "eth0" ["-L","0","-H","32","--normal","green","--high","red"] 10
                        -- , Run Network "eth1" ["-L","0","-H","32","--normal","green","--high","red"] 10
                        , Run Cpu ["-L","25","-H","50","--normal","green","--high","red"] 10
                        , Run Memory ["-t","Mem: <usedratio>%"] 10
                        , Run Swap ["-t","Swp: <used>M"] 10
                        , Run Com "uname" ["-s","-r"] "" 36000
                        , Run Date "%a %b %_d %Y %H:%M:%S" "date" 10
		        , Run Mpris2 "spotify" ["-t", "<artist> - [<tracknumber> - <album>] <title>"] 10
                        , Run StdinReader
                        ]
        , sepChar = "%"
        , alignSep = "}{"
        , template = "%StdinReader% } %cpu% | %memory% * %swap%    %mpris2% { %uname% | <fc=#ee9a00>%date%</fc> "
        }
