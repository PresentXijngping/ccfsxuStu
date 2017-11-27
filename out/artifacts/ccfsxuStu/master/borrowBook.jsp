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
	
	  <jsp:include page="/all/header.jsp"></jsp:include>
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
            <li class="active"><a href="/master/borrowBook">借书</a></li>
            <li><a href="/master/backBook">还书</a></li>
            <li><a href="/master/insertBook">导入图书</a></li>
          </ul>
        </div>
        <!-- end left nav -->
        
        <!-- start content -->
        <div class="col-sm-9 col-sm-offset-3 col-md-10 col-md-offset-2 main">
          <h1 class="page-header">图书馆管理</h1>
          <h4 class="sub-header">借阅管理</h4>
          <div class="row">
            <div class="col-md-9">
              <div class="row">
                <form class="form-horizontal col-md-12">
                  <div class="form-group">
                    <div class="col-md-2"><label class="control-label">ISBN编号</label></div>
                    <div class="col-md-4"><input class="form-control" name="isbn" type="number" id="isbn" /></div>
                    <div class="col-md-2"><button class="btn btn-block btn-primary" type="button" onclick="searchInventory()">查询库存</button></div>
                  </div>
                  <div class="form-group">
                    <div class="col-md-2"><label class="control-label">会员号</label></div>
                    <div class="col-md-4"><input class="form-control" name="memberNo" type="text" id="memberNo"/></div>
                  </div>
                </form>
              </div>
              <div class="row">
                <div class="col-md-6">
                  <div class="col-md-4"></div>
                  <div class="col-md-4"><button class="btn btn-primary btn-block" onclick="submitBorrow()">提交信息</button></div>
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
    <script type="text/javascript" src="/assets/js/vendor/jquery-3.2.1.min.js"></script>
    <!-- <script>window.jQuery || document.write('<script src="./assets/js/vendor/jquery.min.js"><\/script>')</script> -->
    <script src="/dist/js/bootstrap.min.js"></script>
    <!-- Just to make our placeholder images work. Don't actually copy the next line! -->
    <script src="/assets/js/vendor/holder.min.js"></script>
    <!-- IE10 viewport hack for Surface/desktop Windows 8 bug -->
    <script src="/assets/js/ie10-viewport-bug-workaround.js"></script>
    <script src="/assets/js/bootbox.min.js"></script>
    <script type="text/javascript">
      var counts = 0;
//      showNowDate();
      // 显示当前的日期
//      function showNowDate() {
//        var now = new Date();
//        var day = ("0" + now.getDate()).slice(-2);
//        var month = ("0" + (now.getMonth() + 1)).slice(-2);
//        var today = now.getFullYear()+"-"+(month)+"-"+(day) ;
//        $('#borrowDate').val(today);
//      }
      $("#isbn").change(function () {
//        console.log(this.value);
        if(this.value.length>=13) {
          searchInventory();
        }
      });
      // 提交借书请求
      function submitBorrow() {
        if(counts<1) {
          bootbox.alert({
            size: "small",
            title: "提示信息",
            message: "请先查询图书的库存量"
          });
          return;
        }
        if(trim($("#memberNo").val()) == "") {
          bootbox.alert({
            size: "small",
            title: "提示信息",
            message: "会员号不能为空"
          });
          return;
        }
        bootbox.confirm({
          title: "提示信息",
          message: "请确认借阅信息无误?",
          buttons: {
            cancel: {
              label: '<i class="fa fa-times"></i> 取消'
            },
            confirm: {
              label: '<i class="fa fa-check"></i> 确认'
            }
          },
          callback: function (result) {
            if(result) {
              $.ajax({
                url: "/borrowBook",
                type: "post",
                data: {
                  isbn: $("#isbn").val(),
                  memberNo: $("#memberNo").val()
                },
                success: function (res) {
                  console.log(res);
                  if(res.ret) {
                    bootbox.alert({
                      size: "small",
                      title: "提示消息",
                      message: "借阅成功"
                    });
                  } else {
                    bootbox.alert({
                      size: "small",
                      title: "提示消息",
                      message: "借阅失败"
                    });
                  }
                }
              });
            }
          }
        });
      }

      // 查询库存
      function searchInventory() {
        counts = 0;
        if($("#isbn").val() == "") {
          bootbox.alert({
            size: "small",
            title: "提示消息",
            message: "请输入合法的ISBN编号"
          });
          return;
        }
        $.ajax({
          url: "/searchInventory",
          type: "post",
          data: {
            isbn: $("#isbn").val()
          },
          success: function (res) {
//            console.log(res);
            counts = res.num;
            if(res.ret) {
              bootbox.alert({
                size: "size",
                title: "提示消息",
                message: "剩余库存量："+res.num
              });
            } else {
              bootbox.alert({
                size: "size",
                title: "提示消息",
                message: "没有这本书。。"
              });
            }
            if(res.num == 0) {
              $("#memberNo")[0].disabled = true;
            } else {
              $("#memberNo")[0].disabled = false;
            }
          },
          error: function (res) {
            console.log(res);
          }
        });
      }

      // 删除左右两端的空格
      function trim(str){
        return str.replace(/(^\s*)|(\s*$)/g, "");
      }

    </script>
  </body>
</html>