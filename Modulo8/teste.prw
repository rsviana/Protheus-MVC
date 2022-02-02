#include 'Protheus.ch'
#include 'FwMvcDef.ch'

User Function MVCSZ7()
Local aArea     := GetArea()
Local oBrowse   := FwmBrowse():New() 

oBrowse:SetAlias("SZ7")
oBrowse:SetDescription("Solicita��o de Compras")

oBrowse:Activate()

RestArea(aArea)

Return 

Static Function MenuDef()

Local aRotina := FwMvcMenu("MVCSZ7")

/*Segunda Op��o de Menu
Local aRotina := {}

ADD OPTION aRotina TITLE 'Visualizar'   ACTION 'VIEWDEF.MVCSZ7'   OPERATION 2 ACCESS 0
ADD OPTION aRotina TITLE 'Incluir'      ACTION 'VIEWDEF.MVCSZ7'   OPERATION 3 ACCESS 0
ADD OPTION aRotina TITLE 'Alterar'      ACTION 'VIEWDEF.MVCSZ7'   OPERATION 4 ACCESS 0
ADD OPTION aRotina TITLE 'Excluir'      ACTION 'VIEWDEF.MVCSZ7'   OPERATION 5 ACCESS 0

//1- pesquisar
//2- visualizar
//3- incluir
//4- alterar
//5- excluir
//6- outras fun��es
//7- copiar
*/

/*Terceira Op��o de Menu
Local aRotina := {}

ADD OPTION aRotina TITLE 'Visualizar'   ACTION 'VIEWDEF.MVCSZ7'  OPERATION  MODEL_OPERATION_VIEW      ACCESS 0
ADD OPTION aRotina TITLE 'Incluir'      ACTION 'VIEWDEF.MVCSZ7'  OPERATION  MODEL_OPERATION_INSERT    ACCESS 0
ADD OPTION aRotina TITLE 'Alterar'      ACTION 'VIEWDEF.MVCSZ7'  OPERATION  MODEL_OPERATION_UPDATE    ACCESS 0
ADD OPTION aRotina TITLE 'Excluir'      ACTION 'VIEWDEF.MVCSZ7'  OPERATION  MODEL_OPERATION_DELETE    ACCESS 0
*/

Return aRotina


Static Function ModelDef()
//Objeto respons�vel pela CRIA��O da estrutura TEMPOR�RIA do cabe�alho 
Local oStCabec      := FWFormModelStruct():New()

//Objeto respons�vel pela estrutura dos itens
Local oStItens      := FwFormStruct(1,"SZ7") //1 para model 2 para view

Local bVldPos       := {|| u_VldSZ7()} //Chamada da User Function Pos Validation que validar� a inclus�o ANTES DE IR PARA A INSER��O DOS ITENS DO GRID

Local bVldCom       := {|| u_GrvSZ7()} //Chamada da User Function Commit que validar� a INCLUS�O/ALTERA��O/EXCLUS�O dos itens


/*Objeto principal do desenvolvimento em MVC MODELO2, ele traz as caracter�sticas do dicion�rio de dados
bem como � o respons�vel pela estrutura de tabelas, campos e registros*/
Local oModel        := MPFormModel():New("MVCSZ7m",/*bPre*/, bVldPos /*bPos*/, bVldCom /*bCommit*/,/*bCancel*/)

//Vari�veis que armazenar�o a estrutura da trigger dos campos quantidade e pre�o, que ir� gerar o conte�do do campo TOTAL automaticamente
Local aTrigQuant    :=  {}
Local aTrgPreco     :=  {}

//Cria��o da tabela tempor�ria que ser� utilizada no cabe�alho
oStCabec:AddTable("SZ7",{"Z7_FILIAL","Z7_NUM","Z7_ITEM"},"Cabe�alho SZ7")

//Cria��o dos campos da tabela tempor�ria
oStCabec:AddField(;
    "Filial",;                                                                                  // [01]  C   Titulo do campo
    "Filial",;                                                                                  // [02]  C   ToolTip do campo
    "Z7_FILIAL",;                                                                               // [03]  C   Id do Field
    "C",;                                                                                       // [04]  C   Tipo do campo
    TamSX3("Z7_FILIAL")[1],;                                                                    // [05]  N   Tamanho do campo
    0,;                                                                                         // [06]  N   Decimal do campo
    Nil,;                                                                                       // [07]  B   Code-block de valida��o do campo
    Nil,;                                                                                       // [08]  B   Code-block de valida��o When do campo
    {},;                                                                                        // [09]  A   Lista de valores permitido do campo
    .F.,;                                                                                       // [10]  L   Indica se o campo tem preenchimento obrigat�rio
    FwBuildFeature( STRUCT_FEATURE_INIPAD, "Iif(!INCLUI,SZ7->Z7_FILIAL,FWxFilial('SZ7'))" ),;   // [11]  B   Code-block de inicializacao do campo
    .T.,;                                                                                       // [12]  L   Indica se trata-se de um campo chave
    .F.,;                                                                                       // [13]  L   Indica se o campo pode receber valor em uma opera��o de update.
    .F.)                                                                                        // [14]  L   Indica se o campo � virtual

oStCabec:AddField(;
    "Pedido",;                                                                                  // [01]  C   Titulo do campo
    "Pedido",;                                                                                  // [02]  C   ToolTip do campo
    "Z7_NUM",;                                                                                  // [03]  C   Id do Field
    "C",;                                                                                       // [04]  C   Tipo do campo
    TamSX3("Z7_NUM")[1],;                                                                       // [05]  N   Tamanho do campo
    0,;                                                                                         // [06]  N   Decimal do campo
    Nil,;                                                                                       // [07]  B   Code-block de valida��o do campo
    Nil,;                                                                                       // [08]  B   Code-block de valida��o When do campo
    {},;                                                                                        // [09]  A   Lista de valores permitido do campo
    .F.,;                                                                                       // [10]  L   Indica se o campo tem preenchimento obrigat�rio
    FwBuildFeature( STRUCT_FEATURE_INIPAD, 'Iif(!INCLUI,SZ7->Z7_NUM,GetSXENum("SZ7","Z7_NUM"))'),;                    // [11]  B   Code-block de inicializacao do campo
    .T.,;                                                                                       // [12]  L   Indica se trata-se de um campo chave
    .F.,;                                                                                       // [13]  L   Indica se o campo pode receber valor em uma opera��o de update.
    .F.)                                                                                        // [14]  L   Indica se o campo � virtual

oStCabec:AddField(;
    "Emissao",;                                                                     // [01]  C   Titulo do campo
    "Emissao",;                                                                     // [02]  C   ToolTip do campo
    "Z7_EMISSAO",;                                                                  // [03]  C   Id do Field
    "D",;                                                                           // [04]  C   Tipo do campo
    TamSX3("Z7_EMISSAO")[1],;                                                       // [05]  N   Tamanho do campo
    0,;                                                                             // [06]  N   Decimal do campo
    Nil,;                                                                           // [07]  B   Code-block de valida��o do campo
    Nil,;                                                                           // [08]  B   Code-block de valida��o When do campo
    {},;                                                                            // [09]  A   Lista de valores permitido do campo
    .T.,;                                                                           // [10]  L   Indica se o campo tem preenchimento obrigat�rio
    FwBuildFeature( STRUCT_FEATURE_INIPAD, "Iif(!INCLUI,SZ7->Z7_EMISSAO,dDataBase)" ),;    // [11]  B   Code-block de inicializacao do campo
    .T.,;                                                                           // [12]  L   Indica se trata-se de um campo chave
    .F.,;                                                                           // [13]  L   Indica se o campo pode receber valor em uma opera��o de update.
    .F.)                                                                            // [14]  L   Indica se o campo � virtual


oStCabec:AddField(;
    "Fornecedor",;                                                              // [01]  C   Titulo do campo
    "Fornecedor",;                                                              // [02]  C   ToolTip do campo
    "Z7_FORNECE",;                                                              // [03]  C   Id do Field
    "C",;                                                                       // [04]  C   Tipo do campo
    TamSX3("Z7_FORNECE")[1],;                                                   // [05]  N   Tamanho do campo
    0,;                                                                         // [06]  N   Decimal do campo
    Nil,;                                                                       // [07]  B   Code-block de valida��o do campo
    Nil,;                                                                       // [08]  B   Code-block de valida��o When do campo
    {},;                                                                        // [09]  A   Lista de valores permitido do campo
    .T.,;                                                                       // [10]  L   Indica se o campo tem preenchimento obrigat�rio
    FwBuildFeature( STRUCT_FEATURE_INIPAD, "Iif(!INCLUI,SZ7->Z7_FORNECE,'')" ),;// [11]  B   Code-block de inicializacao do campo
    .F.,;                                                                       // [12]  L   Indica se trata-se de um campo chave
    .F.,;                                                                       // [13]  L   Indica se o campo pode receber valor em uma opera��o de update.
    .F.)                                                                        // [14]  L   Indica se o campo � virtual

oStCabec:AddField(;
    "Loja",;                                                                      // [01]  C   Titulo do campo
    "Loja",;                                                                      // [02]  C   ToolTip do campo
    "Z7_LOJA",;                                                                   // [03]  C   Id do Field
    "C",;                                                                         // [04]  C   Tipo do campo
    TamSX3("Z7_LOJA")[1],;                                                        // [05]  N   Tamanho do campo
    0,;                                                                           // [06]  N   Decimal do campo
    Nil,;                                                                         // [07]  B   Code-block de valida��o do campo
    Nil,;                                                                         // [08]  B   Code-block de valida��o When do campo
    {},;                                                                          // [09]  A   Lista de valores permitido do campo
    .T.,;                                                                         // [10]  L   Indica se o campo tem preenchimento obrigat�rio
    FwBuildFeature( STRUCT_FEATURE_INIPAD, "Iif(!INCLUI,SZ7->Z7_LOJA,'')" ),;     // [11]  B   Code-block de inicializacao do campo
    .F.,;                                                                         // [12]  L   Indica se trata-se de um campo chave
    .F.,;                                                                         // [13]  L   Indica se o campo pode receber valor em uma opera��o de update.
    .F.)                                                                          // [14]  L   Indica se o campo � virtual

oStCabec:AddField(;
    "Usuario",;                                                                     // [01]  C   Titulo do campo
    "Usuario",;                                                                     // [02]  C   ToolTip do campo
    "Z7_USER",;                                                                     // [03]  C   Id do Field
    "C",;                                                                           // [04]  C   Tipo do campo
    TamSX3("Z7_USER")[1],;                                                          // [05]  N   Tamanho do campo
    0,;                                                                             // [06]  N   Decimal do campo
    Nil,;                                                                           // [07]  B   Code-block de valida��o do campo
    Nil,;                                                                           // [08]  B   Code-block de valida��o When do campo
    {},;                                                                            // [09]  A   Lista de valores permitido do campo
    .T.,;                                                                           // [10]  L   Indica se o campo tem preenchimento obrigat�rio
    FwBuildFeature( STRUCT_FEATURE_INIPAD, "Iif(!INCLUI,SZ7->Z7_USER,__cuserid)" ),;// [11]  B   Code-block de inicializacao do campo
    .F.,;                                                                           // [12]  L   Indica se trata-se de um campo chave
    .F.,;                                                                           // [13]  L   Indica se o campo pode receber valor em uma opera��o de update.
    .F.)                                                                            // [14]  L   Indica se o campo � virtual

//Agora vamos tratar a estrutura dos Itens, que ser�o utilizados no Grid da aplica��o

//Modificando Inicializadores Padrao,  para n�o dar mensagem de colunas vazias
oStItens:SetProperty("Z7_NUM",      MODEL_FIELD_INIT, FwBuildFeature(STRUCT_FEATURE_INIPAD, '"*"'))
oStItens:SetProperty("Z7_USER",     MODEL_FIELD_INIT, FwBuildFeature(STRUCT_FEATURE_INIPAD, '__cUserId')) //Trazer o usu�rio automatico
oStItens:SetProperty("Z7_EMISSAO",  MODEL_FIELD_INIT, FwBuildFeature(STRUCT_FEATURE_INIPAD, 'dDatabase')) //Trazer a data autom�tica
oStItens:SetProperty("Z7_FORNECE",  MODEL_FIELD_INIT, FwBuildFeature(STRUCT_FEATURE_INIPAD, '"*"'))
oStItens:SetProperty("Z7_LOJA",     MODEL_FIELD_INIT, FwBuildFeature(STRUCT_FEATURE_INIPAD, '"*"'))

/*Chamo a fun��o FwStruTrigger para montar o bloco de c�digo da Trigger, esse bloco de c�digo
ir� para dentro do array, e logo em seguida eu usarei 4 posi��es do array para criar a trigger
dentr o do oStItens(objeto de itens do meu grid)
*/
aTrigQuant  := FwStruTrigger(;
"Z7_QUANT",; //Campo que ir� disparar o gatilho/trigger
"Z7_TOTAL",; //Campo que ir� receber o conte�do disparado
"M->Z7_QUANT * M->Z7_PRECO",; //Conte�do que ir� para o campo Z7_TOTAL
.F.)

aTrigPreco  := FwStruTrigger(;
"Z7_PRECO",; //Campo que ir� disparar o gatilho/trigger
"Z7_TOTAL",; //Campo que ir� receber o conte�do disparado
"M->Z7_QUANT * M->Z7_PRECO",; //Conte�do que ir� para o campo Z7_TOTAL
.F.)


//Adiciono as Triggers � minha estrutura de Itens
oStItens:AddTrigger(;
aTrigQuant[1],;
aTrigQuant[2],;
aTrigQuant[3],;
aTrigQuant[4])

oStItens:AddTrigger(;
aTrigPreco[1],;
aTrigPreco[2],;
aTrigPreco[3],;
aTrigPreco[4])


/*A partir de agora, eu fa�o a uni�o das estruturas, vinculando o cabe�alho com os itens
tamb�m fa�o a vincula��o da Estrutura de dados dos itens, ao modelo
*/
oModel:AddFields("SZ7MASTER",,oStCabec) //Fa�o a vincula��o com o oStCabe(cabe�alho e itens tempor�rios)
oModel:AddGrid("SZ7DETAIL","SZ7MASTER",oStItens,,,,,)

/*ADICIONANDO MODEL DE TOTALIZADORES � APLICA��O*/
        /*       IDMODELO       MASTER         DETALHE       CAMPOCALCULADO   NOMEPERSONALIZADO DO CAMPO      OPERACAO   NOMETOTALIZADOR   */
oModel:AddCalc("SZ7TOTAIS",     "SZ7MASTER",   "SZ7DETAIL",  "Z7_PRODUTO",    "QTDITENS",                    "COUNT",,, "N�mero de Produtos")
oModel:AddCalc("SZ7TOTAIS",     "SZ7MASTER",   "SZ7DETAIL",  "Z7_QUANT",      "QTDTOTAL",                    "SUM"  ,,, "Total de Itens")
oModel:AddCalc("SZ7TOTAIS",     "SZ7MASTER",   "SZ7DETAIL",  "Z7_TOTAL",      "PRCTOTAL",                    "SUM"  ,,, "Pre�o total da Solicita��o de Compras")

//Seto a rela��o entre cabe�aho e item, neste ponto, eu digo atrav�s de qual/quais campo(s) o grid est� vinculado com o cabe�alho
aRelations := {}
aAdd(aRelations,{"Z7_FILIAL",'Iif(!INCLUI, SZ7->Z7_FILIAL, FWxFilial("SZ7"))'})
aAdd(aRelations,{"Z7_NUM","SZ7->Z7_NUM"})
oModel:SetRelation("SZ7DETAIL",aRelations,SZ7->(IndexKey(1)))

oModel:SetRelation('SZ7DETAIL',{{'Z7_FILIAL','Iif(!INCLUI, SZ7->Z7_FILIAL, FWxFilial("SZ7"))'},{'Z7_NUM','SZ7->Z7_NUM'}},SZ7->(IndexKey(1)))

//Seto a chave prim�ria, lembrando que, se ela estiver definida no X2_UNICO, faz valer o que est� no X2_UNICO
oModel:SetPrimaryKey({})

//� como se fosse a "chave prim�ria do GRID"
oModel:GetModel("SZ7DETAIL"):SetUniqueline({"Z7_ITEM"}) //o intuito � que este campo n�o se repita

//Setamos a descri��o/t�tulo que aparecer� no cabe�alho 
oModel:GetModel("SZ7MASTER"):SetDescription("CABE�ALHO DA SOLICITA��O DE COMPRAS")

//Setamos a descri��o/t�tulo que aparecer� no GRID DE ITENS
oModel:GetModel("SZ7DETAIL"):SetDescription("ITENS DA SOLICITA��O DE COMPRAS")

//Finalizamos a fun��o model
oModel:GetModel("SZ7DETAIL"):SetUseOldGrid(.T.) //Finalizo setando o modelo antigo de Grid, que permite pegar aHeader e aCols

Return oModel

Static Function ViewDef()
Local oView         := Nil

/*Fa�o o Load do Movel re	ferente � fun��o/fonte MVCSZ7, sendo assim se este Model
 estivesse em um outro fonte eu poderia pegar de l�, sem ter que copiar tudooo de novo
 */
Local oModel        := FwLoadModel("MVCSZ7")

//Objeto encarregado de montar a estrutura tempor�ria do cabe�alho da View
Local oStCabec      := FwFormViewStruct():New()

/* Objeto respons�vel por montar a parte de estrutura dos itens/grid
Como estou usando FwFormStruct, ele traz a estrutura de TODOS OS CAMPOS, sendo assim
caso eu n�o queira que algum campo, apare�a na minha grid, eu devo remover este campo com RemoveField
*/
Local oStItens      := FwFormStruct(2,"SZ7") //1 para model 2 para view

//Criar estrutura de dados para totalizadores
Local oStTotais     := FWCalcStruct( oModel:GetModel('SZ7TOTAIS') )

//Crio dentro da estrutura da View, os campos do cabe�alho

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
    .F.,;    	// [10]  L   Indica se o campo � alteravel
    Nil,;                       // [11]  C   Pasta do campo
    Nil,;                       // [12]  C   Agrupamento do campo
    Nil,;                       // [13]  A   Lista de valores permitido do campo (Combo)
    Nil,;                       // [14]  N   Tamanho maximo da maior op��o do combo
    Nil,;                       // [15]  C   Inicializador de Browse
    Nil,;                       // [16]  L   Indica se o campo � virtual
    Nil,;                       // [17]  C   Picture Variavel
    Nil)                        // [18]  L   Indica pulo de linha ap�s o campo

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
    Iif(INCLUI, .T., .F.),;     // [10]  L   Indica se o campo � alteravel
    Nil,;                       // [11]  C   Pasta do campo
    Nil,;                       // [12]  C   Agrupamento do campo
    Nil,;                       // [13]  A   Lista de valores permitido do campo (Combo)
    Nil,;                       // [14]  N   Tamanho maximo da maior op��o do combo
    Nil,;                       // [15]  C   Inicializador de Browse
    Nil,;                       // [16]  L   Indica se o campo � virtual
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
    .T.,;                             // [10]  L   Indica se o campo � alteravel
    Nil,;                           // [11]  C   Pasta do campo
    Nil,;                           // [12]  C   Agrupamento do campo
    Nil,;                           // [13]  A   Lista de valores permitido do campo (Combo)
    Nil,;                           // [14]  N   Tamanho maximo da maior op��o do combo
    Nil,;                           // [15]  C   Inicializador de Browse
    Nil,;                           // [16]  L   Indica se o campo � virtual
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
    Iif(INCLUI, .T., .F.),;     // [10]  L   Indica se o campo � alteravel
    Nil,;                       // [11]  C   Pasta do campo
    Nil,;                       // [12]  C   Agrupamento do campo
    Nil,;                       // [13]  A   Lista de valores permitido do campo (Combo)
    Nil,;                       // [14]  N   Tamanho maximo da maior op��o do combo
    Nil,;                       // [15]  C   Inicializador de Browse
    Nil,;                       // [16]  L   Indica se o campo � virtual
    Nil,;                       // [17]  C   Picture Variavel
    Nil)

oStCabec:AddField(;
    "Z7_USER",;                 // [01]  C   Nome do Campo
    "05",;                      // [02]  C   Ordem
    "Usu�rio",;                 // [03]  C   Titulo do campo
    X3Descric('Z7_USER'),;      // [04]  C   Descricao do campo
    Nil,;                       // [05]  A   Array com Help
    "C",;                       // [06]  C   Tipo do campo
    X3Picture("Z7_USER"),;      // [07]  C   Picture
    Nil,;                       // [08]  B   Bloco de PictTre Var
    Nil,;                       // [09]  C   Consulta F3
    .F.,;                       // [10]  L   Indica se o campo � alteravel
    Nil,;                       // [11]  C   Pasta do campo
    Nil,;                       // [12]  C   Agrupamento do campo
    Nil,;                       // [13]  A   Lista de valores permitido do campo (Combo)
    Nil,;                       // [14]  N   Tamanho maximo da maior op��o do combo
    Nil,;                       // [15]  C   Inicializador de Browse
    Nil,;                       // [16]  L   Indica se o campo � virtual
    Nil,;                       // [17]  C   Picture Variavel
    Nil) 

oStItens:RemoveField("Z7_NUM")
oStItens:RemoveField("Z7_EMISSAO")
oStItens:RemoveField("Z7_FORNECE")            
oStItens:RemoveField("Z7_LOJA")      
oStItens:RemoveField("Z7_USER") 

//Bloqueando a edi��o dos campos ITEM e Total(pois eles s�o preenchidos automaticamente)
oStItens:SetProperty("Z7_ITEM",     MVC_VIEW_CANCHANGE, .F. )
oStItens:SetProperty("Z7_TOTAL",    MVC_VIEW_CANCHANGE, .F.)


/*Agora vamos para a segunda parte da ViewDef, onde n�s amarramos as estruturas de dados, montadas acima
com o objeto oView, e passamos para a nossa aplica��o todas as caracter�sticas visuais do projetos
*/

//Instancio a classe FwFormView para o objeto view
oView := FwFormView():New()

//Passo para o objeto View o modelo de dados que quero atrelar � ele Modelo + Visualiza��o
oView:SetModel(oModel)

//Monto a estrutura de visualiza��o do Master e do Detalhe (Cabe�alho e Itens)
oView:AddField("VIEW_SZ7M",oStCabec,"SZ7MASTER") //Crio a view do Cabe�alho/Master
oView:AddGrid("VIEW_SZ7D", oStItens,"SZ7DETAIL") //Crio a View dos Itens/Grid

oView:AddField("VIEW_TOTAL",oStTotais,"SZ7TOTAIS") //Parte que cria a view dos totalizadores

//Deixando o campo Item da solicita��o de compras INCREMENTAL
oView:AddIncrementField("SZ7DETAIL","Z7_ITEM") //Soma 1 ao campo de Item

//Criamos a telinha, dividindo proporcionalmente o tamanho do cabe�alho e o tamanho do Grid
oView:CreateHorizontalBox("CABEC",20) //Percentual de ocupa��o da tela de Cabe�alho
oView:CreateHorizontalBox("GRID", 50) //Percentual de ocupa��o da tela do GRID
oView:CreateHorizontalBox("TOTAL",30) //Percentual de ocupa��o da tela dos TOTALIZADORES

/*Abaixo, digo para onde v�o cada View Criada, VIEW_SZ7M ir� para a cabec
VIEW_SZ7D ir� para GRID... Sendo assim, eu associo o View � cada Box criado
*/
oView:SetOwnerView("VIEW_SZ7M","CABEC")  //Relaciono a View do master com o percentual de tela do CABE�ALHO
oView:SetOwnerView("VIEW_SZ7D","GRID")  //Relaciono a View do master com o percentual de tela do ITEM
oView:SetOwnerView("VIEW_TOTAL","TOTAL") //Relacino a view do TOTAL com o percentual de tela dos TOTALIZADORES

//Ativar o t�tulos de cada VIEW/Box criado
oView:EnableTitleView("VIEW_SZ7M","Cabe�alho Solicita��o de Compras")
oView:EnableTitleView("VIEW_SZ7D","Itens de Solicitacao de Compras")
oView:EnableTitleView("VIEW_TOTAL","Resumo da Solicita��o de compras TOTALIZADA")

/*Metodo que seta um bloco de c�digo para verificar se a janela deve ou n�o
ser fechada ap�s a execu��o do bot�o OK.
*/
oView:SetCloseOnOk({|| .T.})

Return oView



/*/{Protheus.doc} User Function GrvSZ7()
    (long_description)
    @type  Function
    @author user
    @since 22/01/2021
    @version version
    @return lRet, logical, Retorna TRUE ou FALSE para INCLUSAO, ALTERA��O E EXCLUS�O
    @example
    (examples)
    @see https://tdn.totvs.com/pages/viewpage.action?pageId=23889360
    @see https://tdn.totvs.com/display/tec/DBSkip
    /*/
User Function GrvSZ7()
Local aArea     := GetArea()  

//Vari�vel de controle da grava��o, por enquanto est� TRUE mas poder� ser FALSE
Local lRet      := .T.

//Capturo o modelo ativo, no caso o objeto de modelo(oModel) que est� sendo manipulado em nossa aplica��o
Local oModel        := FwModelActive()

//Criar modelo de dados MASTER/CABE�ALHO com base no model geral que foi capturado acima
//Carregando o modelo do CABE�ALHO
Local oModelCabec    := oModel:GetModel("SZ7MASTER")

/*Criar modelo de dados DETALHE/ITENS com base no model geral que foi capturado acima
Carregando o modelo dos ITENS
Este modelo ser� respons�vel, pela estrutura do aHeader aCols da Grid
*/
Local oModelItem     := oModel:GetModel("SZ7DETAIL") 


/*
Capturo os valores que est�o no CABE�ALHO, atrav�s do m�todo GetValue
Carrego os campos dentro das vari�veis, estas vari�veis ser�o utilizadas para
inserir o que foi digitao na tela, dentro do banco
*/
Local cFilSZ7   :=  oModelCabec:GetValue("Z7_FILIAL")
Local cNum      :=  oModelCabec:GetValue("Z7_NUM")
Local dEmissao  :=  oModelCabec:GetValue("Z7_EMISSAO")
Local cFornece  :=  oModelCabec:GetValue("Z7_FORNECE")
Local cLoja     :=  oModelCabec:GetValue("Z7_LOJA")
Local cUser     :=  oModelCabec:GetValue("Z7_USER")

//Vari�veis que far�o a captura dos dados com base no aHeader e aCols
Local aHeaderAux    := oModelItem:aHeader //Captura o aHeader do Grid
Local aColsAux      := oModelItem:aCols   //Captura o aCols do Grid

/*Precisamos agora pegar a posi��o de cada campo dentro do grid
Lembrando que neste caso, s� precisamos pegar a posi��o dos campos que n�o
est�o no cabe�alho, somente os campos da GRID
*/
Local nPosItem      :=  aScan(aHeaderAux, {|x| AllTrim(Upper(x[2])) == AllTrim("Z7_ITEM")})
Local nPosProd      :=  aScan(aHeaderAux, {|x| AllTrim(Upper(x[2])) == AllTrim("Z7_PRODUTO")})
Local nPosQtd       :=  aScan(aHeaderAux, {|x| AllTrim(Upper(x[2])) == AllTrim("Z7_QUANT")})
Local nPosPrc       :=  aScan(aHeaderAux, {|x| AllTrim(Upper(x[2])) == AllTrim("Z7_PRECO")})
Local nPosTotal     :=  aScan(aHeaderAux, {|x| AllTrim(Upper(x[2])) == AllTrim("Z7_TOTAL")})

//Preciso pegar a linha atual que o usu�rio est� posicionado, para isso usarei uma vari�vel
//Esta vari�vel ir� para dentro do FOR
Local nLinAtu       := 0


//Preciso identificar qual o tipo de opera��o que o usu�rio est� fazendo(INCLUS�O/ALTERA��O/EXCLUS�O)
Local cOption       := oModelCabec:GetOperation()

/*Fazemos a sele��o da nossa �rea que ser� manipulada, ou seja, 
colocamos a tabela SZ7, em evid�ncia juntamente com um �ndice de ordena��o

OU SEJA...->>> VOC� FALA PAR A O PROTHEUS O SEGUINTE: 
"-E a� cara a partir de agora eu vou modificar a SZ7"=
*/

DbSelectArea("SZ7")
SZ7->(DbSetOrder(1)) //�NDICE FILIAL+NUMEROPEDIDO


//Se a opera��o que est� sendo feita, for uma inser��o, ele far� a inser��o
IF cOption == MODEL_OPERATION_INSERT
    For nLinAtu:= 1 to Len(aColsAux) //Mede o tamanho do aCOls, ou seja quantos itens existem no grid
        //Por�eeeeeem, antes de tentar inserir, eu devo verificar, se a linha est� deletada
        IF !aColsAux[nLinAtu][Len(aHeaderAux)+1] //Express�o para verificar se uma linha est� exclu�da no aCols(se n�o estiver exclu�da ele prossegue)
            RecLock("SZ7",.T.) //.T. para inclus�o .F. para altera��o/exclus�o
                //DADOS DO CABE�ALHO
                Z7_FILIAL       :=  cFilSZ7 //Vari�vel com o dado da filial no cabe�alho
                Z7_NUM          :=  cNum   //vari�vel com o dado do numero do pedido no cabe�alho
                Z7_EMISSAO      :=  dEmissao
                Z7_FORNECE      :=  cFornece
                Z7_LOJA         :=  cLoja
                Z7_USER         :=  cUser

                //DADOS DO GRID
                Z7_ITEM         :=  aColsAux[nLinAtu,nPosItem] //array acols, posicionado na linha atual
                Z7_PRODUTO      :=  aColsAux[nLinAtu,nPosProd]
                Z7_QUANT        :=  aColsAux[nLinAtu,nPosQtd]
                Z7_PRECO        :=  aColsAux[nLinAtu,nPosPrc]
                Z7_TOTAL        :=  aColsAux[nLinAtu,nPosTotal] 
            SZ7->(MSUNLOCK())
        ENDIF
    Next n //Incremento de linha do for

ELSEIF  cOption == MODEL_OPERATION_UPDATE

    For nLinAtu:= 1 to Len(aColsAux) //Mede o tamanho do aCOls, ou seja quantos itens existem no grid
        //Por�eeeeeem, antes de tentar inserir, eu devo verificar, se a linha est� deletada
        IF aColsAux[nLinAtu][Len(aHeaderAux)+1] //Express�o para verificar se uma linha est� exclu�da no aCols(SE ESTIVER EXCLU�DA ELE VERIFICA SE EST� NO BANCO
            //Se a linha estiver deletada, eu ainda preciso verificar se a linha deletada est� inclusa ou n�o no sistema
            SZ7->(DbSetOrder(2)) //�NDICE FILIAL+NUMEROPEDIDO+ITEM
            IF SZ7->(DbSeek(cFilSZ7 + cNum + aColsAux[nLinAtu,nPosItem])) //Faz a busca, se encontrar, ele deve deletar do banco
                RECLOCK("SZ7",.F.)
                    DbDelete()
                SZ7->(MSUNLOCK())
            ENDIF
        
        ELSE //SE A LINHA N�O ESTIVER EXCLU�DA, FA�O A ALTERA��O
        /*EMBORA SEJA UMA ALTERA��O, EU POSSO TER NOVOS ITENS INCLUSOS NO MEU PEDIDO
        SENDO ASSIM, PRECISO VALIDAR SE ESTES ITENS EXISTEM NO BANCO DE DADOS OU N�O
        CASO ELES N�O EXISTAM, EU FA�O UMA INCLUS�O RECLOCK("SZ7",.T.)
        */
            SZ7->(DbSetOrder(2)) //�NDICE FILIAL+NUMEROPEDIDO+ITEM
            IF SZ7->(DbSeek(cFilSZ7 + cNum + aColsAux[nLinAtu,nPosItem])) //Faz a busca, se encontrar, ele FAR� UMA ALTERA��O
                RecLock("SZ7",.F.) //.T. para inclus�o .F. para altera��o/exclus�o
                    //DADOS DO CABE�ALHO
                    Z7_FILIAL       :=  cFilSZ7 //Vari�vel com o dado da filial no cabe�alho
                    Z7_NUM          :=  cNum   //vari�vel com o dado do numero do pedido no cabe�alho
                    Z7_EMISSAO      :=  dEmissao
                    Z7_FORNECE      :=  cFornece
                    Z7_LOJA         :=  cLoja
                    Z7_USER         :=  cUser
                    //DADOS DO GRID
                    Z7_ITEM         :=  aColsAux[nLinAtu,nPosItem] //array acols, posicionado na linha atual
                    Z7_PRODUTO      :=  aColsAux[nLinAtu,nPosProd]
                    Z7_QUANT        :=  aColsAux[nLinAtu,nPosQtd]
                    Z7_PRECO        :=  aColsAux[nLinAtu,nPosPrc]
                    Z7_TOTAL        :=  aColsAux[nLinAtu,nPosTotal] 
                SZ7->(MSUNLOCK())
            ELSE //SE ELE N�O ACHAR, � PORQUE O ITEM N�O EXISTE AINDA NA BASE DE DADOS, LOGO IR� INCLUIR
                RecLock("SZ7",.T.) //.T. para inclus�o .F. para altera��o/exclus�o
                    //DADOS DO CABE�ALHO
                    Z7_FILIAL       :=  cFilSZ7 //Vari�vel com o dado da filial no cabe�alho
                    Z7_NUM          :=  cNum   //vari�vel com o dado do numero do pedido no cabe�alho
                    Z7_EMISSAO      :=  dEmissao
                    Z7_FORNECE      :=  cFornece
                    Z7_LOJA         :=  cLoja
                    Z7_USER         :=  cUser
                    //DADOS DO GRID
                    Z7_ITEM         :=  aColsAux[nLinAtu,nPosItem] //array acols, posicionado na linha atual
                    Z7_PRODUTO      :=  aColsAux[nLinAtu,nPosProd]
                    Z7_QUANT        :=  aColsAux[nLinAtu,nPosQtd]
                    Z7_PRECO        :=  aColsAux[nLinAtu,nPosPrc]
                    Z7_TOTAL        :=  aColsAux[nLinAtu,nPosTotal] 
                SZ7->(MSUNLOCK())            
            ENDIF        
        ENDIF
    Next n //Incremento de linha do for

ELSEIF cOption == MODEL_OPERATION_DELETE
    SZ7->(DbSetOrder(1)) //FILAL + NUMEROPEDIDO

    /*Ele vai percorrer todo arquivo, e enquanto a filial for igual a do pedido e o n�mero
    do pedido for igual ao n�mero que est� posicionado para exclur(pedido que voc� quer excluir)
    ele far� a DELE��O/EXCLUS�O DO REGISTROS
    */
    WHILE !SZ7->(EOF()) .AND. SZ7->Z7_FILIAL = cFilSZ7 .AND. SZ7->Z7_NUM = cNum 
        RECLOCK("SZ7",.F.) //PARAMETRO FALSE PORQUE � EXCLUS�O
            DbDelete()
        SZ7->(MSUNLOCK())

    SZ7->(dbSkip())
    ENDDO

/* OUTRA FORMA DE EXCLUS�O COM BASE NO QUE EST� NO GRID.
    SZ7->(dbSetOrder(2))
    For nLinAtu := 1 to Len(aColsAux)
        //Regrinha para verificar se a linha está excluída, se não tiver irá incluir
        IF SZ7->(DbSeek(cFilSZ7+cNum+aColsAux[nLinAtu][nPosItem]))
            RECLOCK("SZ7",.F.)
                DbDelete()
            SZ7->(MsUnlock())
        Endif
    Next nLinAtu
*/	


ENDIF  

RestArea(aArea)
return lRet

/*/{Protheus.doc} User Function VldSZ7
    (long_description)
    @type  Function
    @author user
    @since 24/01/2021
    @version version
    @param , param_type, param_descr
    @return lRet, logical, retorno da valida��o de inclus�o do cabe�alho
    @example
    (examples)
    @see (links_or_references)
    /*/
User Function VldSZ7()
//Vari�vel de controle que ir� retornar TRUE se o n�mero de pedido n�o estiver dentro da tabela, ou seja, se n�o existir
Local lRet      :=  .T.
Local aArea     := GetArea()

//Instancio os Models para capturar em seguida os campos digitados no cabe�alho
Local oModel        := FwModelActive()
Local oModelCabec    := oModel:GetModel("SZ7MASTER")

Local cFilSZ7   :=  oModelCabec:GetValue("Z7_FILIAL")
Local cNum      :=  oModelCabec:GetValue("Z7_NUM")

Local cOption   := oModelCabec:GetOperation()

IF cOption  == MODEL_OPERATION_INSERT
    DbSelectArea("SZ7")
    SZ7->(DbSetOrder(1)) //�NDICE FILIAL+NUMEROPEDIDO

    //Se ele encontrar o n�mero de pedido na tabela, a vari�vel lRet retornar� FALSE .F. e impedir� a inser��o
    IF SZ7->(DbSeek(cFilSZ7+cNum))
        //Use o HELP, pois usando o Alert e MsgInfo, ele aparece uma mensagem de erro
        Help(NIL, NIL, "Escolha outro n�mero de pedido", NIL, "Este pedido/solicita��o de compras j� existe em nosso sistema", 1, 0, NIL, NIL, NIL, NIL, NIL, {"ATEN��O"})			
        lRet        := .F.
    Endif
ENDIF

RestArea(aArea)
Return lRet
