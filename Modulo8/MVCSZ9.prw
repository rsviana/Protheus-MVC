#include 'protheus.ch'
#include 'parmtype.ch'
#include 'Fwmvcdef.ch'

User Function MVCSZ9()

    Local aArea := GetNextAlias()
    Local oBrowseSZ9 // Vasr objeto que recebvera o instanciamento da classe MBRowser

        oBrowseSZ9 := FwmBrowse():New()
            oBrowseSZ9:SetAlias("SZ9")
            oBrowseSZ9:SetDescription("Tela de Cadastro - Meu Primeiro Browser - ALTERADO!")
            oBrowseSZ9:SetOnlyFields({"Z9_CODIGO", "Z9_NONE", "Z9_SEXO", "Z9_STATUS"})
            oBrowseSZ9:AddLegend("SZ9->Z9_STATUS == '1' ","GREEN", "Catrastro Ativo")
            oBrowseSZ9:AddLegend("SZ9->Z9_STATUS == '2' ","RED", "Catrastro Inativo")
//oBrowseSZ9:SetFilterDefault("Z9_STATUS == '1' ")
            oBrowseSZ9:DisableDetails()
            //oBrowseSZ9:FWLoadMenuDef()
        oBrowseSZ9:ACTIVATE()

        RestArea(aArea) 
 
Return

Static Function MenuDef()
    Local aRotina := {}
    
    ADD OPTION aRotina TITLE 'Visualizar'   ACTION 'ViewDef.MVCSZ9' OPERATION 2 ACCESS 0
    ADD Option aRotina Title 'Incluir'      Action 'ViewDef.MVCSZ9' Operation 3 Access 0
    ADD Option aRotina Title 'Alterar'      Action 'ViewDef.MVCSZ9' Operation 4 Access 0
    ADD Option aRotina Title 'Excluir'      Action 'ViewDef.MVCSZ9' Operation 5 Access 0


Return aRotina
                
Static Function ModelDef()
    Local oModel := NIL 
    Local oStrutSZ9 := FWFormStruct(1, "SZ9")

    oModel := MPFormModel():New("MVCSZ9M",,,,)
    oModel:AddFields("FORMSZ9",,oStrutSZ9)
    oModel:SetPrimaryKey({"Z9_FILIAL", "Z9_CODIGO"})
    oModel:SetDescription("Modelo de dados de Cadastro de pessoal")
    oModel:GetModel("FORMSZ9"):SetDescription("Formulario de cadastro de pessoas do RH")
Return oModel

Static Function ViewDef()
    Local oView := NIL
    Local oModel := FWLoadModel("MVCSZ9")
    Local oStrutSZ9 := FWFormStruct(2,"SZ9")

    oView := FwFormView():New()
    oView:SetModel(oModel)
    oView:AddField("VIEWSZ9",oStrutSZ9,"FORMSZ9")
    oView:CreateHorizontalBox("TELA",100)
    oView:EnableTitleView("VIEWSZ9","Vizualicacao dos dados")
    oView:SetCloseOnOk({||.T.})
    oView:SetOwnerView("VIEWSZ9","TELA")
Return oView

