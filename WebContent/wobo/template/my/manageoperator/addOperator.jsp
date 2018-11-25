<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<jsp:include page="../../../head.jsp" flush="true" />
<%
String uri = request.getRequestURI();
uri = uri.substring(0, uri.lastIndexOf("/"));
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path;
%>
<style>  
	#fileupload{ position:absolute;width:83px;height:40px; z-index:100;  font-size:60px;opacity:0;filter:alpha(opacity=0); margin-top:-5px;}  
</style> 
<body>
	<div id="wrapper">
		<jsp:include page="../../../top.jsp" flush="true"/>
		<!-- Page Content -->
		<div id="page-wrapper">
			<div class="row">
                <div class="col-lg-12">
                    <h2 class="page-header">添加运维用户</h2>
                </div>
                <!-- /.col-lg-12 -->
            </div>
            <!-- /.row -->
            <div class="row">
                <div class="col-lg-12">
                    <div class="panel panel-default">
                        <!-- <div class="panel-heading">
                        </div> -->
                        <div class="panel-body">
                            <div class="row">
                                <!-- /.col-lg-6 (nested) -->
                                <div class="col-lg-6">
                                	<br/>
                                	<br/>
                                    <form role="form" name="func" id="myForm">
                                        <div class="form-group">
                                            <label>用户名：</label>
                                            <input class="form-control" placeholder="用户名(只支持英文，数字，英文数字)" id="userid" name="user_id" value="${user_id}">
                                        </div>
                                        <%-- <div class="form-group">
                                            <label>密码：</label>
                                            <input class="form-control" type="password" placeholder="必填" id="password" name="password" value="${password}">
                                        </div> --%>
                                        <div class="form-group">
                                            <label>用户实名：</label>
                                            <input class="form-control" placeholder="必填" id="username" name="user_name" value="${user_name}">
                                        </div>
                                        <div class="form-group">
                                        	<label>分配的学校：</label>
                                            <select id="schoolId" name="schoolId" class="form-control myClass">
                                            	<option value="all" onclick="optionClick(this);" <c:if test="all"> selected="selected"</c:if>>请选择学校</option>
                                            	<c:forEach var="school" items="${schoolList}">
                                            		<option id="${school.schoolId }" value="${school.schoolId }" onclick="optionClick(this);" <c:if test="${school_id eq 'school.schoolId' }"> selected="selected"</c:if>>${school.schoolName }</option>
                                            	</c:forEach>
                                            </select>
                                        </div>
                                        <button type="button" class="btn btn-success" onclick="ajax_sub();">保存</button>
                                        <button type="button" class="btn btn-success" id="_manageoperator_operatorList" onclick="jump_pub(this)">返回</button>
                                    </form>
                                </div>
                            </div>
                            <!-- /.row (nested) -->
                        </div>
                        <!-- /.panel-body -->
                    </div>
                    <!-- /.panel -->
                </div>
                <!-- /.col-lg-12 -->
            </div>
            <!-- /.row -->
		</div>
		<!-- /#page-wrapper -->
	</div>
	<jsp:include page="../../../modal.jsp" flush="true" />
	<jsp:include page="../../../common.jsp" flush="true" />
	<script src="<%=request.getContextPath() %>/wobo/js/ajaxfileupload.js"></script>
</body>
<jsp:include page="../../../footer.jsp" flush="true" />
<script>
function ajax_sub()
{
	if($("#userid").val() == "")
	{
		showModal("请输入登录名!");
		return false;
	}
	if(!/^[a-zA-Z0-9]\w{0,17}$/.test($("#userid").val()))
	{
		showModal("用户名不合法，用户名只支持英文、数字或英文数字");
		return false;
	}
	/* if($("#password").val() == "")
	{
		showModal("请输入密码!");
		return false;
	} */
	if($("#username").val() == "")
	{
		showModal("请输入用户实名!");
		return false;
	}
	if($("#schoolId option:selected").val() == "all")
	{
		showModal("请选择学校!");
		return false;
	}
	var url = getUrl("web","manageoperator/saveOperator");
	$.ajax({
		url:url,
		type:"post",
		data:$('#myForm').serialize(),
		dataType:'json',
		success:function(data)
		{
			showModal(data.msg);
			if(data.resFlag == '0'){
				closeModal(getUrl("web","manageoperator/operatorList")); //关闭悬浮框时再跳转页面
			}
			return false;
		},
		error:function(data)
		{
			showModal(data.responseText);
			return false;
		}
	});
}
</script>