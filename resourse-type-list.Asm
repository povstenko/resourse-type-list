.386
.model flat, stdcall  ;32 bit memory model
option casemap :none  ;case sensitive

include resourse-type-list.inc

.code

start:

	invoke GetModuleHandle,NULL
	mov		hInstance,eax

    invoke InitCommonControls
	invoke DialogBoxParam,hInstance,IDD_DIALOG1,NULL,addr DlgProc,NULL
	invoke ExitProcess,0

;########################################################################
TabProc proc hWin:HWND,uMsg:UINT,wParam:WPARAM,lParam:LPARAM

	.if uMsg==WM_INITDIALOG
	.else
		mov		eax,FALSE
		ret
	.endif
	mov		eax,TRUE
	ret

TabProc endp

CountResTypeProc proc hModule, lpszType, lParam :DWORD


	or eax,1

	ret 
CountResTypeProc endp

EnumResNameProc proc hModule:DWORD,lpType:DWORD,lpName:DWORD,lParam:DWORD
;	LOCAL rsName[64]:BYTE
;	mov eax,lpName
;	shr eax,16
;	.IF ax == 0 ; якщо ім'я ресурсу число
;		lea ecx,rsName
;		mov BYTE PTR [ecx],"#"
;		inc ecx
;		invoke dwtoa,lpName,ecx
;	.ELSE
;		invoke lstrcpy,ADDR rsName,lpName
;	.endif
;	lea eax,rsName
;	
;	.IF lParam == RT_MANIFEST
;		invoke SendMessage, hListBox, LB_ADDSTRING,0, addr mb_text
;	.EndIF
	or eax,1

	ret 
EnumResNameProc endp

EnumResTypeProc proc hModule, lpszType, lParam :DWORD

	invoke EnumResourceNames,hInstance,lpszType,OFFSET EnumResNameProc,lpszType
	or eax,1

	ret 
EnumResTypeProc endp

DlgProc proc hWin:HWND,uMsg:UINT,wParam:WPARAM,lParam:LPARAM

	mov		eax,uMsg
	.if eax==WM_INITDIALOG
		
		invoke GetDlgItem, hWin, ID_TabControl
		mov hTabControl, eax
		invoke GetDlgItem, hWin, IDC_LST1
		mov hListBox, eax
		
;		invoke EnumResourceTypes, hInstance, addr CountResTypeProc, 0
		
		mov 	ts.imask, TCIF_TEXT
		mov		ts.lpReserved1,0
		mov		ts.lpReserved2,0
		mov		ts.iImage,-1
		mov		ts.lParam,0
		mov 	ts.pszText, offset szRT_MANIFEST
		mov 	ts.cchTextMax, sizeof szRT_MANIFEST
		
;		invoke SendMessage, hTabControl, TCM_INSERTITEM,0,addr ts
		invoke SendMessage, hTabControl, TCM_INSERTITEM,0,addr ts
		
		invoke CreateDialogParam, hInstance, 0, eax, addr TabProc, 0
		mov hDialog, eax
		
		invoke CreateWindowEx,NULL,addr szListBox,0,\
			WS_CHILD or WS_VISIBLE or WS_BORDER,\
			10,30,500,300,eax,0,hInstance,0
		mov hListBox,eax	
		
		invoke ShowWindow, hDialog,SW_SHOWNORMAL
;		invoke SendMessage, hTabControl, TCM_INSERTITEM,0,addr ts
		
		invoke EnumResourceTypes, hInstance, addr EnumResTypeProc, 0
		
	.elseif eax==WM_NOTIFY
		mov		eax,lParam
		mov		eax,[eax].NMHDR.code
		.if eax==TCN_SELCHANGE
			;Tab selection
			invoke SendMessage,hTabControl,TCM_GETCURSEL,0,0
			.if eax!=SelTab
				push	eax
				mov		eax,SelTab
				invoke ShowWindow,[hTabDlg+eax*4],TCM_HIDE
				pop		eax
				mov		SelTab,eax
				invoke ShowWindow,[hTabDlg+eax*4],SW_SHOWDEFAULT
			.endif
		.endif	
	.elseif eax==WM_COMMAND
		.if wParam == btn_exit
			invoke MessageBox,0,addr mb_text,addr mb_caption,MB_OKCANCEL + MB_ICONQUESTION
			cmp eax, IDOK
			jne @F
			invoke ExitProcess,0
@@:
		.endif
	.elseif eax==WM_CLOSE
		invoke EndDialog,hWin,0
	.else
		mov		eax,FALSE
		ret
	.endif
	mov		eax,TRUE
	ret

DlgProc endp

end start
