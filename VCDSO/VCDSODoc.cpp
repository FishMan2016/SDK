// VCDSODoc.cpp : implementation of the CVCDSODoc class
//

#include "stdafx.h"
#include "VCDSO.h"

#include "VCDSODoc.h"

#ifdef _DEBUG
#define new DEBUG_NEW
#undef THIS_FILE
static char THIS_FILE[] = __FILE__;
#endif

/////////////////////////////////////////////////////////////////////////////
// CVCDSODoc

IMPLEMENT_DYNCREATE(CVCDSODoc, CDocument)

BEGIN_MESSAGE_MAP(CVCDSODoc, CDocument)
	//{{AFX_MSG_MAP(CVCDSODoc)
		// NOTE - the ClassWizard will add and remove mapping macros here.
		//    DO NOT EDIT what you see in these blocks of generated code!
	//}}AFX_MSG_MAP
END_MESSAGE_MAP()

/////////////////////////////////////////////////////////////////////////////
// CVCDSODoc construction/destruction

CVCDSODoc::CVCDSODoc()
{
	// TODO: add one-time construction code here

}

CVCDSODoc::~CVCDSODoc()
{
}

BOOL CVCDSODoc::OnNewDocument()
{
	if (!CDocument::OnNewDocument())
		return FALSE;

	// TODO: add reinitialization code here
	// (SDI documents will reuse this document)

	return TRUE;
}



/////////////////////////////////////////////////////////////////////////////
// CVCDSODoc serialization

void CVCDSODoc::Serialize(CArchive& ar)
{
	if (ar.IsStoring())
	{
		// TODO: add storing code here
	}
	else
	{
		// TODO: add loading code here
	}
}

/////////////////////////////////////////////////////////////////////////////
// CVCDSODoc diagnostics

#ifdef _DEBUG
void CVCDSODoc::AssertValid() const
{
	CDocument::AssertValid();
}

void CVCDSODoc::Dump(CDumpContext& dc) const
{
	CDocument::Dump(dc);
}
#endif //_DEBUG

/////////////////////////////////////////////////////////////////////////////
// CVCDSODoc commands
