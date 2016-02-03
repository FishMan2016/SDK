Attribute VB_Name = "Start"
Sub Main()
    Dim DevInfo(63) As Long
    Dim result As Long
    Dim ip(4) As Integer
    
   
    InitializeVariables
    If ComType = 0 Then
        DeviceNum = dsoHTSearchDevice(DevInfo(0))
    Else
        ip(0) = 192
        ip(1) = 168
        ip(2) = 1
        ip(3) = 2
        result = dsoLANInitSocket(DeviceIndex, ip(0), 50000)
        DeviceNum = 1
    End If
    If DeviceNum = 0 Then
        MsgBox ("DSO not found!")
        End
    End If
    
    InitHard
    MainForm.Visible = True
    
    MainForm.GetDataLoop.Enabled = True
    
End Sub

Public Sub InitializeVariables()
Dim i As Long
    i = 0
    ComType = 0 'USB deault
    DeviceNum = 0
    DeviceIndex = 0
    
    LeverPos(0) = 64
    LeverPos(1) = 96
    LeverPos(2) = 160
    LeverPos(3) = 192
    TimeDIV = 12
    YTFormat = 0
    stControl.nCHSet = 15
    stControl.nTimeDIV = 12
    stControl.nTriggerSource = 0
    stControl.nHTriggerPos = 50
    stControl.nVTriggerPos = LeverPos(0)
    stControl.nTriggerSlope = 0
    stControl.nBufferLen = 10240
    stControl.nReadDataLen = 10240
    stControl.nAlreadyReadLen = 10240
    DisLen = 10000
    stControl.nALT = 0
    For i = 0 To 3
        rcRelayControl.bCHEnable(i) = 1
        rcRelayControl.nCHVoltDIV(i) = 6
        rcRelayControl.nCHCoupling(i) = 1
        rcRelayControl.bCHBWLimit(i) = 0
   Next i

    rcRelayControl.nTrigSource = stControl.nTriggerSource
    rcRelayControl.bTrigFilt = 0
    rcRelayControl.nALT = stControl.nALT
    TriggerMode = 0
    TriggerSlope = 0
    TriggerSweep = 0
    
    ReadOK = 0
    StartNew = True
    ForceTriggerCnt = 0
    
End Sub


Public Sub InitHard()
    Dim i As Long
    Dim result As Long
    
    m_nDeviceIndex = 0
    If ComType = 0 Then
        result = dsoSetUSBBus(DeviceIndex) ' add by yt 2011/3/18 This function must be called first to initialize device
        result = dsoHTReadCalibrationData(DeviceIndex, CalLevel(0), 72)
        result = dsoHTSetSampleRate(DeviceIndex, TimeDIV, YTFormat)
        result = dsoHTSetCHAndTriggerVB(DeviceIndex, rcRelayControl.bCHEnable(0), rcRelayControl.nCHVoltDIV(0), rcRelayControl.nCHCoupling(0), rcRelayControl.bCHBWLimit(0), rcRelayControl.nTrigSource, rcRelayControl.bTrigFilt, rcRelayControl.nALT)
        result = dsoHTSetTriggerAndSyncOutput(DeviceIndex, TriggerMode, TriggerSlope, 0, 2, 0, 0, 1, 0)
        For i = 0 To 3
            result = dsoHTSetCHPos(DeviceIndex, CalLevel(0), rcRelayControl.nCHVoltDIV(i), 255 - LeverPos(i), i)
        Next i
        result = dsoHTSetVTriggerLevel(DeviceIndex, CalLevel(0), 255 - LeverPos(0))
        result = dsoHTSetHTriggerLength(DeviceIndex, stControl.nBufferLen, stControl.nHTriggerPos, TimeDIV, YTFormat)
    Else
        result = dsoLANReadCalibrationData(DeviceIndex, CalLevel(0), 72)
        result = dsoLANSetSampleRate(DeviceIndex, TimeDIV, YTFormat)
        result = dsoLANSetCHAndTriggerVB(DeviceIndex, rcRelayControl.bCHEnable(0), rcRelayControl.nCHVoltDIV(0), rcRelayControl.nCHCoupling(0), rcRelayControl.bCHBWLimit(0), rcRelayControl.nTrigSource, rcRelayControl.bTrigFilt, rcRelayControl.nALT)
        result = dsoLANSetTriggerAndSyncOutput(DeviceIndex, TriggerMode, TriggerSlope, 0, 2, 0, 0, 1, 0)
        For i = 0 To 3
            result = dsoLANSetCHPos(DeviceIndex, CalLevel(0), rcRelayControl.nCHVoltDIV(i), 255 - LeverPos(i), i)
        Next i
        result = dsoLANSetVTriggerLevel(DeviceIndex, CalLevel(0), 255 - LeverPos(0))
        result = dsoLANSetHTriggerLength(DeviceIndex, stControl.nBufferLen, stControl.nHTriggerPos, TimeDIV, YTFormat)
    End If
End Sub


Public Sub CollectData()
    Dim nState As Integer
    Dim result As Long
    If (StartNew) Then
        If ComType = 0 Then
        result = dsoHTStartCollectData(DeviceIndex)
        result = dsoHTStartTrigger(DeviceIndex)
        Else
        result = dsoLANStartCollectData(DeviceIndex)
        result = dsoLANStartTrigger(DeviceIndex)
        End If
        ForceTriggerCnt = 0
        StartNew = False
   End If
   If ComType = 0 Then
    nState = dsoHTGetState(DeviceIndex)
    Else
    nState = dsoLANGetState(DeviceIndex)
    End If
    If nState = 1 Then
        If TriggerSweep = 0 Then
            If ComType = 0 Then
            result = dsoHTStartTrigger(DeviceIndex)
            Else
            result = dsoLANStartTrigger(DeviceIndex)
            End If
            ForceTriggerCnt = ForceTriggerCnt + 1
            If ForceTriggerCnt > 6 Then
                If ComType = 0 Then
                result = dsoHTForceTrigger(DeviceIndex)
                Else
                result = dsoLANForceTrigger(DeviceIndex)
                End If
                ForceTriggerCnt = 0
            End If
        End If
    ElseIf nState = 7 Then
        ReadData
        ForceTriggerCnt = 0
        StartNew = True
            
    End If
End Sub

Public Sub ReadData()
    Dim i As Long
    
    Dim result As Integer
    Dim CH1ReadData(10239) As Integer
    Dim CH2ReadData(10239) As Integer
    Dim CH3ReadData(10239) As Integer
    Dim CH4ReadData(10239) As Integer
    
    If ComType = 0 Then
    result = dsoSDGetData(DeviceIndex, CH1ReadData(0), CH2ReadData(0), CH3ReadData(0), CH4ReadData(0), stControl, 2)
    Else
    result = dsoSDLANGetData(DeviceIndex, CH1ReadData(0), CH2ReadData(0), CH3ReadData(0), CH4ReadData(0), stControl, 2)
    End If
    If result = 1 Then
        For i = 0 To stControl.nReadDataLen - 1
            CH1SrcData(i) = CH1ReadData(i) - (255 - LeverPos(0))
            CH2SrcData(i) = CH2ReadData(i) - (255 - LeverPos(1))
            CH3SrcData(i) = CH3ReadData(i) - (255 - LeverPos(2))
            CH4SrcData(i) = CH4ReadData(i) - (255 - LeverPos(3))
        Next i
        
    End If
    
End Sub



























