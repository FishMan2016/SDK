#include "Hard.h"
#include <QLibrary>
#include <QMessageBox>
Hard::Hard()
{

    ULONG i = 0;
    m_nDeviceIndex = 0;
    m_nDeviceNum = 0;
    for(i=0;i<MAX_CH_NUM;i++)
    {
        m_pSrcData[i] = new short[BUF_4K_LEN];
    }
    m_clrRGB[CH1] = RGB(255,255,0);
    m_clrRGB[CH2] = RGB(0,255,255);
    m_clrRGB[CH3] = RGB(255,0,255);
    m_clrRGB[CH4] = RGB(0,255,0);
    memset(m_nCalLevel,0,sizeof(m_nCalLevel));
    m_nTimeDIV = 9;
    m_nYTFormat = YT_NORMAL;
    m_stControl.nCHSet = 0x0F;////Factory Setup
    m_stControl.nTimeDIV = m_nTimeDIV;//Factory Setup
    m_stControl.nTriggerSource = CH1;//Factory Setup
    m_stControl.nHTriggerPos = 50;//Factory Setup
    m_stControl.nVTriggerPos = 64;//Factory Setup
    m_stControl.nTriggerSlope = RISE;//Factory Setup
    m_stControl.nBufferLen = BUF_4K_LEN;//Factory Setup
    m_stControl.nReadDataLen = BUF_4K_LEN;//Factory Setup
    m_stControl.nAlreadyReadLen = BUF_4K_LEN;//Factory Setup
    m_stControl.nALT = 0;//Factory Setup
    m_stControl.nFPGAVersion = 0xa000;//Factory Setup
    for(i=0;i<MAX_CH_NUM;i++)
    {
        RelayControl.bCHEnable[i] = 1;
        RelayControl.nCHVoltDIV[i] = 5;
        RelayControl.nCHCoupling[i] = AC;
        RelayControl.bCHBWLimit[i] = 0;
    }
    RelayControl.nTrigSource = CH1;
    RelayControl.bTrigFilt = 0;
    RelayControl.nALT = 0;
    m_nTriggerMode = EDGE;
    m_nTriggerSlope = RISE;
    m_nTriggerSweep = AUTO;
    m_nLeverPos[CH1] = 80;
    m_nLeverPos[CH2] = 112;
    m_nLeverPos[CH3] = 144;
    m_nLeverPos[CH4] = 176;
    m_bCollect=TRUE;
    m_nReadOK = 0;

    m_nDeviceIndex = 0;
    for(i=0;i<AMPCALI_Len;i++){pAmpLevel[i]=1024;}//所有幅度修正设置为1024/1024=1.0
    QLibrary hardLib("HTHardDll.dll");
    {
        typedef WORD (*MyPrototype5)(WORD ,WORD*,WORD*,WORD*,WORD*,WORD,WORD,WORD,WORD);
        MyPrototype5 myFunction5 = (MyPrototype5) hardLib.resolve("dsoHTSetCHAndTriggerVB");
        WORD *bCHEmable=(WORD *)malloc(8*sizeof(WORD));
        WORD *bCHBWLimit=(WORD *)malloc(8*sizeof(WORD));
        WORD *nCHVoltDIV=(WORD *)malloc(8*sizeof(WORD));
        WORD *nCHCoupling=(WORD *)malloc(8*sizeof(WORD));

        WORD nFlag=RelayControl.nALT;
        for(int i=0;i<4;i++){
            bCHEmable[i]=1;
            bCHBWLimit[i]=0;
            nCHVoltDIV[i]=RelayControl.nCHVoltDIV[i];
            nCHCoupling[i]=RelayControl.nCHCoupling[i];
        }
        myFunction5(m_nDeviceIndex,bCHEmable,RelayControl.nCHVoltDIV,RelayControl.nCHCoupling,bCHBWLimit,(WORD)0,(WORD)0,nFlag,(WORD)6);
    }

}
void Hard::Init()
{
     QLibrary hardLib("HTHardDll.dll");
    m_nDeviceIndex = 0;


    {
        typedef WORD (*MyPrototypeA)(WORD );
        MyPrototypeA myFunctionA = (MyPrototypeA) hardLib.resolve("dsoSetUSBBus");
        myFunctionA(m_nDeviceIndex);
        Sleep(5);
    }
    {
        typedef WORD (*MyPrototypeB)(WORD );
        MyPrototypeB myFunctionB = (MyPrototypeB) hardLib.resolve("dsoInitADCOnce");
        myFunctionB(m_nDeviceIndex);
        Sleep(5);
    }
    {
        typedef WORD (*MyPrototype2)(WORD ,WORD);
        MyPrototype2 myFunction2 = (MyPrototype2) hardLib.resolve("dsoHTADCCHModGain");
        myFunction2(m_nDeviceIndex,4);
        Sleep(5);
    }
    {
        typedef WORD (*MyPrototype3)(WORD ,WORD*,WORD);
        MyPrototype3 myFunction3 = (MyPrototype3) hardLib.resolve("dsoHTReadCalibrationData");
        myFunction3(m_nDeviceIndex,m_nCalLevel,CAL_LEVEL_LEN);
        Sleep(5);

        if(m_nCalLevel[CAL_LEVEL_LEN-1]!=ZERO_FLAG){
            for(int i=0;i< ZEROCALI_LEN;i++){
                int nVolt=(i%ZEROCALI_PER_CH_LEN)/ZEROCALI_PER_VOLT_LEN;
                if(nVolt==5||nVolt==8||nVolt==11){
                    switch((i%ZEROCALI_PER_CH_LEN)%ZEROCALI_PER_VOLT_LEN){
                    case 0:
                        m_nCalLevel[i]=16602;
                        break;
                    case 1:
                        m_nCalLevel[i]=60111;
                        break;
                    case 2:
                        m_nCalLevel[i]=17528;
                        break;
                    case 3:
                        m_nCalLevel[i]=59201;
                        break;
                    case 4:
                        m_nCalLevel[i]=17710;
                        break;
                    case 5:
                        m_nCalLevel[i]=58900;
                        break;
                    default:
                        m_nCalLevel[i]=0;
                        break;
                    }
                }
            }
        }
    }
    {
        typedef WORD (*MyPrototype4)(WORD ,WORD*,WORD,RELAYCONTROL*,CONTROLDATA*);
        MyPrototype4 myFunction4 = (MyPrototype4) hardLib.resolve("dsoHTSetSampleRate");
        myFunction4(m_nDeviceIndex,pAmpLevel,m_nYTFormat,&RelayControl,&m_stControl);
        Sleep(5);
    }
    {
        Init2();
        //typedef WORD (*MyPrototype6)(WORD,WORD,WORD,WORD,WORD);
       // MyPrototype6 myFunction6 = (MyPrototype6) hardLib.resolve("dsoHTSetRamAndTrigerControl");
       // WORD hhh=0;
        // myFunction6(m_nDeviceIndex,m_stControl.nTimeDIV,m_stControl.nCHSet,m_stControl.nTriggerSource,hhh);
    }
    /*
    //dsoHTSetCHAndTrigger(m_nDeviceIndex,&RelayControl,m_stControl.nTimeDIV);//设置通道开关和电压档位
    dsoHTSetRamAndTrigerControl(m_nDeviceIndex,m_stControl.nTimeDIV,m_stControl.nCHSet,m_stControl.nTriggerSource,0);//设置触发源
    for(int i=0;i<MAX_CH_NUM;i++)
    {
        dsoHTSetCHPos(m_nDeviceIndex,m_nCalLevel,RelayControl.nCHVoltDIV[i],128,i,4);
    }

    dsoHTSetVTriggerLevel(m_nDeviceIndex,m_nCalLevel,MAX_DATA-m_nLeverPos[CH1],4);
    switch (m_nTriggerMode) {//触发设置
    case EDGE:
        dsoHTSetTrigerMode(m_nDeviceIndex,m_nTriggerMode,m_stControl.nTriggerSlope,DC);
        break;
    default:
        break;
    }

*/
}
void Hard::ReadData()
{

}
void Hard::SourceToDisplay(USHORT *pData, ULONG nDataLen, USHORT nCH)
{

}
void Hard::Init2()
{
    QLibrary hardLib("HTHardDll.dll");
    typedef WORD (*MyPrototype6)(WORD,WORD,WORD,WORD,WORD);
     MyPrototype6 myFunction6 = (MyPrototype6) hardLib.resolve("dsoHTSetRamAndTrigerControl");
    WORD hhh=0;
   myFunction6(m_nDeviceIndex,m_stControl.nTimeDIV,m_stControl.nCHSet,m_stControl.nTriggerSource,hhh);


}
