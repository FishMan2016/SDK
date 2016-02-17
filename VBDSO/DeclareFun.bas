Attribute VB_Name = "DeclareFun"
'USB
Public Declare Function dsoHTSearchDevice Lib "HTHardDll.dll" (DevInfo As Long) As Long
Public Declare Function dsoSetUSBBus Lib "HTHardDll.dll" (ByVal nDeviceIndex As Long) As Boolean
Public Declare Function dsoHTReadCalibrationData Lib "HTHardDll.dll" (ByVal nDeviceIndex As Long, pLevel As Long, ByVal nLen As Long) As Long
Public Declare Function dsoHTSetSampleRate Lib "HTHardDll.dll" (ByVal nDeviceIndex As Long, pAmpLevel As Long, ByVal nYTFormat As Long, pRelayControl As Long, pstControl As Long) As Long
Public Declare Function dsoHTSetCHAndTrigger Lib "HTHardDll.dll" (ByVal nDeviceIndex As Long, rcRelayControl As Long, ByVal Driver As Long, pstControl As Long) As Long
Public Declare Function dsoHTSetHTriggerLength Lib "HTHardDll.dll" (ByVal nDeviceIndex As Long, ByVal nBufferLen As Long, ByVal HTriggerPos As Long, ByVal nTimeDIV As Long, ByVal nYTFormat As Long) As Long

Public Declare Function dsoHTStartTrigger Lib "HTHardDll.dll" (ByVal nDeviceIndex As Long) As Long
Public Declare Function dsoHTForceTrigger Lib "HTHardDll.dll" (ByVal nDeviceIndex As Long) As Long
Public Declare Function dsoHTGetState Lib "HTHardDll.dll" (ByVal nDeviceIndex As Long) As Long
Public Declare Function dsoSDGetData Lib "HTHardDll.dll" (ByVal nDeviceInder As Long, CH1Data As Integer, CH2Data As Integer, CH3Data As Integer, CH4Data As Integer, ByRef CONTROLDATA As CONTROLDATA, ByVal InsertMode As Integer) As Long
Public Declare Function dsoHTSetCHAndTriggerVB Lib "HTHardDll.dll" (ByVal nDeviceIndex As Long, ByRef CHEnable As Integer, ByRef CHVoltDIV As Integer, ByRef CHCoupling As Integer, ByRef CHBWLimit As Integer, ByVal nTriggerSource As Integer, ByVal nTriggerFilt As Integer, ByVal nALT As Integer) As Integer

'result = dsoHTSetTrigerMode(DeviceIndex, TriggerMode, stControl.nTriggerSlope, 1)
Public Declare Function dsoHTStartCollectData Lib "HTHardDll.dll" (ByVal nDeviceIndex As Long, ByVal startcontrol As Long) As Long
Public Declare Function dsoHTSetTrigerMode Lib "HTHardDll.dll" (ByVal nDeviceIndex As Long, ByVal TriggerMode As Long, ByVal Slop As Long, ByVal TriCouple As Long) As Long
Public Declare Function dsoHTSetVTriggerLevel Lib "HTHardDll.dll" (ByVal nDeviceIndex As Long, pLevel As Long, ByVal nPos As Long, ByVal chmod As Long) As Long
Public Declare Function dsoHTSetCHPos Lib "HTHardDll.dll" (ByVal nDeviceInder As Long, pLevel As Long, ByVal CHVoltDIV As Long, ByVal CHPos As Long, ByVal CH As Long, ByVal chmod As Long) As Long
Public Declare Function dsoHTSetADC Lib "HTHardDll.dll" (ByVal nDeviceInder As Long, pRelayControl As Long, ByVal TimeDIV As Long) As Long
Public Declare Function dsoInitADCOnce Lib "HTHardDll.dll" (ByVal nDeviceInder As Long) As Long
Public Declare Function dsoHTADCCHModGain Lib "HTHardDll.dll" (ByVal nDeviceInder As Long, ByVal nCHMod As Long) As Long
Public Declare Function dsoHTSetRamAndTrigerControl Lib "HTHardDll.dll" (ByVal DeviceIndex As Long, ByVal TimeDIV As Long, ByVal CHSet As Long, ByVal nTriggerSource As Long, ByVal isPeak As Long) As Long
'…Ë÷√¥•∑¢‘¥
'Draw
Public Declare Function HTDrawGrid Lib "HTDisplayDll.dll" (ByVal hDC As Long, ByVal nLeft As Long, ByVal nTop As Long, ByVal nRight As Long, ByVal nBottom As Long, ByVal nHoriGridNum As Long, ByVal nVertGridNum As Long, ByVal nBright As Long, ByVal IsGrid As Long) As Long
Public Declare Function HTDrawWaveInYTVB Lib "HTDisplayDll.dll" (ByVal hDC As Long, ByVal Left As Long, ByVal Top As Long, ByVal Right As Long, ByVal Bottom As Long, ByVal R As Integer, ByVal G As Integer, ByVal B As Integer, ByVal nDisTye As Integer, ByRef pData As Integer, ByVal nLen As Long, ByVal nDisLen As Long, ByVal CenterData As Long, ByVal nDisLeverPos As Integer, ByVal Horizontal As Double, ByVal Vertical As Double, ByVal YTFormat As Integer, ByVal AlreadLen As Long) As Long

