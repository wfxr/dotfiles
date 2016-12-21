<!`::Suspend

<!h::Send {Left}
<!j::Send {Down}
<!k::Send {Up}
<!l::Send {Right}
<!b::Send ^{Left}
<!w::Send ^{Right}
<!1::Send {F1}
<!2::Send {F2}
<!3::Send {F3}
<!4::Send {F4}
<!5::Send {F5}
<!6::Send {F6}
<!7::Send {F7}
<!8::Send {F8}
<!9::Send {F9}
<!0::Send {F10}
<!-::Send {F11}
<!=::Send {F12}

<^1::Send ^{F1}
<^2::Send ^{F2}
<^3::Send ^{F3}
<^4::Send ^{F4}
<^5::Send ^{F5}
<^6::Send ^{F6}
<^7::Send ^{F7}
<^8::Send ^{F8}
<^9::Send ^{F9}
<^0::Send ^{F10}
<^-::Send ^{F11}
<^=::Send ^{F12}

; Vim
<^[::Send {Esc}
; Ctrl & n::Send {Down}
; Ctrl & p::Send {Up}
<^e::Send {End}
<^w::Send ^{BS}
<^h::Send {BS}
<^j::Send {Enter}
<^Esc::Send !{F4}	; 需要~前缀防止拦截Ctrl + Shift + Esc组合
<^q::Send ^w


^!t::Run cmd.exe    ; 控制台

LWin & v::Run S:\Tools\Vim\vim80\gvim.exe  ; Vim
LWin & w::Run www.google.com/ncr  ; Chrome
LWin & q::Run C:\Program Files (x86)\Tencent\QQ\Bin\QQScLauncher.exe  ; QQ
LWin & t::Run cmd.exe    ; 控制台
LWin & c::Run calc.exe   ; 计算器
LWin & h::Run %A_MyDocuments%  ; 我的文档
LWin & f::Run S:\Tools\Everything\Everything.exe  ; Everything
LWin & n::Run S:\Tools\NetEase CloudMusic\cloudmusic.exe	;网易云音乐

; 声音控制
LWin & WheelUp::Send {Volume_Up 4}	; 增大音量
LWin & k::Send {Volume_Up}
LWin & WheelDown::Send {Volume_Down 4}  ; 减小音量
LWin & j::Send {Volume_Down}
LWin & m::Send {Volume_Mute}		; 静音

; 网易云音乐
; LWin & XButton2::Run S:\Tools\NetEase CloudMusic\cloudmusic.exe
; LWin & XButton1::Send ^!p		; 暂停
LWin & XButton2::Send ^!{Left}		; 上一曲
LWin & XButton1::Send ^!{Right}		; 下一曲

; # --- Win
; ! --- Alt
; ^ --- Ctrl
; + --- Shift
