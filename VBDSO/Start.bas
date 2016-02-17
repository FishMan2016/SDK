Attribute VB_Name = "Start"

Sub Main()
    Dim DevInfo(63) As Long
    Dim result As Long
    Dim ip(4) As Integer
    InitializeVariables '初始化变量
    DeviceNum = dsoHTSearchDevice(DevInfo(0))
    If DeviceNum = 0 Then
        MsgBox ("DSO not found!")
        End
    End If
    InitHard '初始化硬件
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
    stControl.nBufferLen = 4096
    stControl.nReadDataLen = 4096
    stControl.nAlreadyReadLen = 0
    DisLen = 2500
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
    'Dim i As Long
   ' Dim result As Long
   ' DeviceIndex = 0
   ' result = dsoSetUSBBus(DeviceIndex)
   ' result = dsoHTReadCalibrationData(DeviceIndex, CalLevel(0), 72)
   ' result = dsoHTSetSampleRate(DeviceIndex, TimeDIV, YTFormat)
   ' result = dsoHTSetCHAndTriggerVB(DeviceIndex, rcRelayControl.bCHEnable(0), rcRelayControl.nCHVoltDIV(0), rcRelayControl.nCHCoupling(0), rcRelayControl.bCHBWLimit(0), rcRelayControl.nTrigSource, rcRelayControl.bTrigFilt, rcRelayControl.nALT)
   ' result = dsoHTSetTriggerAndSyncOutput(DeviceIndex, TriggerMode, TriggerSlope, 0, 2, 0, 0, 1, 0)
   ' For i = 0 To 3
     '   result = dsoHTSetCHPos(DeviceIndex, CalLevel(0), rcRelayControl.nCHVoltDIV(i), 255 - LeverPos(i), i)
    'Next i
    'result = dsoHTSetVTriggerLevel(DeviceIndex, CalLevel(0), 255 - LeverPos(0))
    'result = dsoHTSetHTriggerLength(DeviceIndex, stControl.nBufferLen, stControl.nHTriggerPos, TimeDIV, YTFormat)
    
    DeviceIndex = 0
    Dim i As Integer
    Dim nVolt As Integer
    dsoSetUSBBus (DeviceIndex)
    dsoInitADCOnce (DeviceIndex)
    dsoHTADCCHModGain(DeviceIndex,4)
    dsoHTReadCalibrationData(DeviceIndex,CalLevel(0),577)'读取0电平校准数据
    if(CalLevel(576)!=64463) then
        For i = 0 To 576
            nVolt = (i Mod ZEROCALI_PER_CH_LEN) / ZEROCALI_PER_VOLT_LEN
            If (nVolt = 5 Or nVolt = 8 Or nVolt = 11) Then
                Dim nTemp As Integer
                nTemp=i Mod ZEROCALI_PER_CH_LEN) Mod ZEROCALI_PER_VOLT_LEN
                If nTemp = 0 Then
                    CalLevel(i) = 16602
                else if nTemp=1 then
                    CalLevel(i) = 60111
                else if nTemp=2 then
                    CalLevel(i) = 17528
                else if nTemp=3 then
                    CalLevel(i) = 59201
                else if nTemp=4 then
                    CalLevel(i) = 17710
                else if nTemp=5 then
                    CalLevel(i) = 58900
                Else
                    CalLevel(i) = 0
                End If
            End If
        Next i
    End If
    dsoHTSetSampleRate(DeviceIndex,pAmpLevel(0),YTFormat,VarPtr(RelayControl),VarPtr(m_stControl))'设置采样率
    dsoHTSetCHAndTrigger(DeviceIndex,Varptr(RelayControl),0,VarPtr(m_stControl))'设置通道开关和电压档位
    dsoHTsetRamAndTrigerControl(DeviceIndex,m_stControl.nTimeDIV,m_stControl.nCHSet,m_stControl.nTriggerSource,0)'设置触发源
    dsoHTSetADC(DeviceIndex,VarPtr(RelayControl),m_stControl.nTimeDIV)
    for(int i=0i<MAX_CH_NUMi++)
    {
        dsoHTSetCHPos(DeviceIndex,CalLevel,RelayControl.nCHVoltDIV(i),128,i,4)
    }

    dsoHTSetVTriggerLevel(DeviceIndex,CalLevel,MAX_DATA-m_nLeverPos[(0),4)
    switch (m_nTriggerMode) {'触发设置
        Case EDGE:
            dsoHTSetTrigerMode(DeviceIndex,m_nTriggerMode,m_stControl.nTriggerSlope,DC)
            break
default:
            break
       }

End Sub


Public Sub CollectData()
    Dim nState As Integer
    Dim result As Long
    If (StartNew) Then
        Dim nStartControl As Integer
        nStartControl = 0
        nStartControl+=IIF(TriggerSweep=0,1,0)
        nStartControl+=IIF(YTFormat=0,2,0)
        nStartControl+=IIF(Collect=1,0,4)
        result = dsoHTStartCollectData(DeviceIndex, nStartControl)
        StartNew = False
   End If
    nState = dsoHTGetState(DeviceIndex)
    If (nState&2) = 2 Then
        ReadData
        StartNew = True
    Else
        ReadData
        ForceTriggerCnt = 0
        StartNew = False
            
    End If
End Sub

Public Sub ReadData()
    Dim i As Long
    
    Dim result As Integer
    Dim CH1ReadData(4096) As Integer
    Dim CH2ReadData(4096) As Integer
    Dim CH3ReadData(4096) As Integer
    Dim CH4ReadData(4096) As Integer
    result = dsoHTGetData(DeviceIndex, CH1ReadData(0), CH2ReadData(0), CH3ReadData(0), CH4ReadData(0), stControl)
    If result = 1 Then
        For i = 0 To stControl.nReadDataLen - 1
            CH1SrcData(i) = CH1ReadData(i) - (255 - LeverPos(0))
            CH2SrcData(i) = CH2ReadData(i) - (255 - LeverPos(1))
            CH3SrcData(i) = CH3ReadData(i) - (255 - LeverPos(2))
            CH4SrcData(i) = CH4ReadData(i) - (255 - LeverPos(3))
        Next i
    End If
End Sub




























