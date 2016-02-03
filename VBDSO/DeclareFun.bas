Attribute VB_Name = "DeclareFun"
'USB
Public Declare Function dsoHTSearchDevice Lib "HTHardDll.dll" (DevInfo As Long) As Long
Public Declare Function dsoSetUSBBus Lib "HTHardDll.dll" (ByVal nDeviceIndex As Long) As Boolean  ' add by yt 2011/3/18
Public Declare Function dsoHTReadCalibrationData Lib "HTHardDll.dll" (ByVal nDeviceIndex As Long, pLevel As Long, ByVal nLen As Long) As Long
Public Declare Function dsoHTSetSampleRate Lib "HTHardDll.dll" (ByVal nDeviceIndex As Long, ByVal nTimeDIV As Long, ByVal nYTFormat As Long) As Long
Public Declare Function dsoHTSetCHAndTrigger Lib "HTHardDll.dll" (ByVal nDeviceIndex As Long, ByRef rcRelayControl As RelayControl) As Long
Public Declare Function dsoHTSetTriggerAndSyncOutput Lib "HTHardDll.dll" (ByVal nDeviceIndex As Long, ByVal nTriggerMode As Long, ByVal nTriggerSlope As Long, ByVal nPWCondition As Long, ByVal nPW As Long, ByVal nStandard As Long, ByVal nSync As Long, ByVal nLineNum As Long, ByVal nSync As Long) As Long
Public Declare Function dsoHTSetCHPos Lib "HTHardDll.dll" (ByVal nDeviceIndex As Long, pLevel As Long, ByVal nVoltDIV As Long, ByVal nPos As Long, ByVal nCH As Long) As Long
Public Declare Function dsoHTSetVTriggerLevel Lib "HTHardDll.dll" (ByVal nDeviceIndex As Long, pLevel As Long, ByVal nPos As Long) As Long
Public Declare Function dsoHTSetHTriggerLength Lib "HTHardDll.dll" (ByVal nDeviceIndex As Long, ByVal nBufferLen As Long, ByVal HTriggerPos As Long, ByVal nTimeDIV As Long, ByVal nYTFormat As Long) As Long
Public Declare Function dsoHTStartCollectData Lib "HTHardDll.dll" (ByVal nDeviceIndex As Long) As Long
Public Declare Function dsoHTStartTrigger Lib "HTHardDll.dll" (ByVal nDeviceIndex As Long) As Long
Public Declare Function dsoHTForceTrigger Lib "HTHardDll.dll" (ByVal nDeviceIndex As Long) As Long
Public Declare Function dsoHTGetState Lib "HTHardDll.dll" (ByVal nDeviceIndex As Long) As Long
Public Declare Function dsoSDGetData Lib "HTHardDll.dll" (ByVal nDeviceInder As Long, CH1Data As Integer, CH2Data As Integer, CH3Data As Integer, CH4Data As Integer, ByRef CONTROLDATA As CONTROLDATA, ByVal InsertMode As Integer) As Long
Public Declare Function dsoHTSetCHAndTriggerVB Lib "HTHardDll.dll" (ByVal nDeviceIndex As Long, ByRef CHEnable As Integer, ByRef CHVoltDIV As Integer, ByRef CHCoupling As Integer, ByRef CHBWLimit As Integer, ByVal nTriggerSource As Integer, ByVal nTriggerFilt As Integer, ByVal nALT As Integer) As Integer

'Draw
Public Declare Function HTDrawGrid Lib "HTDisplayDll.dll" (ByVal hDC As Long, ByVal nLeft As Long, ByVal nTop As Long, ByVal nRight As Long, ByVal nBottom As Long, ByVal nHoriGridNum As Long, ByVal nVertGridNum As Long, ByVal nBright As Long, ByVal IsGrid As Long) As Long
Public Declare Function HTDrawWaveInYTVB Lib "HTDisplayDll.dll" (ByVal hDC As Long, ByVal Left As Long, ByVal Top As Long, ByVal Right As Long, ByVal Bottom As Long, ByVal R As Integer, ByVal G As Integer, ByVal B As Integer, ByVal nDisTye As Integer, ByRef pData As Integer, ByVal nLen As Long, ByVal nDisLen As Long, ByVal CenterData As Long, ByVal nDisLeverPos As Integer, ByVal Horizontal As Double, ByVal Vertical As Double, ByVal YTFormat As Integer, ByVal AlreadLen As Long) As Long

'LAN /WIFI
Public Declare Function dsoLANReadCalibrationData Lib "HTLANDll.dll" (ByVal nDeviceIndex As Long, pLevel As Long, ByVal nLen As Long) As Long
Public Declare Function dsoLANSetSampleRate Lib "HTLANDll.dll" (ByVal nDeviceIndex As Long, ByVal nTimeDIV As Long, ByVal nYTFormat As Long) As Long
Public Declare Function dsoLANSetCHAndTrigger Lib "HTLANDll.dll" (ByVal nDeviceIndex As Long, ByRef rcRelayControl As RelayControl) As Long
Public Declare Function dsoLANSetTriggerAndSyncOutput Lib "HTLANDll.dll" (ByVal nDeviceIndex As Long, ByVal nTriggerMode As Long, ByVal nTriggerSlope As Long, ByVal nPWCondition As Long, ByVal nPW As Long, ByVal nStandard As Long, ByVal nSync As Long, ByVal nLineNum As Long, ByVal nSync As Long) As Long
Public Declare Function dsoLANSetCHPos Lib "HTLANDll.dll" (ByVal nDeviceIndex As Long, pLevel As Long, ByVal nVoltDIV As Long, ByVal nPos As Long, ByVal nCH As Long) As Long
Public Declare Function dsoLANSetVTriggerLevel Lib "HTLANDll.dll" (ByVal nDeviceIndex As Long, pLevel As Long, ByVal nPos As Long) As Long
Public Declare Function dsoLANSetHTriggerLength Lib "HTLANDll.dll" (ByVal nDeviceIndex As Long, ByVal nBufferLen As Long, ByVal HTriggerPos As Long, ByVal nTimeDIV As Long, ByVal nYTFormat As Long) As Long
Public Declare Function dsoLANStartCollectData Lib "HTLANDll.dll" (ByVal nDeviceIndex As Long) As Long
Public Declare Function dsoLANStartTrigger Lib "HTLANDll.dll" (ByVal nDeviceIndex As Long) As Long
Public Declare Function dsoLANForceTrigger Lib "HTLANDll.dll" (ByVal nDeviceIndex As Long) As Long
Public Declare Function dsoLANGetState Lib "HTLANDll.dll" (ByVal nDeviceIndex As Long) As Long
Public Declare Function dsoSDLANGetData Lib "HTLANDll.dll" (ByVal nDeviceInder As Long, CH1Data As Integer, CH2Data As Integer, CH3Data As Integer, CH4Data As Integer, ByRef CONTROLDATA As CONTROLDATA, ByVal InsertMode As Integer) As Long
Public Declare Function dsoLANSetCHAndTriggerVB Lib "HTLANDll.dll" (ByVal nDeviceIndex As Long, ByRef CHEnable As Integer, ByRef CHVoltDIV As Integer, ByRef CHCoupling As Integer, ByRef CHBWLimit As Integer, ByVal nTriggerSource As Integer, ByVal nTriggerFilt As Integer, ByVal nALT As Integer) As Integer
Public Declare Function dsoLANInitSocket Lib "HTLANDll.dll" (ByVal nDeviceIndex As Long, ByRef ip As Integer, ByVal port As Long) As Long
