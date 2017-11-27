<%@ page import="cn.goldlone.dao.MemberDao" %>
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
            <li class="active"><a href="/master/updateMemberInfo">修改会员信息</a></li>
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
            <li><a href="/master/backBook">还书</a></li>
            <li><a href="/master/insertBook">导入图书</a></li>
          </ul>
        </div>
        <!-- end left nav -->
        
        <!-- start content -->
        <div class="col-sm-9 col-sm-offset-3 col-md-10 col-md-offset-2 main">
          <h1 class="page-header">会员信息</h1>
          <h4 class="sub-header">修改会员信息</h4>

          <div class="row">
            <div class="col-md-5">
              <h5 class="sub-header">选择修改的会员</h5>
              <label class="control-label">会员号</label>
              <input class="form-control" name="no" id="memberNo"/><br>
              <button class="btn btn-primary" onclick="selectMemberInfo()">查询</button>
            </div>
            <div class="col-md-7" id="updateInfo" hidden>
              <div class="row">
                <h5 class="sub-header">修改信息</h5>
                <form class="form-horizontal col-md-12" id="form-update">
                  <div class="form-group">
                    <label class="control-label col-md-2">姓名</label>
                    <div class="col-md-6">
                      <input class="form-control" type="text" name="name" readonly />
                    </div>
                  </div>
                  <div class="form-group">
                    <label class="control-label col-md-2">会员号</label>
                    <div class="col-md-6">
                      <input class="form-control" type="text" name="no" readonly />
                    </div>
                  </div>
                  <div class="form-group">
                    <label class="control-label col-md-2">邮箱</label>
                    <div class="col-md-6">
                      <input class="form-control" type="text" name="email" readonly />
                    </div>
                  </div>
                  <div class="form-group">
                    <label class="control-label col-md-2">学号</label>
                    <div class="col-md-6">
                      <input class="form-control" type="text" name="stuNo" />
                    </div>
                  </div>
                  <div class="form-group">
                    <label class="control-label col-md-2">电话</label>
                    <div class="col-md-6">
                      <input class="form-control" type="text" name="phone" />
                    </div>
                  </div>
                  <div class="form-group">
                    <label class="control-label col-md-2">专业</label>
                    <div class="col-md-6">
                      <input class="form-control" type="text" name="discipline" />
                    </div>
                  </div>
                  <div class="form-group">
                    <label class="control-label col-md-2">学历</label>
                    <div class="col-md-6">
                      <select class="form-control" name="degreeNo" >
                        <option value="0">本科</option>
                        <option value="1">硕士</option>
                        <option value="2">博士</option>
                      </select>
                    </div>
                  </div>
                  <div class="form-group">
                    <label class="control-label col-md-2">年级</label>
                    <div class="col-md-6">
                      <input class="form-control" type="number" name="grade"/>
                    </div>
                  </div>
                  <div class="form-group">
                    <label class="control-label col-md-2">班级</label>
                    <div class="col-md-6">
                      <input class="form-control" type="number" name="classNum"/>
                    </div>
                  </div>
                  <div class="form-group">
                    <label class="control-label col-md-2">身份证号</label>
                    <div class="col-md-6">
                      <input class="form-control" type="text" name="id" />
                    </div>
                  </div>
                  <div class="form-group">
                    <label class="control-label col-md-2">生效时间</label>
                    <div class="col-md-6">
                      <input class="form-control" type="date" name="startTime" />
                    </div>
                  </div>
                  <div class="form-group">
                    <label class="control-label col-md-2">失效时间</label>
                    <div class="col-md-6">
                      <input class="form-control" type="date" name="endTime" />
                    </div>
                  </div>
                  <div class="form-group">
                    <label class="control-label col-md-2">是否加分</label>
                    <div class="col-md-6">
                      <select class="form-control" name="addSocre" id="certName">
                        <option value="0">未加分</option>
                      </select>
                    </div>
                  </div>

                  <div class="form-group" <%
                    if(request.getSession().getAttribute("memberNo")!=null){
                    String no = request.getSession().getAttribute("memberNo").toString();
                    if(new MemberDao().selectPower(no)<2)out.print("hidden");}else out.print("hidden");%>>
                    <label class="control-label col-md-2">身份权限</label>
                    <div class="col-md-6">
                      <select class="form-control" name="power" >
                        <option value="0">会员</option>
                        <option value="1">普通管理员</option>
                        <option value="2">高级管理员</option>
                      </select>
                    </div>
                  </div>

                  <div class="form-group col-md-8">
                    <div class="col-md-8" style="float: right;">
                      <button class="form-control btn-primary" type="button" onclick="submitUpdate()">确认修改</button>
                    </div>
                  </div>
                </form>
              </div>
            </div>
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
      // 获取CSP认证集合数据
      function getCertSet() {
        $.ajax({
          url: "/getCertSet",
          type: "post",
          success: function (res) {
            console.log(res);
            for(var i=0; i<res.data.length; i++)
              $("#certName").append("<option value=\""+res.data[i].no+"\">"+res.data[i].name+"</option>");
          },
          error: function (res) {
            console.log(res);
          }
        });
      }
      getCertSet();
      // 查询要修改的会员信息
      function selectMemberInfo() {
        if($("#memberNo").val() == "") {
          bootbox.alert({
            size: "small",
            title: "提示信息",
            message: "请输入会员号!",
            callback: function(){  }
          });
          return;
        }
        $.ajax({
          url: "/selectMemberByNo",
          type: "post",
          data: "&no="+$("#memberNo").val(),
          success: function (res) {
            if(res.len == 0) {
              bootbox.alert({
                size: "small",
                title: "提示消息",
                message: "会员号有误，无该会员"
              });
              return;
            }
            $("#updateInfo").show();
            $("input[name='no']")[1].value = res.data[0].no;
            $("input[name='name']")[0].value = res.data[0].name;
            $("input[name='email']")[0].value = res.data[0].email;
            $("input[name='stuNo']")[0].value = res.data[0].stuNo;
            $("input[name='phone']")[0].value = res.data[0].phone;
            $("input[name='discipline']")[0].value = res.data[0].discipline;
            $("input[name='grade']")[0].value = res.data[0].grade;
            $("input[name='classNum']")[0].value = res.data[0].classNum;
            $("input[name='id']")[0].value = res.data[0].id;
            $("input[name='startTime']")[0].value = res.data[0].startTime;
            $("input[name='endTime']")[0].value = res.data[0].endTime;
            switch (res.data[0].degree) {
              case "本科":
                $("select[name='degreeNo']")[0].value = 0;
                break;
              case "硕士":
                $("select[name='degreeNo']")[0].value = 1;
              case "博士":
                $("select[name='degreeNo']")[0].value = 2;
            }
            $("select[name='addSocre']")[0].value = res.data[0].addScore;
            $("select[name='power']")[0].value = res.data[0].power;
          },
          fail: function (res) {
            console.log(res);
          }
        });
      }
      // 提交修改
      function submitUpdate() {
        bootbox.confirm({
          title: "提示消息",
          message: "确认提交修改？",
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
                url: "/updateMember",
                type: "post",
                data: $("#form-update").serialize(),
                success: function (res) {
                  console.log(res);
                  if (res.ret) {
                    bootbox.alert({
                      size: "small",
                      title: "提示消息",
                      message: "修改成功"
                    });
                  } else {
                    bootbox.alert({
                      size: "small",
                      title: "提示消息",
                      message: "修改失败"
                    });
                  }

                },
                fail: function (res) {
                  console.log(res);
                }
              });
            }
          }
        });

      }

      
    </script>
    
  </body>
</html>