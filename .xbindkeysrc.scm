;(xbindkey '("XF86AudioMute") "amixer sset Master toggle; pulseaudio-ctl mute")
(xbindkey '("XF86AudioMute") "pulseaudio-ctl mute")
(xbindkey '("XF86AudioMicMute") "pulseaudio-ctl mute-input")
(xbindkey '("XF86AudioRaiseVolume") "amixer set Master 2dB+ unmute; pulseaudio-ctl up")
(xbindkey '("XF86AudioLowerVolume") "amixer set Master 2dB- unmute; pulseaudio-ctl down")
(xbindkey '("XF86AudioNext") "mpc next")
(xbindkey '("XF86AudioPrev") "mpc prev")
(xbindkey '("XF86AudioStop") "mpc stop")
(xbindkey '("XF86AudioPlay") "mpc toggle")
(xbindkey '("XF86Launch1") "termite -e bash")
;(xbindkey '("XF86Back") "H")
;(xbindkey '("XF86Forward") "F")
