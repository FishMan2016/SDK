// VCDSOView.cpp : implementation of the CVCDSOView class
//

#include "stdafx.h"
#include "VCDSO.h"

#include "VCDSODoc.h"
#include "VCDSOView.h"

#ifdef _DEBUG
#define new DEBUG_NEW
#undef THIS_FILE
static char THIS_FILE[] = __FILE__;
#endif

/////////////////////////////////////////////////////////////////////////////
// CVCDSOView

IMPLEMENT_DYNCREATE(CVCDSOView, CView)

BEGIN_MESSAGE_MAP(CVCDSOView, CView)
	//{{AFX_MSG_MAP(CVCDSOView)
		// NOTE - the ClassWizard will add and remove mapping macros here.
		//    DO NOT EDIT what you see in these blocks of generated code!
	//}}AFX_MSG_MAP
	// Standard printing commands
	ON_COMMAND(ID_FILE_PRINT, CView::OnFilePrint)
	ON_COMMAND(ID_FILE_PRINT_DIRECT, CView::OnFilePrint)
	ON_COMMAND(ID_FILE_PRINT_PREVIEW, CView::OnFilePrintPreview)
END_MESSAGE_MAP()

/////////////////////////////////////////////////////////////////////////////
// CVCDSOView construction/destruction

CVCDSOView::CVCDSOView()
{
	// TODO: add construction code here

}

CVCDSOView::~CVCDSOView()
{
}

BOOL CVCDSOView::PreCreateWindow(CREATESTRUCT& cs)
{
	// TODO: Modify the Window class or styles here by modifying
	//  the CREATESTRUCT cs

	return CView::PreCreateWindow(cs);
}

/////////////////////////////////////////////////////////////////////////////
// CVCDSOView drawing

void CVCDSOView::OnDraw(CDC* pDC)
{
	CVCDSODoc* pDoc = GetDocument();
	ASSERT_VALID(pDoc);
	// TODO: add draw code for native data here
}

/////////////////////////////////////////////////////////////////////////////
// CVCDSOView printing

BOOL CVCDSOView::OnPreparePrinting(CPrintInfo* pInfo)
{
	// default preparation
	return DoPreparePrinting(pInfo);
}

void CVCDSOView::OnBeginPrinting(CDC* /*pDC*/, CPrintInfo* /*pInfo*/)
{
	// TODO: add extra initialization before printing
}

void CVCDSOView::OnEndPrinting(CDC* /*pDC*/, CPrintInfo* /*pInfo*/)
{
	// TODO: add cleanup after printing
}

/////////////////////////////////////////////////////////////////////////////
// CVCDSOView diagnostics

#ifdef _DEBUG
void CVCDSOView::AssertValid() const
{
	CView::AssertValid();
}

void CVCDSOView::Dump(CDumpContext& dc) const
{
	CView::Dump(dc);
}

CVCDSODoc* CVCDSOView::GetDocument() // non-debug version is inline
{
	ASSERT(m_pDocument->IsKindOf(RUNTIME_CLASS(CVCDSODoc)));
	return (CVCDSODoc*)m_pDocument;
}
#endif //_DEBUG

/////////////////////////////////////////////////////////////////////////////
// CVCDSOView message handlers
