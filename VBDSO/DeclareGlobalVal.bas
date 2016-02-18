Attribute VB_Name = "DeclareGlobalVal"
Type RelayControl
    bCHEnable(3) As Integer
    nCHVoltDIV(3) As Integer
    nCHCoupling(3) As Integer
    bCHBWLimit(3) As Integer
    nTrigSource As Integer
    bTrigFilt As Integer
    nALT As Integer
End Type

Type CONTROLDATA
        
    nCHSet As Integer
    nTimeDIV As Integer
    nTriggerSource As Integer
    nHTriggerPos As Integer
    nVTriggerPos As Integer
    nTriggerSlope As Integer
    nBufferLen As Long
    nReadDataLen As Long
    nAlreadyReadLen As Long
    nALT As Integer
    nETSOpen As Integer
    nDriverCode As Integer
    nLastAddress As Long
End Type

Type COLORREF
    R As Integer
    G As Integer
    B As Integer
End Type

Type RECT
    Left As Integer
    Top As Integer
    Right As Integer
    Bottom As Integer
End Type
'''''''''''''

Public DeviceNum As Long
Public DeviceIndex As Long
Public CH1SrcData(4096) As Integer
Public CH2SrcData(4096) As Integer
Public CH3SrcData(4096) As Integer
Public CH4SrcData(4096) As Integer
Public CH1Color As COLORREF
Public CH2Color As COLORREF
Public CH3Color As COLORREF
Public CH4Color As COLORREF
Public CalLevel(578) As Integer
Public TimeDIV As Long
Public YTFormat As Long
Public stControl As CONTROLDATA
Public rcRelayControl As RelayControl
Public TriggerMode As Long
Public TriggerSweep As Long
Public TriggerSlope As Long
Public LeverPos(3) As Long
Public ReadOK As Long
Public StartNew As Boolean
Public DisLen As Long
Public Collect As Integer
Public pAmpLevel(578) As Integer
