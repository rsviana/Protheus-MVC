#include 'protheus.ch'
#include 'parmtype.ch'
#INCLUDE 'FWMVCDEF.ch'

User Function   
 
    Local aArea := GetNextAlias()
    Local oBrowseSZ9 // Vasr objeto que recebvera o instanciamento da classe MBRowser
                        

        oBrowseSZ9 := FwmBrowse():New()
            oBrowseSZ9:SetAlias("SZ9")
            oBrowseSZ9:SetDescription("Tela de Cadastro - Meu Primeiro Browse")
            oBrowseSZ9:SetOnlyFields({"Z9_CODIGO","Z9_NONE","Z9_SEXO","Z9_STATUS"})
            oBrowseSZ9:AddLegend("SZ9->Z9_STATUS == '1'","GREEN",   "Catrastro Ativo")
            oBrowseSZ9:AddLegend("SZ9->Z9_STATUS == '2'","RED",     "Catrastro Inativo")
            oBrowseSZ9:SetFilterDefault("Z9_STATUS == '1'")
            oBrowseSZ9:DisableDetails()
        oBrowseSZ9:ACTIVATE()

        RestArea(aArea)

Return
