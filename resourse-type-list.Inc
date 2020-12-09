
include windows.inc
include kernel32.inc
include user32.inc
include Comctl32.inc
include shell32.inc
include masm32.inc

includelib kernel32.lib
includelib user32.lib
includelib Comctl32.lib
includelib shell32.lib
includelib masm32.lib

DlgProc			PROTO	:HWND,:UINT,:WPARAM,:LPARAM

.const

;Res\resourse-type-listRes.rc
MANIFEST						equ 24

;resourse-type-list.dlg
IDD_DIALOG1						equ 101
ID_TabControl					equ 1002
btn_exit						equ 1001
IDC_LST1						equ 1003

;resourse-type-list.Rc

;#########################################################################

.data
mb_caption db 'Exit',0
mb_text db 'Do you really want to exit programm?',0
szListBox db 'ListBox',0


;tab text
szRT_ACCELERATOR		BYTE				"RT_ACCELERATOR",0
szRT_ANICURSOR			BYTE				"RT_ANICURSOR",0
szRT_ANIICON			BYTE				"RT_ANIICON",0
szRT_AVI				BYTE				"AVI",0
szRT_WAVE				BYTE				"WAVE",0
szRT_BITMAP				BYTE				"RT_BITMAP",0
szRT_CURSOR				BYTE				"RT_CURSOR",0
szRT_DIALOG				BYTE				"RT_DIALOG",0
szRT_DLGINCLUDE			BYTE				"RT_DLGINCLUDE",0
szRT_FONT				BYTE				"RT_FONT",0
szRT_FONTDIR			BYTE				"RT_FONTDIR",0
szRT_GROUP_CURSOR		BYTE				"RT_GROUP_CURSOR",0
szRT_GROUP_ICON			BYTE				"RT_GROUP_ICON",0
szRT_HTML				BYTE				"HTML",0
szRT_IMAGE				BYTE				"IMAGE",0
szRT_MANIFEST			BYTE				"RT_MANIFEST",0
szRT_MENU				BYTE				"RT_MENU",0
szRT_MESSAGETABLE		BYTE				"RT_MESSAGETABLE",0
szRT_PLUGPLAY			BYTE				"RT_PLUGPLAY",0
szRT_RCDATA				BYTE				"RT_RCDATA",0
szRT_STRING				BYTE				"RT_STRING",0
szRT_VERSION			BYTE				"RT_VERSION",0
szRT_VXD				BYTE				"VXD",0

.data?
hTabs dd 25 dup(?)	;array of tabs handle
hInstance			dd ?
hListBox 			dd ?
hTabControl			dd ?
hDialog				dd ?
ts				TC_ITEM <?>

;#########################################################################
