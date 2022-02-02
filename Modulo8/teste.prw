#include 'Protheus.ch'
#include 'FwMvcDef.ch'

User Function MVCSZ7()
Local aArea     := GetArea()
Local oBrowse   := FwmBrowse():New() 

oBrowse:SetAlias("SZ7")
oBrowse:SetDescription("Solicitação de Compras")

oBrowse:Activate()

RestArea(aArea)

Return 

Static Function MenuDef()

Local aRotina := FwMvcMenu("MVCSZ7")

/*Segunda Opção de Menu
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
//6- outras funções
//7- copiar
*/

/*Terceira Opção de Menu
Local aRotina := {}

ADD OPTION aRotina TITLE 'Visualizar'   ACTION 'VIEWDEF.MVCSZ7'  OPERATION  MODEL_OPERATION_VIEW      ACCESS 0
ADD OPTION aRotina TITLE 'Incluir'      ACTION 'VIEWDEF.MVCSZ7'  OPERATION  MODEL_OPERATION_INSERT    ACCESS 0
ADD OPTION aRotina TITLE 'Alterar'      ACTION 'VIEWDEF.MVCSZ7'  OPERATION  MODEL_OPERATION_UPDATE    ACCESS 0
ADD OPTION aRotina TITLE 'Excluir'      ACTION 'VIEWDEF.MVCSZ7'  OPERATION  MODEL_OPERATION_DELETE    ACCESS 0
*/

Return aRotina


Static Function ModelDef()
//Objeto responsável pela CRIAÇÃO da estrutura TEMPORÁRIA do cabeçalho 
Local oStCabec      := FWFormModelStruct():New()

//Objeto responsável pela estrutura dos itens
Local oStItens      := FwFormStruct(1,"SZ7") //1 para model 2 para view

Local bVldPos       := {|| u_VldSZ7()} //Chamada da User Function Pos Validation que validará a inclusão ANTES DE IR PARA A INSERÇÃO DOS ITENS DO GRID

Local bVldCom       := {|| u_GrvSZ7()} //Chamada da User Function Commit que validará a INCLUSÃO/ALTERAÇÃO/EXCLUSÃO dos itens


/*Objeto principal do desenvolvimento em MVC MODELO2, ele traz as características do dicionário de dados
bem como é o responsável pela estrutura de tabelas, campos e registros*/
Local oModel        := MPFormModel():New("MVCSZ7m",/*bPre*/, bVldPos /*bPos*/, bVldCom /*bCommit*/,/*bCancel*/)

//Variáveis que armazenarão a estrutura da trigger dos campos quantidade e preço, que irá gerar o conteúdo do campo TOTAL automaticamente
Local aTrigQuant    :=  {}
Local aTrgPreco     :=  {}

//Criação da tabela temporária que será utilizada no cabeçalho
oStCabec:AddTable("SZ7",{"Z7_FILIAL","Z7_NUM","Z7_ITEM"},"Cabeçalho SZ7")

//Criação dos campos da tabela temporária
oStCabec:AddField(;
    "Filial",;                                                                                  // [01]  C   Titulo do campo
    "Filial",;                                                                                  // [02]  C   ToolTip do campo
    "Z7_FILIAL",;                                                                               // [03]  C   Id do Field
    "C",;                                                                                       // [04]  C   Tipo do campo
    TamSX3("Z7_FILIAL")[1],;                                                                    // [05]  N   Tamanho do campo
    0,;                                                                                         // [06]  N   Decimal do campo
    Nil,;                                                                                       // [07]  B   Code-block de validação do campo
    Nil,;                                                                                       // [08]  B   Code-block de validação When do campo
    {},;                                                                                        // [09]  A   Lista de valores permitido do campo
    .F.,;                                                                                       // [10]  L   Indica se o campo tem preenchimento obrigatório
    FwBuildFeature( STRUCT_FEATURE_INIPAD, "Iif(!INCLUI,SZ7->Z7_FILIAL,FWxFilial('SZ7'))" ),;   // [11]  B   Code-block de inicializacao do campo
    .T.,;                                                                                       // [12]  L   Indica se trata-se de um campo chave
    .F.,;                                                                                       // [13]  L   Indica se o campo pode receber valor em uma operação de update.
    .F.)                                                                                        // [14]  L   Indica se o campo é virtual

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

/*Chamo a função FwStruTrigger para montar o bloco de código da Trigger, esse bloco de código
irá para dentro do array, e logo em seguida eu usarei 4 posições do array para criar a trigger
dentr o do oStItens(objeto de itens do meu grid)
*/
aTrigQuant  := FwStruTrigger(;
"Z7_QUANT",; //Campo que irá disparar o gatilho/trigger
"Z7_TOTAL",; //Campo que irá receber o conteúdo disparado
"M->Z7_QUANT * M->Z7_PRECO",; //Conteúdo que irá para o campo Z7_TOTAL
.F.)

aTrigPreco  := FwStruTrigger(;
"Z7_PRECO",; //Campo que irá disparar o gatilho/trigger
"Z7_TOTAL",; //Campo que irá receber o conteúdo disparado
"M->Z7_QUANT * M->Z7_PRECO",; //Conteúdo que irá para o campo Z7_TOTAL
.F.)


//Adiciono as Triggers à minha estrutura de Itens
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


/*A partir de agora, eu faço a união das estruturas, vinculando o cabeçalho com os itens
também faço a vinculação da Estrutura de dados dos itens, ao modelo
*/
oModel:AddFields("SZ7MASTER",,oStCabec) //Faço a vinculação com o oStCabe(cabeçalho e itens temporários)
oModel:AddGrid("SZ7DETAIL","SZ7MASTER",oStItens,,,,,)

/*ADICIONANDO MODEL DE TOTALIZADORES Á APLICAÇÃO*/
        /*       IDMODELO       MASTER         DETALHE       CAMPOCALCULADO   NOMEPERSONALIZADO DO CAMPO      OPERACAO   NOMETOTALIZADOR   */
oModel:AddCalc("SZ7TOTAIS",     "SZ7MASTER",   "SZ7DETAIL",  "Z7_PRODUTO",    "QTDITENS",                    "COUNT",,, "Número de Produtos")
oModel:AddCalc("SZ7TOTAIS",     "SZ7MASTER",   "SZ7DETAIL",  "Z7_QUANT",      "QTDTOTAL",                    "SUM"  ,,, "Total de Itens")
oModel:AddCalc("SZ7TOTAIS",     "SZ7MASTER",   "SZ7DETAIL",  "Z7_TOTAL",      "PRCTOTAL",                    "SUM"  ,,, "Preço total da Solicitação de Compras")

//Seto a relação entre cabeçaho e item, neste ponto, eu digo através de qual/quais campo(s) o grid está vinculado com o cabeçalho
aRelations := {}
aAdd(aRelations,{"Z7_FILIAL",'Iif(!INCLUI, SZ7->Z7_FILIAL, FWxFilial("SZ7"))'})
aAdd(aRelations,{"Z7_NUM","SZ7->Z7_NUM"})
oModel:SetRelation("SZ7DETAIL",aRelations,SZ7->(IndexKey(1)))

oModel:SetRelation('SZ7DETAIL',{{'Z7_FILIAL','Iif(!INCLUI, SZ7->Z7_FILIAL, FWxFilial("SZ7"))'},{'Z7_NUM','SZ7->Z7_NUM'}},SZ7->(IndexKey(1)))

//Seto a chave primária, lembrando que, se ela estiver definida no X2_UNICO, faz valer o que está no X2_UNICO
oModel:SetPrimaryKey({})

//É como se fosse a "chave primária do GRID"
oModel:GetModel("SZ7DETAIL"):SetUniqueline({"Z7_ITEM"}) //o intuito é que este campo não se repita

//Setamos a descrição/título que aparecerá no cabeçalho 
oModel:GetModel("SZ7MASTER"):SetDescription("CABEÇALHO DA SOLICITAÇÃO DE COMPRAS")

//Setamos a descrição/título que aparecerá no GRID DE ITENS
oModel:GetModel("SZ7DETAIL"):SetDescription("ITENS DA SOLICITAÇÃO DE COMPRAS")

//Finalizamos a função model
oModel:GetModel("SZ7DETAIL"):SetUseOldGrid(.T.) //Finalizo setando o modelo antigo de Grid, que permite pegar aHeader e aCols

Return oModel

Static Function ViewDef()
Local oView         := Nil

/*Faço o Load do Movel re	ferente à função/fonte MVCSZ7, sendo assim se este Model
 estivesse em um outro fonte eu poderia pegar de lá, sem ter que copiar tudooo de novo
 */
Local oModel        := FwLoadModel("MVCSZ7")

//Objeto encarregado de montar a estrutura temporária do cabeçalho da View
Local oStCabec      := FwFormViewStruct():New()

/* Objeto responsável por montar a parte de estrutura dos itens/grid
Como estou usando FwFormStruct, ele traz a estrutura de TODOS OS CAMPOS, sendo assim
caso eu não queira que algum campo, apareça na minha grid, eu devo remover este campo com RemoveField
*/
Local oStItens      := FwFormStruct(2,"SZ7") //1 para model 2 para view

//Criar estrutura de dados para totalizadores
Local oStTotais     := FWCalcStruct( oModel:GetModel('SZ7TOTAIS') )

//Crio dentro da estrutura da View, os campos do cabeçalho

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

//Bloqueando a edição dos campos ITEM e Total(pois eles são preenchidos automaticamente)
oStItens:SetProperty("Z7_ITEM",     MVC_VIEW_CANCHANGE, .F. )
oStItens:SetProperty("Z7_TOTAL",    MVC_VIEW_CANCHANGE, .F.)


/*Agora vamos para a segunda parte da ViewDef, onde nós amarramos as estruturas de dados, montadas acima
com o objeto oView, e passamos para a nossa aplicação todas as características visuais do projetos
*/

//Instancio a classe FwFormView para o objeto view
oView := FwFormView():New()

//Passo para o objeto View o modelo de dados que quero atrelar à ele Modelo + Visualização
oView:SetModel(oModel)

//Monto a estrutura de visualização do Master e do Detalhe (Cabeçalho e Itens)
oView:AddField("VIEW_SZ7M",oStCabec,"SZ7MASTER") //Crio a view do Cabeçalho/Master
oView:AddGrid("VIEW_SZ7D", oStItens,"SZ7DETAIL") //Crio a View dos Itens/Grid

oView:AddField("VIEW_TOTAL",oStTotais,"SZ7TOTAIS") //Parte que cria a view dos totalizadores

//Deixando o campo Item da solicitação de compras INCREMENTAL
oView:AddIncrementField("SZ7DETAIL","Z7_ITEM") //Soma 1 ao campo de Item

//Criamos a telinha, dividindo proporcionalmente o tamanho do cabeçalho e o tamanho do Grid
oView:CreateHorizontalBox("CABEC",20) //Percentual de ocupação da tela de Cabeçalho
oView:CreateHorizontalBox("GRID", 50) //Percentual de ocupação da tela do GRID
oView:CreateHorizontalBox("TOTAL",30) //Percentual de ocupação da tela dos TOTALIZADORES

/*Abaixo, digo para onde vão cada View Criada, VIEW_SZ7M irá para a cabec
VIEW_SZ7D irá para GRID... Sendo assim, eu associo o View à cada Box criado
*/
oView:SetOwnerView("VIEW_SZ7M","CABEC")  //Relaciono a View do master com o percentual de tela do CABEÇALHO
oView:SetOwnerView("VIEW_SZ7D","GRID")  //Relaciono a View do master com o percentual de tela do ITEM
oView:SetOwnerView("VIEW_TOTAL","TOTAL") //Relacino a view do TOTAL com o percentual de tela dos TOTALIZADORES

//Ativar o títulos de cada VIEW/Box criado
oView:EnableTitleView("VIEW_SZ7M","Cabeçalho Solicitação de Compras")
oView:EnableTitleView("VIEW_SZ7D","Itens de Solicitacao de Compras")
oView:EnableTitleView("VIEW_TOTAL","Resumo da Solicitação de compras TOTALIZADA")

/*Metodo que seta um bloco de código para verificar se a janela deve ou não
ser fechada após a execução do botão OK.
*/
oView:SetCloseOnOk({|| .T.})

Return oView



/*/{Protheus.doc} User Function GrvSZ7()
    (long_description)
    @type  Function
    @author user
    @since 22/01/2021
    @version version
    @return lRet, logical, Retorna TRUE ou FALSE para INCLUSAO, ALTERAÇÃO E EXCLUSÃO
    @example
    (examples)
    @see https://tdn.totvs.com/pages/viewpage.action?pageId=23889360
    @see https://tdn.totvs.com/display/tec/DBSkip
    /*/
User Function GrvSZ7()
Local aArea     := GetArea()  

//Variável de controle da gravação, por enquanto está TRUE mas poderá ser FALSE
Local lRet      := .T.

//Capturo o modelo ativo, no caso o objeto de modelo(oModel) que está sendo manipulado em nossa aplicação
Local oModel        := FwModelActive()

//Criar modelo de dados MASTER/CABEÇALHO com base no model geral que foi capturado acima
//Carregando o modelo do CABEÇALHO
Local oModelCabec    := oModel:GetModel("SZ7MASTER")

/*Criar modelo de dados DETALHE/ITENS com base no model geral que foi capturado acima
Carregando o modelo dos ITENS
Este modelo será responsável, pela estrutura do aHeader aCols da Grid
*/
Local oModelItem     := oModel:GetModel("SZ7DETAIL") 


/*
Capturo os valores que estão no CABEÇALHO, através do método GetValue
Carrego os campos dentro das variáveis, estas variáveis serão utilizadas para
inserir o que foi digitao na tela, dentro do banco
*/
Local cFilSZ7   :=  oModelCabec:GetValue("Z7_FILIAL")
Local cNum      :=  oModelCabec:GetValue("Z7_NUM")
Local dEmissao  :=  oModelCabec:GetValue("Z7_EMISSAO")
Local cFornece  :=  oModelCabec:GetValue("Z7_FORNECE")
Local cLoja     :=  oModelCabec:GetValue("Z7_LOJA")
Local cUser     :=  oModelCabec:GetValue("Z7_USER")

//Variáveis que farão a captura dos dados com base no aHeader e aCols
Local aHeaderAux    := oModelItem:aHeader //Captura o aHeader do Grid
Local aColsAux      := oModelItem:aCols   //Captura o aCols do Grid

/*Precisamos agora pegar a posição de cada campo dentro do grid
Lembrando que neste caso, só precisamos pegar a posição dos campos que não
estão no cabeçalho, somente os campos da GRID
*/
Local nPosItem      :=  aScan(aHeaderAux, {|x| AllTrim(Upper(x[2])) == AllTrim("Z7_ITEM")})
Local nPosProd      :=  aScan(aHeaderAux, {|x| AllTrim(Upper(x[2])) == AllTrim("Z7_PRODUTO")})
Local nPosQtd       :=  aScan(aHeaderAux, {|x| AllTrim(Upper(x[2])) == AllTrim("Z7_QUANT")})
Local nPosPrc       :=  aScan(aHeaderAux, {|x| AllTrim(Upper(x[2])) == AllTrim("Z7_PRECO")})
Local nPosTotal     :=  aScan(aHeaderAux, {|x| AllTrim(Upper(x[2])) == AllTrim("Z7_TOTAL")})

//Preciso pegar a linha atual que o usuário está posicionado, para isso usarei uma variável
//Esta variável irá para dentro do FOR
Local nLinAtu       := 0


//Preciso identificar qual o tipo de operação que o usuário está fazendo(INCLUSÃO/ALTERAÇÃO/EXCLUSÃO)
Local cOption       := oModelCabec:GetOperation()

/*Fazemos a seleção da nossa área que será manipulada, ou seja, 
colocamos a tabela SZ7, em evidência juntamente com um índice de ordenação

OU SEJA...->>> VOCÊ FALA PAR A O PROTHEUS O SEGUINTE: 
"-E aí cara a partir de agora eu vou modificar a SZ7"=
*/

DbSelectArea("SZ7")
SZ7->(DbSetOrder(1)) //ÍNDICE FILIAL+NUMEROPEDIDO


//Se a operação que está sendo feita, for uma inserção, ele fará a inserção
IF cOption == MODEL_OPERATION_INSERT
    For nLinAtu:= 1 to Len(aColsAux) //Mede o tamanho do aCOls, ou seja quantos itens existem no grid
        //Poréeeeeeem, antes de tentar inserir, eu devo verificar, se a linha está deletada
        IF !aColsAux[nLinAtu][Len(aHeaderAux)+1] //Expressão para verificar se uma linha está excluída no aCols(se não estiver excluída ele prossegue)
            RecLock("SZ7",.T.) //.T. para inclusão .F. para alteração/exclusão
                //DADOS DO CABEÇALHO
                Z7_FILIAL       :=  cFilSZ7 //Variável com o dado da filial no cabeçalho
                Z7_NUM          :=  cNum   //variável com o dado do numero do pedido no cabeçalho
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
        //Poréeeeeeem, antes de tentar inserir, eu devo verificar, se a linha está deletada
        IF aColsAux[nLinAtu][Len(aHeaderAux)+1] //Expressão para verificar se uma linha está excluída no aCols(SE ESTIVER EXCLUÍDA ELE VERIFICA SE ESTÁ NO BANCO
            //Se a linha estiver deletada, eu ainda preciso verificar se a linha deletada está inclusa ou não no sistema
            SZ7->(DbSetOrder(2)) //ÍNDICE FILIAL+NUMEROPEDIDO+ITEM
            IF SZ7->(DbSeek(cFilSZ7 + cNum + aColsAux[nLinAtu,nPosItem])) //Faz a busca, se encontrar, ele deve deletar do banco
                RECLOCK("SZ7",.F.)
                    DbDelete()
                SZ7->(MSUNLOCK())
            ENDIF
        
        ELSE //SE A LINHA NÃO ESTIVER EXCLUÍDA, FAÇO A ALTERAÇÃO
        /*EMBORA SEJA UMA ALTERAÇÃO, EU POSSO TER NOVOS ITENS INCLUSOS NO MEU PEDIDO
        SENDO ASSIM, PRECISO VALIDAR SE ESTES ITENS EXISTEM NO BANCO DE DADOS OU NÃO
        CASO ELES NÃO EXISTAM, EU FAÇO UMA INCLUSÃO RECLOCK("SZ7",.T.)
        */
            SZ7->(DbSetOrder(2)) //ÍNDICE FILIAL+NUMEROPEDIDO+ITEM
            IF SZ7->(DbSeek(cFilSZ7 + cNum + aColsAux[nLinAtu,nPosItem])) //Faz a busca, se encontrar, ele FARÁ UMA ALTERAÇÃO
                RecLock("SZ7",.F.) //.T. para inclusão .F. para alteração/exclusão
                    //DADOS DO CABEÇALHO
                    Z7_FILIAL       :=  cFilSZ7 //Variável com o dado da filial no cabeçalho
                    Z7_NUM          :=  cNum   //variável com o dado do numero do pedido no cabeçalho
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
            ELSE //SE ELE NÃO ACHAR, É PORQUE O ITEM NÃO EXISTE AINDA NA BASE DE DADOS, LOGO IRÁ INCLUIR
                RecLock("SZ7",.T.) //.T. para inclusão .F. para alteração/exclusão
                    //DADOS DO CABEÇALHO
                    Z7_FILIAL       :=  cFilSZ7 //Variável com o dado da filial no cabeçalho
                    Z7_NUM          :=  cNum   //variável com o dado do numero do pedido no cabeçalho
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

    /*Ele vai percorrer todo arquivo, e enquanto a filial for igual a do pedido e o número
    do pedido for igual ao número que está posicionado para exclur(pedido que você quer excluir)
    ele fará a DELEÇÃO/EXCLUSÃO DO REGISTROS
    */
    WHILE !SZ7->(EOF()) .AND. SZ7->Z7_FILIAL = cFilSZ7 .AND. SZ7->Z7_NUM = cNum 
        RECLOCK("SZ7",.F.) //PARAMETRO FALSE PORQUE É EXCLUSÃO
            DbDelete()
        SZ7->(MSUNLOCK())

    SZ7->(dbSkip())
    ENDDO

/* OUTRA FORMA DE EXCLUSÃO COM BASE NO QUE ESTÁ NO GRID.
    SZ7->(dbSetOrder(2))
    For nLinAtu := 1 to Len(aColsAux)
        //Regrinha para verificar se a linha estÃ¡ excluÃ­da, se nÃ£o tiver irÃ¡ incluir
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
    @return lRet, logical, retorno da validação de inclusão do cabeçalho
    @example
    (examples)
    @see (links_or_references)
    /*/
User Function VldSZ7()
//Variável de controle que irá retornar TRUE se o número de pedido não estiver dentro da tabela, ou seja, se não existir
Local lRet      :=  .T.
Local aArea     := GetArea()

//Instancio os Models para capturar em seguida os campos digitados no cabeçalho
Local oModel        := FwModelActive()
Local oModelCabec    := oModel:GetModel("SZ7MASTER")

Local cFilSZ7   :=  oModelCabec:GetValue("Z7_FILIAL")
Local cNum      :=  oModelCabec:GetValue("Z7_NUM")

Local cOption   := oModelCabec:GetOperation()

IF cOption  == MODEL_OPERATION_INSERT
    DbSelectArea("SZ7")
    SZ7->(DbSetOrder(1)) //ÍNDICE FILIAL+NUMEROPEDIDO

    //Se ele encontrar o número de pedido na tabela, a variável lRet retornará FALSE .F. e impedirá a inserção
    IF SZ7->(DbSeek(cFilSZ7+cNum))
        //Use o HELP, pois usando o Alert e MsgInfo, ele aparece uma mensagem de erro
        Help(NIL, NIL, "Escolha outro número de pedido", NIL, "Este pedido/solicitação de compras já existe em nosso sistema", 1, 0, NIL, NIL, NIL, NIL, NIL, {"ATENÇÃO"})			
        lRet        := .F.
    Endif
ENDIF

RestArea(aArea)
Return lRet
