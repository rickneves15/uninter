<? header('Content-Type: text/html; charset=utf8'); ?>
<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml" lang="pt_BR">

<head>
    <title>KANBAN</title>
    <meta charset="utf-8">
    <meta http-equiv="Expires" content="Mon, 26 Jul 1997 05:00:00 GMT" />
    <meta http-equiv="Last-Modified" content="<?= gmdate('D, d M Y H:i:s') . ' GMT'; ?>" />
    <meta http-equiv="Cache-Control" content="no-cache, no-store, must-revalidate" />
    <meta http-equiv="Cache-Control" content="post-check=0, pre-check=0" />
    <meta http-equiv="Pragma" content="no-cache" />
    <meta http-equiv="Cache" content="no-cache" />
    <meta http-equiv="imagetoolbar" content="no" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1" />
    <meta name="rating" content="general" />
    <meta name="author" content="Sandro Alves Peres" />
    <meta name="title" content="KANBAN" />
    <meta name="robots" content="noindex,nofollow" />
    <meta name="googlebot" content="noindex,nofollow" />

    <!-- Mobile device meta tags -->
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=4" />
    <meta name="x-blackberry-defaultHoverEffect" content="false" />
    <meta name="HandheldFriendly" content="true" />
    <meta name="MobileOptimized" content="240" />

    <link rel="shortcut icon" href="./assets/imagens/trello-desktop.jpg" type="image/jpg" />
    <link rel="apple-touch-icon" href="./assets/imagens/trello-desktop.jpg" type="image/jpg" />
    <link rel="stylesheet" href="./assets/bootstrap-3.3.7/css/bootstrap.min.css" />
    <link rel="stylesheet" href="./assets/css/kanban.css" />

    <script src="./assets/js/jquery-1.11.2.min.js"></script>
    <script src="./assets/bootstrap-3.3.7/js/bootstrap.min.js"></script>

    <script type="text/javascript">
        $(function() {
            $('[data-toggle="tooltip"]').tooltip();
        });
    </script>
</head>

<? flush(); ?>

<body>

    <div id="form-card" class="modal fade">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                    <h4 class="modal-title">Visualização do Card</h4>
                </div>
                <div class="modal-body">
                    <div class="container-fluid">
                        <div class="row">
                            <div class="col-md-8">
                                <h6>Registro</h6>
                                <p>
                                    <span class="glyphicon glyphicon-calendar" data-toggle="tooltip" data-placement="top" title="Data"></span>
                                    <span id="data">12/07/2019</span>
                                    <span class="glyphicon glyphicon-time" data-toggle="tooltip" data-placement="top" title="Hora"></span>
                                    <span id="hora">16:30</span>
                                </p>
                            </div>
                            <div class="col-md-2">
                                <h6>N° Aula</h6>
                                <p class="label label-primary" id="num-aula">A3</p>
                            </div>
                            <div class="col-md-2">
                                <h6>Ano</h6>
                                <p class="label label-success" id="ano">2019</p>
                            </div>
                        </div>

                        <div class="row">
                            <div class="col-md-12 well">
                                <h6>Curso</h6>
                                <p id="curso"></p>
                            </div>
                        </div>

                        <div class="row">
                            <div class="col">
                                <ul class="nav nav-tabs">
                                    <li role="presentation" class="active">
                                        <a href="#professores">
                                            <span class="glyphicon glyphicon-user" data-toggle="tooltip" data-placement="top" title="professores" style="margin-right: 6px"></span>
                                            Professores
                                        </a>
                                    </li>
                                </ul>

                                <div id="professores"></div>
                            </div>
                        </div>

                        <div class="row mt-20 mb-10">
                            <ul class="nav nav-tabs">
                                <li role="presentation" class="active">
                                    <a href="#professores"><span class="glyphicon glyphicon-list-alt" data-toggle="tooltip" data-placement="top" title="Sandro Peres" style="margin-right: 6px"></span>
                                        Materiais
                                    </a>
                                </li>
                            </ul>

                            <div id="materiais">
                            </div>
                        </div>
                    </div>

                </div>
                <div class="modal-footer">
                    <h3 id="status"></h3>
                    <button type="button" class="btn btn-default" data-dismiss="modal">Fechar</button>
                </div>
            </div>
        </div>
    </div>

    <div class="container-fluid">

        <div class="hidden">
            <!-- MODELO 1 -->
            <!-- *********************************************************************** -->

            <div class="panel panel-default card" id="card-modelo-1">
                <div class="panel-body">

                    <div class="row">
                        <div class="col-xs-9">
                            <h5>Administração</h5>
                            <div class="wrapper-professores">
                                <span class="label">Sandro Peres</span>
                            </div>
                        </div>
                        <div class="col-xs-3 text-right">
                            <span class="label label-primary label-num-aula">A3</span>
                            <span class="label label-success label-ano">2019</span>
                        </div>
                    </div>

                </div>
                <div class="panel-footer">

                    <!-- OS ÍCONES VÊM DA TABELA "material" DO BANCO DE DADOS -->
                    <div class="icons"></div>

                    <div class="dropdown pull-right">
                        <a href="javascript:;" class="dropdown-toggle" data-toggle="dropdown">
                            <span class="glyphicon glyphicon-move"></span>
                            Mover <span class="caret"></span>
                        </a>
                        <ul class="dropdown-menu actions">
                            <li class="dropdown-header">Ações</li>
                            <li role="separator" class="divider"></li>
                            <li id="next"><a onclick="javascript:next(this)">&raquo; Prosseguir</a></li>
                            <li role="separator" class="divider"></li>
                            <li id="previous"><a onclick="javascript:previous(this)">&laquo; Voltar</a></li>
                        </ul>
                    </div>

                    <a onclick="javascript:showDetailsCard(this);" class="pull-right" id="vizualization" data-toggle="modal" data-target="#form-card" style="margin-right: 10px">
                        <span class="glyphicon glyphicon-eye-open"></span> Visualizar
                    </a>

                </div>
            </div>


            <!-- MODELO 2 -->
            <!-- *********************************************************************** -->

            <div class="panel panel-default card aulao" id="card-modelo-2">
                <div class="panel-body">

                    <div class="row">
                        <div class="col-xs-9">
                            <h5>AULÃO</h5>
                            <div class="wrapper-professores">
                                <span class="label">Clayton Pavarin</span>
                            </div>
                        </div>
                        <div class="col-xs-3 text-right">
                            <span class="label label-primary label-num-aula">A3</span>
                            <span class="label label-success label-ano">2019</span>
                        </div>
                    </div>

                </div>
                <div class="panel-footer">

                    <!-- OS ÍCONES VÊM DA TABELA "material" DO BANCO DE DADOS -->
                    <span class="glyphicon glyphicon-facetime-video" data-toggle="tooltip" data-placement="top" title="Vídeo" style="margin-right: 6px"></span>
                    <span class="glyphicon glyphicon-music" data-toggle="tooltip" data-placement="top" title="Áudio" style="margin-right: 6px"></span>

                    <div class="dropdown pull-right">
                        <a href="javascript:;" class="dropdown-toggle" data-toggle="dropdown">
                            <span class="glyphicon glyphicon-move"></span>
                            Mover <span class="caret"></span>
                        </a>
                        <ul class="dropdown-menu actions">
                            <li class="dropdown-header">Ações</li>
                            <li role="separator" class="divider"></li>
                            <li id="next"><a onclick="javascript:next(this)">&raquo; Prosseguir</a></li>
                            <li role="separator" class="divider"></li>
                            <li id="previous"><a onclick="javascript:previous(this)">&laquo; Voltar</a></li>
                        </ul>
                    </div>

                    <a onclick="javascript:showDetailsCard(this);" class="pull-right" id="vizualization" data-toggle="modal" data-target="#form-card" style="margin-right: 10px">
                        <span class="glyphicon glyphicon-eye-open"></span> Visualizar
                    </a>

                </div>
            </div>
        </div>

        <div class="row">
            <div class="col-sm-2">
                <div class="form-group">
                    <label class="control-label">Curso</label>
                    <select id="select-filtro-curso" class="form-control">
                        <option value="all"></option>
                    </select>
                </div>
            </div>
            <div class="col-sm-2 col-md-1">
                <div class="form-group">
                    <label class="control-label">Nº Aula</label>
                    <select id="select-filtro-num-aula" class="form-control">
                        <option value="all"></option>
                    </select>
                </div>
            </div>
            <div class="col-sm-3">
                <div class="form-group">
                    <label class="control-label">Professor</label>
                    <div class="input-group">
                        <select id="select-filtro-professor" class="form-control">
                            <option value="all"></option>
                        </select>
                        <span class="input-group-addon">
                            <span class="glyphicon glyphicon-search"></span>
                        </span>
                    </div>
                </div>
            </div>
            <div class="col-sm-2">
                <div class="form-group">
                    <label class="control-label">Ordenar por</label>
                    <select id="select-filtro-ordenar-por" class="form-control">
                        <option value="ano">Ano</option>
                        <option value="curso">Curso</option>
                        <option value="professor">Professor</option>
                        <option value="num_aula">Nº Aula</option>
                    </select>
                </div>
            </div>
            <div class="col-sm-2">
                <div class="form-group">
                    <label class="control-label">&nbsp;</label>
                    <select id="select-filtro-ordenar-sentido" class="form-control">
                        <option value="asc">Crescente</option>
                        <option value="desc">Decrescente</option>
                    </select>
                </div>
            </div>
            <div class="col-sm-2">
                <div class="form-group">
                    <label class="control-label">&nbsp;</label>
                    <button class="btn btn-primary" onclick="javascript:getCardsByFilters()" style="margin-top: 25px;">Buscar</button>
                </div>
            </div>
        </div>

        <div class="row card-colunas">
            <div class="col-sm-6 col-md-3">

                <!-- DEMANDA -->
                <!-- *************************************************** -->

                <div class="panel panel-primary coluna coluna-demanda">
                    <div class="panel-heading">
                        <p class="panel-title">
                            Demanda
                            <span class="badge badge-num-cards">0</span>
                        </p>
                    </div>
                    <div id="cards-demanda" class="panel-body">


                    </div>
                </div>

            </div>
            <div class="col-sm-6 col-md-3">

                <!-- MATERIAL RECEBIDO -->
                <!-- *************************************************** -->

                <div class="panel panel-info coluna coluna-material-recebido">
                    <div class="panel-heading">
                        <p class="panel-title">
                            Material Recebido
                            <span class="badge badge-num-cards">0</span>
                        </p>
                    </div>
                    <div id="cards-material-recebido" class="panel-body">


                    </div>
                </div>

            </div>
            <div class="col-sm-6 col-md-3">

                <!-- EM CONFERÊNCIA -->
                <!-- *************************************************** -->

                <div class="panel panel-danger coluna-em-conferencia">
                    <div class="panel-heading">
                        <p class="panel-title">
                            Em Conferência
                            <span class="badge badge-num-cards">0</span>
                        </p>
                    </div>
                    <div id="cards-em-conferencia" class="panel-body">


                    </div>
                </div>

            </div>
            <div class="col-sm-6 col-md-3">

                <!-- CONFERIDO -->
                <!-- *************************************************** -->

                <div class="panel panel-success coluna-conferido">
                    <div class="panel-heading">
                        <p class="panel-title">
                            Conferido
                            <span class="badge badge-num-cards">0</span>
                        </p>
                    </div>
                    <div id="cards-conferido" class="panel-body">


                    </div>
                </div>

            </div>
        </div>

    </div>
    <script src="./services.js"></script>
</body>

</html>