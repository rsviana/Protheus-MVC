#INCLUDE 'Protheus.ch'
#INCLUDE 'FwMVCDef.ch' 

/*/{Protheus.doc} User Function nomeFunction

Modulo 8 Aula 03

/*/
User Function NVCSZ7()
    Local aArea := GetArea()
    Local oBrowse := FwmBrowse():New()

    oBrowse:SetAlias("SZ7")
    oBrowse:SetDescription("Solicitacao de Compras")

    oBrowse:ACTIVATE()
Return 

User Function ModelDef()
    Local oStCabec := FwFormModelStruct():New()
    Local oStItens :=  FWFormStruct(1, "SZ7")
    Local oModel := MPFormModel():New("MCVSZ7m",,,,)

//Criacao da tabela temporaria

    oStCabec:AddTable("SZ7",{"Z7_FILIAL" ,"Z7_NUM","Z7_ITEM"},"Cabecalho SZ7")

//Criacao dos campos da tabela temporaria

    oStCabec:AddFiled(;
                        "Filial",;
                        "Filial",;
                        "Z7_FILIAL",;
                        "C",;
                        TamSX3("Z7_FILIAL")[1],;
                        0,;
                        Nil,;
                        Nil,;
                        {},;
                        .F.,;
                        FwBuildFeature(STRUCT_FEATURE_INIPAD,"Iif(!INCLUI,SZ7->Z7_FILIAL,FWxFilial('SZ7'))"),;
                        .T.,;
                        .F.,;
                        .F.)
    oStCabec:AddFiled(;
                        "Pedido",;
                        "Pedido",;
                        "Z7_NUN",;
                        "C",;
                        TamSX3("Z7_NUM")[1],;
                        0,;
                        Nil,;
                        Nil,;
                        {},;
                        .F.,;
                        FwBuildFeature(STRUCT_FEATURE_INIPAD,"Iif(!INCLUI,SZ7->Z7_NUM,'')"),;
                        .T.,;
                        .F.,;
                        .F.)

    oStCabec:AddFiled(;
                        "Emissao",;
                        "Emissao",;
                        "Z7_EMISSAO",;
                        "D",;
                        TamSX3("Z7_EMISSAO")[1],;
                        0,;
                        Nil,;
                        Nil,;
                        {},;
                        .F.,;
                        FwBuildFeature(STRUCT_FEATURE_INIPAD,"Iif(!INCLUI,SZ7->Z7_EMISSAO,dDataBase)"),;
                        .T.,;
                        .F.,;
                        .F.)
    oStCabec:AddFiled(;
                        "Fornecedor",;
                        "Fornecedor",;
                        "Z7_FORNECE",;
                        "D",;
                        TamSX3("Z7_FORNECE")[1],;
                        0,;
                        Nil,;
                        Nil,;
                        {},;
                        .F.,;
                        FwBuildFeature(STRUCT_FEATURE_INIPAD,"Iif(!INCLUI,SZ7->Z7_FORNECE,'')"),;
                        .T.,;
                        .F.,;
                        .F.)

    oStCabec:AddFiled(;
                        "Loja",;
                        "Loja",;
                        "Z7_LOJA",;
                        "D",;
                        TamSX3("Z7_LOJA")[1],;
                        0,;
                        Nil,;
                        Nil,;
                        {},;
                        .F.,;
                        FwBuildFeature(STRUCT_FEATURE_INIPAD,"Iif(!INCLUI,SZ7->Z7_LOJA,'')"),;
                        .T.,;
                        .F.,;
                        .F.)
                        
    oStCabec:AddFiled(;
                        "Usuario",;
                        "Usuario",;
                        "Z7_USER",;
                        "D",;
                        TamSX3("Z7_USER")[1],;
                        0,;
                        Nil,;
                        Nil,;
                        {},;
                        .F.,;
                        FwBuildFeature(STRUCT_FEATURE_INIPAD,"Iif(!INCLUI,SZ7->Z7_USER,__cuserid)"),;
                        .T.,;
                        .F.,;
                        .F.)

oSetItens:SetProoerty("Z7_NUM",MODEL_FIELD_INIT,FwBuildFeature(STRUCT_FEATURE_INIPAD, '"*"' ))
oSetItens:SetProoerty("Z7_USER",MODEL_FIELD_INIT,FwBuildFeature(STRUCT_FEATURE_INIPAD, '__cUserId' )) //Traz usuario automaticamente
oSetItens:SetProoerty("Z7_FORNECE",MODEL_FIELD_INIT,FwBuildFeature(STRUCT_FEATURE_INIPAD, '"*"' ))
oSetItens:SetProoerty("Z7_EMISSAO",MODEL_FIELD_INIT,FwBuildFeature(STRUCT_FEATURE_INIPAD, 'dDataBase' )) // Tras a data automaticamente
oSetItens:SetProoerty("Z7_LOJA",MODEL_FIELD_INIT,FwBuildFeature(STRUCT_FEATURE_INIPAD, '"*"' ))
    

    oModel:AddFileds("SZ7MASTER",,oStCabec)
    oModel:AddGrid("SZ7DETAIL","SZ7MASTER",oSetItens,,,,,)
    aRelations := {}
    aAdd(aRelations, {"Z7_FILIAL","'Iif(!INCLUI),SZ7->Z7_FILIAL,FWxFilial('SZ7'))'"})
    aAdd(aRelations,{"Z7_NUM","SZ7->Z7_NUM"})
    oModel:SetRelation("SZ7DETAIL",aRelations,SZ7->(INDEXKEY(1)))

//    oModel:SetRelation("SZ7DETAIL",{{"Z7_FILIAL","'Iif(!INCLUI, SZ7->Z7_FILIAL, FWxFilial("SZ7"))'"},{"Z7_NUM","SZ7->Z7_NUM"}},SZ7->(INDEXKEY(1)))
    oModel:SetPrimaryKey({})
    oModel:SetModel("SZ7DETAIL"):SetUniqueline("Z7_ITEM")

    oModel:SetModel("SZ7MASTER"):SetDescription("Cabecalho Compras")
    oModel:SetModel("SZ7DETAIL"):SetDescription("Itebs do Compras")

    oModel:GetModel("SZ7DETAIL"):SetUseOldGrid(.t.)
    

Return oModel


//Criando função ModelDef - Parte 3
