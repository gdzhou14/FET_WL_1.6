// cs_USB DLL Universal Header File


// WARNING: This file must maintain DLL compatibility with
// C/C++, Visual Basic, LabVIEW and MATLAB, whether or not the
// client includes this file directly.


// declare CS_USB_API function prefix depending on whether this
// file is used as import or export
#ifdef CS_USB_EXPORTS	// declared only during DLL build
#define CS_USB_API		// see cs_USB.def for exports
#else
#define CS_USB_API __declspec(dllimport)	// declare as import
#endif

// declare calling convention--this must be __stdcall
// for VB compatibility
#define CCONV __stdcall

// exported functions must use C-style (undecorated) names
// for C, VB, LV, and MATLAB compatibility
#ifdef __cplusplus
extern "C" {
#endif

CS_USB_API int CCONV cs_Open (unsigned long serialNo);
CS_USB_API long CCONV cs_Close (int deviceID);
CS_USB_API long CCONV cs_Write (int deviceID, char* statement);
CS_USB_API char* CCONV cs_Read (int deviceID);
CS_USB_API char* CCONV cs_ReadNowait (int deviceID);
CS_USB_API long CCONV cs_GetLastError (void);
CS_USB_API char* CCONV cs_GetDLLVersion (void);
CS_USB_API void CCONV cs_RescanBus (void);

// end previous name-decoration containment block
#ifdef __cplusplus
}
#endif