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
EnumResTypeProc proc hModule, lpszType, lParam :DWORD

;	invoke SendMessage, hListBox, LB_ADDSTRING,0, addr mb_text
	
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
		
;		invoke EnumResourceTypes, 0, addr EnumResTypeProc, 0
		
		mov 	ts.imask, TCIF_TEXT
		mov		ts.lpReserved1,0
		mov		ts.lpReserved2,0
		mov		ts.iImage,-1
		mov		ts.lParam,0
		mov 	ts.pszText, offset szRT_ACCELERATOR
		mov 	ts.cchTextMax, sizeof szRT_ACCELERATOR
		invoke SendMessage, hTabControl, TCM_INSERTITEM,0,addr ts
		
		
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
