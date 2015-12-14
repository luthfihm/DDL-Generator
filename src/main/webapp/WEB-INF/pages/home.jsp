<html>
<head>
    <title>DDL Generator</title>
    <link rel='stylesheet' href='${pageContext.request.contextPath}/webjars/bootstrap/3.3.5/css/bootstrap.min.css'>
</head>
<body>
    <nav class="navbar navbar-default navbar-inverse">
        <div class="container-fluid">
            <!-- Brand and toggle get grouped for better mobile display -->
            <div class="navbar-header">
                <button type="button" class="navbar-toggle collapsed" data-toggle="collapse" data-target="#bs-example-navbar-collapse-1" aria-expanded="false">
                    <span class="sr-only">Toggle navigation</span>
                    <span class="icon-bar"></span>
                    <span class="icon-bar"></span>
                    <span class="icon-bar"></span>
                </button>
                <a class="navbar-brand" href="#">DDL Generator</a>
            </div>
        </div><!-- /.container-fluid -->
    </nav>
    <div class="container-fluid">
        <div class="well">
            <form>
                <div class="row">
                    <div class="col-md-6">
                        <div class="form-group">
                            <label for="script" style="height: 35px;">DSDL Script :</label>
                            <textarea id="script" rows="20" class="form-control"></textarea>
                        </div>
                    </div>
                    <div class="col-md-6">
                        <div class="form-group">
                            <label for="ddl-code" style="height: 35px;"><button type="button" class="btn btn-primary" id="generate">Generate DDL Code</button>
                                <img src="${pageContext.request.contextPath}/resource/loading.gif" id="loading" style="display: none" alt="">
                                <span id="error-msg" class="label label-danger" style="display: none;"></span>
                            </label>
                            <textarea id="ddl-code" rows="20" class="form-control"></textarea>
                        </div>
                    </div>
                </div>
            </form>
        </div>
    </div>
    <script src="${pageContext.request.contextPath}/webjars/jquery/2.1.4/jquery.min.js"></script>
    <script src="${pageContext.request.contextPath}/webjars/bootstrap/3.3.5/js/bootstrap.min.js"></script>
    <script>
        $(document).ready(function(){
            $("#generate").click(function () {
                $.ajax({
                    url: '${pageContext.request.contextPath}/generator',
                    method: 'POST',
                    data: {
                        script: $('#script').val()
                    },
                    success: function(result){
                        console.log(result);
                        $("#loading").hide();
                        $("#ddl-code").val(result);
                    },
                    beforeSend: function(){
                        console.log("sending script");
                        $("#ddl-code").val("");
                        $("#loading").show();
                        $("#error-msg").hide();
                    },
                    error: function (response) {
                        console.log("error");
                        console.log(response.responseText);
                        var errors = JSON.parse(response.responseText);
                        $("#loading").hide();
                        $("#error-msg").html(errors.length+" error(s) found!");
                        $("#error-msg").show();
                        var results = "";
                        $.each(errors, function (i, error) {
                            results += error+"\n";
                        });
                        $("#ddl-code").val(results);
                    }
                })
            });
        });
    </script>
</body>
</html>