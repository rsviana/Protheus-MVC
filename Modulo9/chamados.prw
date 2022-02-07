#include 'protheus.ch'
#include 'parmtype.ch'
#INCLUDE 'FWMVCDef.ch'

User Function TICKETS()
     Local oBrowse := FwLoadBrw("TICKETS") // Pega no fonte 

     oBrowse:ACTIVATE()

Return

Static Function BrowseDef()
    Local aArea := GetArea()
    Local  oBrowse := FwMBrowse():New()

    oBrowse:SetAlia("SZ2")
    oBrowse:SetDescription("Cadatro de chamados")
    oBrowse:AddLegend("SZ2->Z2_STATUS == '1'","GREEN", "Chamado Aberto")
    oBrowse:AddLegend("SZ2->Z2_STATUS == '2'","RED", "Chamado Finalizado")
    oBrowse:AddLegend("SZ2->Z2_STATUS == '3'","YELLOW", "Chamado em Andamento")
    // Deve definir de onde vem o menudef
    oBrowse:SetMenuDef("TICKETS") // Chamo o fonde de onde vem o menu 

    RestArea(aArea)
Return oBrowse

// MenuDef

Static Function ModelDef()
    Local oModel := MPFormModel():New("TICKETSM",,,,)
    Local  oStPaiZ2 := FwFormStruct(1,"SZ2")
    Local  oStFilhoZ3 := FwFormStruct(1,"SZ3") 

    oModel:AddFields("SZ2MASTER",,oStPaiZ2)
    oModel:AddGrid("SZ3DETAIL","SZ2MASTER",oStFilhoZ3,,,,,)
    oModel:SetRelation("SZ3DETAIL",{{"Z3_FILIAL","xFilial('SZ2')"},{"Z3_CHAMADO","Z2_COD"}},SZ3->(IndiceKey(1)) )
    oModel:SetPrimaryKey({"Z3_FILIAL","Z3_CHAMADO","Z3_CODIGO"})
    oModel:GetModel("SZ3DETAIL"):SetUniqueLine({"Z3_CHAMADO", "Z3_CODIGO"})
    oModel:SetDescription( "Modelo 3 - Sistema de chamados" )
    oModel:GetModel("SZ2MASTER"):SetDescription("Cabecalho do chamado")
    oModel:GetModel("SZ3DETAIL"):SetDescription("Comentarios do chamado")

Return oModel


Static Function ViewDef()
    Local oView      := NIL
    Local oModel    := FwLoadModel("TICKETS")
    Local oStPaiZ2      := FwFormStruct(2,"SZ2")
    Local oStFilhoZ3    := FwFormStruct(2,"SZ3")

    oView := FwFormView():New()
    oView : SetModel(oModel)
    oView:AddField("VIEWSZ2",oStPaiZ2,"SZ2MASTER")
    oView:AddGrid("VIEWSZ3",oStFilhoZ3,"SZ3DETAIL")
    oView:CreateHorizontalBox("CABEC",60)
    oView:CreateHorizontalBox("GRID",40)
    oView:SetOwnerView("VIEWSZ2","CABEC")
    oView:SetOwnerView("VIEWSZ3","GRID")
    oView:EnableTitleView("VIEWSZ2","Detalhes do Chamado")
    oView:EnableTitleView("VIEWSZ3","Comentarios do Chamado")



Return oView
