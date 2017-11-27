<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="zh-CN">
  <head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <!-- The above 3 meta tags *must* come first in the head; any other head content must come *after* these tags -->
    <meta name="description" content="">
    <meta name="author" content="">
    <link rel="icon" href="/assets/img/favicon.ico">

    <title>CCFSXU会员管理系统</title>

    <!-- Bootstrap core CSS -->
    <link href="/dist/css/bootstrap.min.css" rel="stylesheet">

    <!-- IE10 viewport hack for Surface/desktop Windows 8 bug -->
    <link href="/assets/css/ie10-viewport-bug-workaround.css" rel="stylesheet">

    <!-- Custom styles for this template -->
    <link href="/assets/css/my/dashboard.css" rel="stylesheet">

    <!-- Just for debugging purposes. Don't actually copy these 2 lines! -->
    <!--[if lt IE 9]><script src="/assets/js/ie8-responsive-file-warning.js"></script><![endif]-->
    <script src="/assets/js/ie-emulation-modes-warning.js"></script>

    <!-- HTML5 shim and Respond.js for IE8 support of HTML5 elements and media queries -->
    <!--[if lt IE 9]>
      <script src="https://oss.maxcdn.com/html5shiv/3.7.3/html5shiv.min.js"></script>
      <script src="https://oss.maxcdn.com/respond/1.4.2/respond.min.js"></script>
    <![endif]-->
  </head>

  <body>
	<jsp:include page="../all/header.jsp"></jsp:include>
	
  <div class="container-fluid">
    <div class="row">
      <!-- start left nav -->
      <div class="col-sm-3 col-md-2 sidebar">
        <ul class="nav nav-sidebar">
          <li><a href="#" style="color: #000;cursor: default;">
            <h4 class="sub-header">会员信息</h4></a>
          </li>
          <li><a href="/master/selectMemberInfo" >查询会员信息</a></li>
          <li><a href="/master/insertMemberInfo">录入会员信息</a></li>
          <li><a href="/master/updateMemberInfo">修改会员信息</a></li>
        </ul>
        <ul class="nav nav-sidebar">
          <li><a href="#" style="color: #000;cursor:default;">
            <h4 class="sub-header">CSP管理</h4></a>
          </li>
          <li><a href="/master/selectCSPScore">查询CSP成绩</a></li>
          <li><a href="/master/insertCSPScore">录入CSP成绩</a></li>
          <li><a href="/master/managerCSPApplication">CSP报名管理</a></li>
          <li><a href="/master/analysisCSPScore">会员进步状况分析</a></li>
        </ul>
        <ul class="nav nav-sidebar">
          <li><a href="#" style="color: #000;cursor:default;">
            <h4 class="sub-header">图书馆</h4></a>
          </li>
          <li><a href="/master/borrowBook">借书</a></li>
          <li class="active"><a href="/master/backBook">还书</a></li>
        </ul>
      </div>
      <!-- end left nav -->

      <!-- start content -->
      <div class="col-sm-9 col-sm-offset-3 col-md-10 col-md-offset-2 main">
        <h1 class="page-header">图书馆管理</h1>
        <h4 class="sub-header">归还管理</h4>
        <div class="row">
          <div class="col-md-9">
            <div class="row">
              <form class="form-horizontal col-md-12" onkeydown="if(event.keyCode==13)return false;">
                <div class="form-group">
                  <div class="col-md-2"><label class="control-label">ISBN编号</label></div>
                  <div class="col-md-4"><input class="form-control" name="isbn" type="number" id="isbn" /></div>
                  <div class="col-md-2"><button class="btn btn-block btn-primary" type="button" onclick="searchOrder()">查询借阅记录</button></div>
                </div>
                <div class="form-group">
                  <div class="col-md-2"><label class="control-label">选择归还</label></div>
                  <div class="col-md-4"><select class="form-control" name="no" id="no"></select></div>
                </div>
              </form>
            </div>
            <div class="row">
              <div class="col-md-6">
                <div class="col-md-4"></div>
                <div class="col-md-4"><button class="btn btn-primary btn-block" onclick="submitBorrow()" type="button">提交信息</button></div>
                <div class="col-md-4"></div>
              </div>
              <div class="col-md-6"></div>
            </div>
          </div>
          <div class="col-md-3"></div>
        </div>

      </div>
      <!-- end content -->

    </div>
  </div>

    <!-- Bootstrap core JavaScript
    ================================================== -->
    <!-- Placed at the end of the document so the pages load faster -->
    <!-- <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script> -->
    <script src="/assets/js/vendor/jquery-3.2.1.min.js"></script>
    <!-- <script>window.jQuery || document.write('<script src="./assets/js/vendor/jquery.min.js"><\/script>')</script> -->
    <script src="/dist/js/bootstrap.min.js"></script>
    <!-- Just to make our placeholder images work. Don't actually copy the next line! -->
    <script src="/assets/js/vendor/holder.min.js"></script>
    <!-- IE10 viewport hack for Surface/desktop Windows 8 bug -->
    <script src="/assets/js/ie10-viewport-bug-workaround.js"></script>
    <script src="/assets/js/bootbox.min.js"></script>
    <script type="text/javascript">
      var len = 0;
      var datas;
      var index = 0;
//      $("#isbn").change(function () {
//        if(this.value.length>=13) {
//          searchOrder();
//        }
//      });
      // 查询借阅情况
      function searchOrder() {
        if($("#isbn").val() == "") {
          bootbox.alert({
            size: "small",
            title: "提示消息",
            message: "请输入合法的ISBN编号"
          });
          return;
        }
        $.ajax({
          url: "/searchOrder",
          type: "post",
          data: {
            isbn: $("#isbn").val()
          },
          success: function (res) {
//            console.log(res);
            len = res.len;
            datas = res.data;
            showOlder();
          },
          error: function (res) {
            console.log(res);
          }
        });
      }
      // 展示订单
      function showOlder() {
        $("#no").empty();
        for(var i=0; i<datas.length; i++) {
          index = i;
          $.ajax({
            url: "/selectMemberByNo",
            type: "post",
            data: {
              no: datas[index].memberNo
            },
            success: function (res) {
              $("#no").append("<option value=\""+datas[index].no+"\">"+datas[index].memberNo+" - "+res.data[0].name+"</option>");
            },
            error: function (res) {
              console.log(res);
            }
          });
        }
        bootbox.alert({
          size: "small",
          title: "提示消息",
          message: "查询成功"
        });
      }
      
      // 提交还书信息
      function submitBorrow () {
        if(len<1) {
          bootbox.alert({
            size: "small",
            title: "提示消息",
            message: "请先查询借书记录"
          });
          return;
        }
        $.ajax({
          url: "/backBook",
          type: "post",
          data: {
            isbn: $("#isbn").val(),
            no: $("#no").val()
          },
          success: function (res) {
//            console.log(res);
            if(res.ret) {
              bootbox.alert({
                size: "small",
                title: "提示消息",
                message: "还书成功"
              });
            }
          },
          error: function (res) {
            console.log(res);
          }
        });
      }

    </script>
    
  </body>
</html>