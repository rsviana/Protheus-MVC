#INCLUDE 'Protheus.ch'
#INCLUDE 'FwMVCDef.ch'

User Function MVCSZ7()
	Local aArea := GetArea()
	Local oBrowse := FwmBrowse():New()

	oBrowse:SetAlias("SZ7")
	oBrowse:SetDescription("Solicitacao de Compras")

	oBrowse:ACTIVATE()
	RestArea(aArea)
Return


Static Function MenuDef()

	Local aRotina := FwMVCMenu("MVCSZ7")

	// Outros tipos de Menu =======================================================================================
	// Local aRotinna := {}
	// ADD OPTION aRotina TITLE 'Visualizar'   ACTION 'ViewDef.MVCSZ7' OPERATION 2 ACCESS 0
	// ADD Option aRotina Title 'Incluir'      Action 'ViewDef.MVCSZ7' Operation 3 Access 0
	// ADD Option aRotina Title 'Alterar'      Action 'ViewDef.MVCSZ7' Operation 4 Access 0
	// ADD Option aRotina Title 'Excluir'      Action 'ViewDef.MVCSZ7' Operation 5 Access 0

	// Local aRotinna := {}
	// ADD OPTION aRotina TITLE 'Visualizar' ACTION 'ViewDef.MVCSZ7' OPERATION MODEL_OPERATION_VIEW ACCESS 0
	// ADD Option aRotina Title 'Incluir' Action 'ViewDef.MVCSZ7' OPERATION MODEL_OPERATION_INSERT Access 0
	// ADD Option aRotina Title 'Alterar' Action 'ViewDef.MVCSZ7' OPERATION MODEL_OPERATION_UPDATE Access 0
	// ADD Option aRotina Title 'Excluir' Action 'ViewDef.MVCSZ7' OPERATION MODEL_OPERATION_DELETE Access 0

Return aRotina

Static Function ModelDef()
	Local oStCabec  := FwFormModelStruct():New()
	Local oStItens  := FWFormStruct(1, "SZ7")
	Local bVldPos 	:= {||u_VldSZ7()}
    Local bVldCom   := {||u_GvrSZ7()}
	Local oModel    := MPFormModel():New("MVCSZ7m",/*bPre*/,bVldPos /*bPos*/, bVldCom /*bCommit*/,/*bCancel*/)
	Local aTrigQuant := {}
	Local aTrgPreco  := {}



//Criacao da tabela temporaria

	oStCabec:AddTable("SZ7",{"Z7_FILIAL" ,"Z7_NUM","Z7_ITEM"},"Cabecalho SZ7")

//Criacao dos campos da tabela temporaria

	oStCabec:AddField("Filial","Filial","Z7_FILIAL","C",TamSX3("Z7_FILIAL")[1],0,Nil,Nil,{},.F.,FwBuildFeature( STRUCT_FEATURE_INIPAD, "Iif(!INCLUI,SZ7->Z7_FILIAL,FWxFilial('SZ7'))" ), .T.,.F.,.F.)

	oStCabec:AddField(;
	"Pedido",;                                                                                  // [01]  C   Titulo do campo
	"Pedido",;                                                                                  // [02]  C   ToolTip do campo
	"Z7_NUM",;                                                                                  // [03]  C   Id do Field
	"C",;                                                                                       // [04]  C   Tipo do campo
	TamSX3("Z7_NUM")[1],;                                                                       // [05]  N   Tamanho do campo
	0,;                                                                                         // [06]  N   Decimal do campo
	Nil,;                                                                                       // [07]  B   Code-block de validação do campo
	Nil,;                                                                                       // [08]  B   Code-block de validação When do campo
	{},;                                                                                        // [09]  A   Lista de valores permitido do campo
	.F.,;                                                                                       // [10]  L   Indica se o campo tem preenchimento obrigatório
	FwBuildFeature( STRUCT_FEATURE_INIPAD, 'Iif(!INCLUI,SZ7->Z7_NUM,GetSXENum("SZ7","Z7_NUM"))'),;                    // [11]  B   Code-block de inicializacao do campo
	.T.,;                                                                                       // [12]  L   Indica se trata-se de um campo chave
	.F.,;                                                                                       // [13]  L   Indica se o campo pode receber valor em uma operação de update.
	.F.)                                                                                        // [14]  L   Indica se o campo é virtual

	oStCabec:AddField(;
	"Emissao",;                                                                     // [01]  C   Titulo do campo
	"Emissao",;                                                                     // [02]  C   ToolTip do campo
	"Z7_EMISSAO",;                                                                  // [03]  C   Id do Field
	"D",;                                                                           // [04]  C   Tipo do campo
	TamSX3("Z7_EMISSAO")[1],;                                                       // [05]  N   Tamanho do campo
	0,;                                                                             // [06]  N   Decimal do campo
	Nil,;                                                                           // [07]  B   Code-block de validação do campo
	Nil,;                                                                           // [08]  B   Code-block de validação When do campo
	{},;                                                                            // [09]  A   Lista de valores permitido do campo
	.T.,;                                                                           // [10]  L   Indica se o campo tem preenchimento obrigatório
	FwBuildFeature( STRUCT_FEATURE_INIPAD, "Iif(!INCLUI,SZ7->Z7_EMISSAO,dDataBase)" ),;    // [11]  B   Code-block de inicializacao do campo
	.T.,;                                                                           // [12]  L   Indica se trata-se de um campo chave
	.F.,;                                                                           // [13]  L   Indica se o campo pode receber valor em uma operação de update.
	.F.)                                                                            // [14]  L   Indica se o campo é virtual


	oStCabec:AddField(;
	"Fornecedor",;                                                              // [01]  C   Titulo do campo
	"Fornecedor",;                                                              // [02]  C   ToolTip do campo
	"Z7_FORNECE",;                                                              // [03]  C   Id do Field
	"C",;                                                                       // [04]  C   Tipo do campo
	TamSX3("Z7_FORNECE")[1],;                                                   // [05]  N   Tamanho do campo
	0,;                                                                         // [06]  N   Decimal do campo
	Nil,;                                                                       // [07]  B   Code-block de validação do campo
	Nil,;                                                                       // [08]  B   Code-block de validação When do campo
	{},;                                                                        // [09]  A   Lista de valores permitido do campo
	.T.,;                                                                       // [10]  L   Indica se o campo tem preenchimento obrigatório
	FwBuildFeature( STRUCT_FEATURE_INIPAD, "Iif(!INCLUI,SZ7->Z7_FORNECE,'')" ),;// [11]  B   Code-block de inicializacao do campo
	.F.,;                                                                       // [12]  L   Indica se trata-se de um campo chave
	.F.,;                                                                       // [13]  L   Indica se o campo pode receber valor em uma operação de update.
	.F.)                                                                        // [14]  L   Indica se o campo é virtual

	oStCabec:AddField(;
	"Loja",;                                                                      // [01]  C   Titulo do campo
	"Loja",;                                                                      // [02]  C   ToolTip do campo
	"Z7_LOJA",;                                                                   // [03]  C   Id do Field
	"C",;                                                                         // [04]  C   Tipo do campo
	TamSX3("Z7_LOJA")[1],;                                                        // [05]  N   Tamanho do campo
	0,;                                                                           // [06]  N   Decimal do campo
	Nil,;                                                                         // [07]  B   Code-block de validação do campo
	Nil,;                                                                         // [08]  B   Code-block de validação When do campo
	{},;                                                                          // [09]  A   Lista de valores permitido do campo
	.T.,;                                                                         // [10]  L   Indica se o campo tem preenchimento obrigatório
	FwBuildFeature( STRUCT_FEATURE_INIPAD, "Iif(!INCLUI,SZ7->Z7_LOJA,'')" ),;     // [11]  B   Code-block de inicializacao do campo
	.F.,;                                                                         // [12]  L   Indica se trata-se de um campo chave
	.F.,;                                                                         // [13]  L   Indica se o campo pode receber valor em uma operação de update.
	.F.)                                                                          // [14]  L   Indica se o campo é virtual

	oStCabec:AddField(;
		"Usuario",;                                                                     // [01]  C   Titulo do campo
	"Usuario",;                                                                     // [02]  C   ToolTip do campo
	"Z7_USER",;                                                                     // [03]  C   Id do Field
	"C",;                                                                           // [04]  C   Tipo do campo
	TamSX3("Z7_USER")[1],;                                                          // [05]  N   Tamanho do campo
	0,;                                                                             // [06]  N   Decimal do campo
	Nil,;                                                                           // [07]  B   Code-block de validação do campo
	Nil,;                                                                           // [08]  B   Code-block de validação When do campo
	{},;                                                                            // [09]  A   Lista de valores permitido do campo
	.T.,;                                                                           // [10]  L   Indica se o campo tem preenchimento obrigatório
	FwBuildFeature( STRUCT_FEATURE_INIPAD, "Iif(!INCLUI,SZ7->Z7_USER,__cuserid)" ),;// [11]  B   Code-block de inicializacao do campo
	.F.,;                                                                           // [12]  L   Indica se trata-se de um campo chave
	.F.,;                                                                           // [13]  L   Indica se o campo pode receber valor em uma operação de update.
	.F.)                                                                            // [14]  L   Indica se o campo é virtual

//Agora vamos tratar a estrutura dos Itens, que serão utilizados no Grid da aplicação

//Modificando Inicializadores Padrao,  para não dar mensagem de colunas vazias
    oStItens:SetProperty("Z7_NUM",      MODEL_FIELD_INIT, FwBuildFeature(STRUCT_FEATURE_INIPAD, '"*"'))
    oStItens:SetProperty("Z7_USER",     MODEL_FIELD_INIT, FwBuildFeature(STRUCT_FEATURE_INIPAD, '__cUserId')) //Trazer o usuário automatico
    oStItens:SetProperty("Z7_EMISSAO",  MODEL_FIELD_INIT, FwBuildFeature(STRUCT_FEATURE_INIPAD, 'dDatabase')) //Trazer a data automática
    oStItens:SetProperty("Z7_FORNECE",  MODEL_FIELD_INIT, FwBuildFeature(STRUCT_FEATURE_INIPAD, '"*"'))
    oStItens:SetProperty("Z7_LOJA",     MODEL_FIELD_INIT, FwBuildFeature(STRUCT_FEATURE_INIPAD, '"*"'))


	aTrigQuant := FwStruTrigger(;
								"Z7_QUANT" ,; // Campo Dominio
								"Z7_TOTAL" ,; // Campo de Contradominio
								"M->Z7_QUANT * M->Z7_PRECO",; // Regra de Preenchimento
								.F. ,)    

	aTrgPreco := FwStruTrigger(;
								"Z7_PRECO" ,; // Campo Dominio
								"Z7_TOTAL" ,; // Campo de Contradominio
								"M->Z7_QUANT * M->Z7_PRECO",; // Regra de Preenchimento
								.F. ,)    

	oStItens:AddTrigger(;
				aTrigQuant[1],;
				aTrigQuant[2],;
				aTrigQuant[3],;
				aTrigQuant[4],)


	oModel:AddFields("SZ7MASTER",,oStCabec) //Faço a vinculação com o oStCabe(cabeçalho e itens temporários)
	oModel:AddGrid("SZ7DETAIL","SZ7MASTER",oStItens,,,,,)

	//Alterado para ver se funciona
	// oModel:SetRelation("SZ7DETAIL",{{"Z7_FILIAL","'Iif(!INCLUI,SZ7->Z7_FILIAL,FWxFilial('SZ7'))'"},{"Z7_NUM","SZ7->Z7_NUM"}},SZ7->(INDEXKEY(1)))
	aRelations := {}
	aAdd(aRelations,{"Z7_FILIAL",'Iif(!INCLUI, SZ7->Z7_FILIAL, FWxFilial("SZ7"))'})
	aAdd(aRelations,{"Z7_NUM","SZ7->Z7_NUM"})
	oModel:SetRelation("SZ7DETAIL",aRelations,SZ7->(IndexKey(1)))

	oModel:SetRelation('SZ7DETAIL',{{'Z7_FILIAL','Iif(!INCLUI, SZ7->Z7_FILIAL, FWxFilial("SZ7"))'},{'Z7_NUM','SZ7->Z7_NUM'}},SZ7->(IndexKey(1)))

	oModel:SetPrimaryKey({})
	oModel:GetModel("SZ7DETAIL"):SetUniqueline({"Z7_ITEM"} )
	oModel:GetModel("SZ7MASTER"):SetDescription("Cabecalho Compras")
	oModel:GetModel("SZ7DETAIL"):SetDescription("ITENS DA SOLICITAÇÃO DE COMPRAS")
	oModel:GetModel("SZ7DETAIL"):SetUseOldGrid(.T.)


	oStru:AddTrigger( ;
      aAux[1] , ;       // [01] Id do campo de origem
      aAux[2] , ;       // [02] Id do campo de destino
      aAux[3] , ;       // [03] Bloco de codigo de validação da execução do gatilho
      aAux[4] )         // [04] Bloco de codigo de execução do gatilho

Return oModel


Static Function ViewDef()

	Local oView    := Nil
	Local oModel   := FwLoadModel("MVCSZ7") // Busca dentro da User Funcition o modeldef, pois ele carrega toda a estrutur
	Local oStCabec := FwFormViewStruct():New()

	Local oStItens    := FwFormStruct(2,"SZ7")

	oStCabec:AddField(;
		"Z7_NUM",;                  // [01]  C   Nome do Campo
	"01",;                      // [02]  C   Ordem
	"Pedido",;                  // [03]  C   Titulo do campo
	X3Descric('Z7_NUM'),;       // [04]  C   Descricao do campo
	Nil,;                       // [05]  A   Array com Help
	"C",;                       // [06]  C   Tipo do campo
	X3Picture("Z7_NUM"),;       // [07]  C   Picture
	Nil,;                       // [08]  B   Bloco de PictTre Var
	Nil,;                       // [09]  C   Consulta F3
	.F.,;    	// [10]  L   Indica se o campo é alteravel
	Nil,;                       // [11]  C   Pasta do campo
	Nil,;                       // [12]  C   Agrupamento do campo
	Nil,;                       // [13]  A   Lista de valores permitido do campo (Combo)
	Nil,;                       // [14]  N   Tamanho maximo da maior opção do combo
	Nil,;                       // [15]  C   Inicializador de Browse
	Nil,;                       // [16]  L   Indica se o campo é virtual
	Nil,;                       // [17]  C   Picture Variavel
	Nil)                        // [18]  L   Indica pulo de linha após o campo

	oStCabec:AddField(;
		"Z7_EMISSAO",;                // [01]  C   Nome do Campo
	"02",;                      // [02]  C   Ordem
	"Emissao",;                  // [03]  C   Titulo do campo
	X3Descric('Z7_EMISSAO'),;    // [04]  C   Descricao do campo
	Nil,;                       // [05]  A   Array com Help
	"D",;                       // [06]  C   Tipo do campo
	X3Picture("Z7_EMISSAO"),;    // [07]  C   Picture
	Nil,;                       // [08]  B   Bloco de PictTre Var
	Nil,;                       // [09]  C   Consulta F3
	Iif(INCLUI, .T., .F.),;     // [10]  L   Indica se o campo é alteravel
	Nil,;                       // [11]  C   Pasta do campo
	Nil,;                       // [12]  C   Agrupamento do campo
	Nil,;                       // [13]  A   Lista de valores permitido do campo (Combo)
	Nil,;                       // [14]  N   Tamanho maximo da maior opção do combo
	Nil,;                       // [15]  C   Inicializador de Browse
	Nil,;                       // [16]  L   Indica se o campo é virtual
	Nil,;                       // [17]  C   Picture Variavel
	Nil)

	oStCabec:AddField(;
		"Z7_FORNECE",;                  // [01]  C   Nome do Campo
	"03",;                          // [02]  C   Ordem
	"Fornecedor",;                  // [03]  C   Titulo do campo
	X3Descric('Z7_FORNECE'),;       // [04]  C   Descricao do campo
	Nil,;                           // [05]  A   Array com Help
	"C",;                           // [06]  C   Tipo do campo
	X3Picture("Z7_FORNECE"),;       // [07]  C   Picture
	Nil,;                           // [08]  B   Bloco de PictTre Var
	"SA2",;                         // [09]  C   Consulta F3
	.T.,;                             // [10]  L   Indica se o campo é alteravel
	Nil,;                           // [11]  C   Pasta do campo
	Nil,;                           // [12]  C   Agrupamento do campo
	Nil,;                           // [13]  A   Lista de valores permitido do campo (Combo)
	Nil,;                           // [14]  N   Tamanho maximo da maior opção do combo
	Nil,;                           // [15]  C   Inicializador de Browse
	Nil,;                           // [16]  L   Indica se o campo é virtual
	Nil,;                           // [17]  C   Picture Variavel
	Nil)

	oStCabec:AddField(;
		"Z7_LOJA",;                 // [01]  C   Nome do Campo
	"04",;                      // [02]  C   Ordem
	"Loja",;                    // [03]  C   Titulo do campo
	X3Descric('Z7_LOJA'),;      // [04]  C   Descricao do campo
	Nil,;                       // [05]  A   Array com Help
	"C",;                       // [06]  C   Tipo do campo
	X3Picture("Z7_LOJA"),;      // [07]  C   Picture
	Nil,;                       // [08]  B   Bloco de PictTre Var
	Nil,;                       // [09]  C   Consulta F3
	Iif(INCLUI, .T., .F.),;     // [10]  L   Indica se o campo é alteravel
	Nil,;                       // [11]  C   Pasta do campo
	Nil,;                       // [12]  C   Agrupamento do campo
	Nil,;                       // [13]  A   Lista de valores permitido do campo (Combo)
	Nil,;                       // [14]  N   Tamanho maximo da maior opção do combo
	Nil,;                       // [15]  C   Inicializador de Browse
	Nil,;                       // [16]  L   Indica se o campo é virtual
	Nil,;                       // [17]  C   Picture Variavel
	Nil)

	oStCabec:AddField(;
		"Z7_USER",;                 // [01]  C   Nome do Campo
	"05",;                      // [02]  C   Ordem
	"Usuário",;                 // [03]  C   Titulo do campo
	X3Descric('Z7_USER'),;      // [04]  C   Descricao do campo
	Nil,;                       // [05]  A   Array com Help
	"C",;                       // [06]  C   Tipo do campo
	X3Picture("Z7_USER"),;      // [07]  C   Picture
	Nil,;                       // [08]  B   Bloco de PictTre Var
	Nil,;                       // [09]  C   Consulta F3
	.F.,;                       // [10]  L   Indica se o campo é alteravel
	Nil,;                       // [11]  C   Pasta do campo
	Nil,;                       // [12]  C   Agrupamento do campo
	Nil,;                       // [13]  A   Lista de valores permitido do campo (Combo)
	Nil,;                       // [14]  N   Tamanho maximo da maior opção do combo
	Nil,;                       // [15]  C   Inicializador de Browse
	Nil,;                       // [16]  L   Indica se o campo é virtual
	Nil,;                       // [17]  C   Picture Variavel
	Nil)

	oStItens:RemoveField("Z7_NUM")
	oStItens:RemoveField("Z7_EMISSAO")
	oStItens:RemoveField("Z7_FORNECE")
	oStItens:RemoveField("Z7_LOJA")
	oStItens:RemoveField("Z7_USER")

//Segunda PArte da ViewDef

	oView := FwFormView():New()
	oView:SetModel(oModel)


	oView:AddField("VIEW_SZ7M",oStCabec,"SZ7MASTER") //Crio a view do Cabeçalho/Master
	oView:AddGrid("VIEW_SZ7D", oStItens,"SZ7DETAIL")

	oView:AddIncrementField("SZ7DETAIL","Z7_ITEM")

	oView:CreateHorizontalBox("CABEC",30)
	oView:CreateHorizontalBox("GRID",60)

	oView:SetOwnerView("VIEW_SZ7M","CABEC")
	oView:SetOwnerView("VIEW_SZ7D","GRID")

	oView:EnableTitleView("VIEW_SZ7M","Cabeçalho Solicitação de Compras")
	oView:EnableTitleView("VIEW_SZ7D","ITens de Solicitcao de compras")

	oView:SetCloseOnOk({||.T.})


Return oView

User Function GvrSZ7()
    Local lRet := .T.
    Local aArea := GetArea()
    Local oModel := FwModelActive()
    Local oModelCabec   := oModel:GetModel("SZ7MASTER")
    Local oModelItem    := oModel:GetModel("SZ7DETAIL")
    Local cFilSZ7       := oModelCabec:GetValue("Z7_FILIAL")
    Local cNum          := oModelCabec:GetValue("Z7_NUM")
    Local dEmissao      := oModelCabec:GetValue("Z7_EMISSAO")
    Local cFornece      := oModelCabec:GetValue("Z7_FORNECE")
    Local cLoja         := oModelCabec:GetValue("Z7_LOJA")
    Local cUser         := oModelCabec:GetValue("Z7_USER")
    
    Local aHeaderAux    :=  oModelItem:aHeader
    Local aColsAux      :=  oModelItem:aCols
							 	
    Local nPosItem  := aScan(aHeaderAux, {|x| AllTrim(Upper(x[2])) == AllTrim("Z7_ITEM")})
    Local nPosProd  := aScan(aHeaderAux, {|x| AllTrim(Upper(x[2])) == AllTrim("Z7_PRODUTO")})
    Local nPosQtd   := aScan(aHeaderAux, {|x| AllTrim(Upper(x[2])) == AllTrim("Z7_QUANT")})
    Local nPosPrc   := aScan(aHeaderAux, {|x| AllTrim(Upper(x[2])) == AllTrim("Z7_PRECO")})
    Local nPosTotal := aScan(aHeaderAux, {|x| AllTrim(Upper(x[2])) == AllTrim("Z7_TOTAL")})


    Local nLinAtu := 0
    Local cOption := oModelCabec:GetOperation()


    dbSelectArea("SZ7")
    SZ7->(dbSetOrder(1)) 
			  
    If cOption == MODEL_OPERATION_INSERT
        for nLinAtu := 1 to Len(aColsAux)
		 	IF !aColsAux[nLinAtu][Len(aHeaderAux)+1] 

                RecLock("SZ7",.T.)
                // Cabecalho
                    Z7_FILIAL    := cFilSZ7
                    Z7_NUM       := cNum   
                    Z7_EMISSAO   := dEmissao
                    Z7_FORNECE   := cFornece
                    Z7_LOJA      := cLoja
                    Z7_USER      := cUser
                // Grid
                    Z7_ITEM     := aColsAux[nLinAtu,nPosItem]
                    Z7_PRODUTO  := aColsAux[nLinAtu,nPosProd]
                    Z7_QUANT    := aColsAux[nLinAtu,nPosQtd]
                    Z7_PRECO    := aColsAux[nLinAtu,nPosPrc]
                    Z7_TOTAL    := aColsAux[nLinAtu,nPosTotal]


                SZ7->(MsUnlock())
            EndIf
        Next n

		// Inserido para alteracao e nao inclusao
		elseif cOption == MODEL_OPERATION_UPDATE
		      for nLinAtu := 1 to Len(aColsAux)
		 		IF aColsAux[nLinAtu][Len(aHeaderAux)+1] 
					SZ7->(dbSetOrder(2))
					If SZ7->(DbSeek(cFilSZ7+cNum+aColsAux[nLinAtu,nPosItem]))
						RecLock("SZ7",.F.)
							dbDelete()
						SZ7->(MsUnlock())
					EndIf	
					else
					SZ7->(dbSetOrder(2))
					If SZ7->(DbSeek(cFilSZ7+cNum+aColsAux[nLinAtu,nPosItem]))
						RecLock("SZ7",.F.)
						// Cabecalho
							Z7_FILIAL    := cFilSZ7
							Z7_NUM       := cNum   
							Z7_EMISSAO   := dEmissao
							Z7_FORNECE   := cFornece
							Z7_LOJA      := cLoja
							Z7_USER      := cUser
						// Grid
							Z7_ITEM     := aColsAux[nLinAtu,nPosItem]
							Z7_PRODUTO  := aColsAux[nLinAtu,nPosProd]
							Z7_QUANT    := aColsAux[nLinAtu,nPosQtd]
							Z7_PRECO    := aColsAux[nLinAtu,nPosPrc]
							Z7_TOTAL    := aColsAux[nLinAtu,nPosTotal]
							SZ7->(MsUnlock())
					else
					SZ7->(dbSetOrder(2))
						RecLock("SZ7",.T.)
						// Cabecalho
							Z7_FILIAL    := cFilSZ7
							Z7_NUM       := cNum   
							Z7_EMISSAO   := dEmissao
							Z7_FORNECE   := cFornece
							Z7_LOJA      := cLoja
							Z7_USER      := cUser
						// Grid
							Z7_ITEM     := aColsAux[nLinAtu,nPosItem]
							Z7_PRODUTO  := aColsAux[nLinAtu,nPosProd]
							Z7_QUANT    := aColsAux[nLinAtu,nPosQtd]
							Z7_PRECO    := aColsAux[nLinAtu,nPosPrc]
							Z7_TOTAL    := aColsAux[nLinAtu,nPosTotal]
							SZ7->(MsUnlock())
					EndIf	
				EndIf	
        	Next n
  
		elseif cOption ==  MODEL_OPERATION_DELETE
				SZ7->((DbSetOrder(1)))
				While !SZ7->(EOF()) .and. SZ7->Z7_NUM = cNum .and. SZ7->Z7_FILIAL = cFilSZ7
					RecLock("SZ7",.F.)
						dbDelete()
					SZ7->(MsUnlock())
					SZ7->(DBSKIP())

				ENDDO
		EndIf
    RestArea(aArea)
Return lRet

// Funcao não esta sendo usada pois o codigo esta vindo automatico pelo licence, neste caso não houve necessidade de validação do mesmo.
User Function VldSZ7()
	Local lRet			:= .T.
	Local aArea 		:= GetArea()
 	Local oModel 		:= FwModelActive()
    Local oModelCabec   := oModel:GetModel("SZ7MASTER")
    Local cFilSZ7       := oModelCabec:GetValue("Z7_FILIAL")
    Local cNum          := oModelCabec:GetValue("Z7_NUM")
	Local cOption 		:= oModelCabec:GetOperation()

		If cOption == MODEL_OPERATION_INSERT
			dbSelectArea("SZ7")
			SZ7->(dbSetOrder(1))
				If SZ7->(DbSeek(cFilSZ7+cNum))
					Help(Nil,Nil, "Escolha outro numero de pedido",Nil," Este pedido de compras já existe no nosso sistena",1,0,Nil,Nil,Nil,Nil,Nil,{"ATENCAO"})
					lRet := .F.
				EndIf
		EndIf	
		RestArea(aArea)
	
Return lRet
