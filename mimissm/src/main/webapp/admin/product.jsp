<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%@page import="java.util.*" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">

    <script type="text/javascript">
        if ("${msg}" != "") {
            alert("${msg}");
        }
    </script>

    <c:remove var="msg"></c:remove>

    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/bootstrap.css"/>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/bright.css"/>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/addBook.css"/>
    <script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery-3.3.1.js"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath}/js/bootstrap.js"></script>
    <title></title>
</head>
<script type="text/javascript">
<%--    全选复选框--%>
    function allClick() {
        var flag = $("#all").prop("checked");

        $("input[name='ck']").each(function (){
            this.checked = flag;
        })
    }

    function ckClick() {
        var fiveLength = $("input[name='ck']").length;
        var checkedLength = $("input[name='ck']:checked").length;
        if(fiveLength == checkedLength){
            $("#all").prop("checked",true);
        }else {
            $("#all").prop("checked",false);
        }
    }

    function conditions(){
        var pname = $("#pname").val();
        var typeid = $("#typeid").val();
        var lprice = $("#lprice").val();
        var hprice = $("#hprice").val();

        $.ajax({
            url:"${pageContext.request.contextPath}/prod/ajaxsplit.action",
            type:"post",
            data:{"pname":pname,"typeid":typeid,"lprice":lprice,"hprice":hprice},
            //不需要dataType 返回值类型
            success:function () {
                $("#table").load("http://localhost:8080/mimissm/admin/product.jsp #table");
            }
        })


    }
</script>
<body>
<div id="brall">
    <div id="nav">
        <p>商品管理>商品列表</p>
    </div>
    <div id="condition" style="text-align: center">
        <form id="myform">
            商品名称：<input name="pname" id="pname">&nbsp;&nbsp;&nbsp;
            商品类型：<select name="typeid" id="typeid">
                        <option value="-1">请选择</option>
                        <c:forEach items="${typeList}" var="pt">
                            <option value="${pt.typeId}">${pt.typeName}</option>
                        </c:forEach>
                    </select>&nbsp;&nbsp;&nbsp;
            价格：<input name="lprice" id="lprice">-<input name="hprice" id="hprice">
            <input type="button" value="查询" onclick="conditions()">
        </form>
    </div>
    <br>
    <div id="table">

        <c:choose>
            <c:when test="${info.list.size()!=0}">

                <div id="top">
                    <input type="checkbox" id="all" onclick="allClick()" style="margin-left: 50px">&nbsp;&nbsp;全选
                    <a href="${pageContext.request.contextPath}/admin/addproduct.jsp">
                        <input type="button" class="btn btn-warning" id="btn1"
                               value="新增商品">
                    </a>
                    <input type="button" class="btn btn-warning" id="btn1"
                           value="批量删除" onclick="deleteBatch()">
                </div>
                <!--显示分页后的商品-->
                <div id="middle">
                    <table class="table table-bordered table-striped">
                        <tr>
                            <th></th>
                            <th>商品名</th>
                            <th>商品介绍</th>
                            <th>定价（元）</th>
                            <th>商品图片</th>
                            <th>商品数量</th>
                            <th>操作</th>
                        </tr>
                        <c:forEach items="${info.list}" var="p">
                            <tr>
                                <td valign="center" align="center">
                                    <input type="checkbox" name="ck" id="ck" value="${p.pId}" onclick="ckClick()">
                                </td>
                                <td>${p.pName}</td>
                                <td>${p.pContent}</td>
                                <td>${p.pPrice}</td>
                                <td><img width="55px" height="45px"
                                         src="${pageContext.request.contextPath}/image_big/${p.pImage}"></td>
                                <td>${p.pNumber}</td>
                                    <%--<td><a href="${pageContext.request.contextPath}/admin/product?flag=delete&pid=${p.pId}" onclick="return confirm('确定删除吗？')">删除</a>--%>
                                    <%--&nbsp;&nbsp;&nbsp;<a href="${pageContext.request.contextPath}/admin/product?flag=one&pid=${p.pId}">修改</a></td>--%>
                                <td>
                                    <button type="button" class="btn btn-info "
                                            onclick="one(${p.pId},${info.pageNum})">编辑
                                    </button>
                                    <button type="button" class="btn btn-warning" id="mydel"
                                            onclick="del(${p.pId},${info.pageNum})">删除
                                    </button>
                                </td>
                            </tr>
                        </c:forEach>
                    </table>
                    <!--分页栏-->
                    <div id="bottom">
                        <div>
                            <nav aria-label="..." style="text-align:center;">
                                <ul class="pagination">
                                    <li>
                                            <%--                                        <a href="${pageContext.request.contextPath}/prod/split.action?page=${info.prePage}" aria-label="Previous">--%>
                                        <a href="javascript:ajaxsplit(${info.prePage})" aria-label="Previous">

                                            <span aria-hidden="true">«</span></a>
                                    </li>
                                    <c:forEach begin="1" end="${info.pages}" var="i">
                                        <c:if test="${info.pageNum==i}">
                                            <li>
                                                    <%--<a href="${pageContext.request.contextPath}/prod/split.action?page=${i}" style="background-color: grey">${i}</a>--%>
                                                <a href="javascript:ajaxsplit(${i})"
                                                   style="background-color: grey">${i}</a>
                                            </li>
                                        </c:if>
                                        <c:if test="${info.pageNum!=i}">
                                            <li>
                                                    <%-- <a href="${pageContext.request.contextPath}/prod/split.action?page=${i}">${i}</a>--%>
                                                <a href="javascript:ajaxsplit(${i})">${i}</a>
                                            </li>
                                        </c:if>
                                    </c:forEach>
                                    <li>
                                        <%--  <a href="${pageContext.request.contextPath}/prod/split.action?page=1" aria-label="Next">--%>
                                        <a href="javascript:ajaxsplit(${info.nextPage})" aria-label="Next">
                                            <span aria-hidden="true">»</span></a>
                                    </li>
                                    <li style=" margin-left:150px;color: #0e90d2;height: 35px; line-height: 35px;">总共&nbsp;&nbsp;&nbsp;<font
                                            style="color:orange;">${info.pages}</font>&nbsp;&nbsp;&nbsp;页&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                                        <c:if test="${info.pageNum!=0}">
                                            当前&nbsp;&nbsp;&nbsp;<font
                                            style="color:orange;">${info.pageNum}</font>&nbsp;&nbsp;&nbsp;页&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                                        </c:if>
                                        <c:if test="${info.pageNum==0}">
                                            当前&nbsp;&nbsp;&nbsp;<font
                                            style="color:orange;">1</font>&nbsp;&nbsp;&nbsp;页&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                                        </c:if>
                                    </li>
                                </ul>
                            </nav>
                        </div>
                    </div>
                </div>
            </c:when>
            <c:otherwise>
                <div>
                    <h2 style="width:1200px; text-align: center;color: orangered;margin-top: 100px">暂时没有符合条件的商品！</h2>
                </div>
            </c:otherwise>
        </c:choose>
    </div>
</div>
</body>

<script type="text/javascript">
    function mysubmit() {
        $("#myform").submit();
    }

    //批量删除
    function deleteBatch() {
        //选中状态的个数
        var cks = $("input[name = 'ck']:checked");
        if(cks.length == 0){
            alert("请选择将要删除的商品！")
        }else {
            var str = "";
            var pid = "";

            if(confirm("确定要删除"+cks.length+"条商品吗？")){
                $.each(cks,function (){
                    pid = $(this).val();
                    if(pid != null){
                        str += pid + ",";
                    }
                });
                //发送请求
                $.ajax({
                    url:"${pageContext.request.contextPath}/prod/deleteBatch.action",
                    type:"post",
                    data:{"ids":str},
                    dataType: "text",
                    success:function (msg) {
                        alert(msg)
                        //加载此页面的 table标签中的内容
                        $("#table").load("http://localhost:8080/mimissm/admin/product.jsp #table");
                    }
                })

            }
        }

    }
    //单个删除
    function del(pid, page) {

        var pname = $("#pname").val();
        var typeid = $("#typeid").val();
        var lprice = $("#lprice").val();
        var hprice = $("#hprice").val();

        if (confirm("确定删除吗?")) {
          //向服务器提交请求完成删除
          <%--  window.location="${pageContext.request.contextPath}/prod/delete.action?pid="+pid;--%>
            $.ajax({
                url:"${pageContext.request.contextPath}/prod/delete.action",
                data: {"pid":pid,"page":page,"pname":pname,"typeid":typeid,"lprice":lprice,"hprice":hprice},
                type: "post",
                dataType:"text",
                success:function (msg) {
                    alert(msg);
                    $("#table").load("http://localhost:8080/mimissm/admin/product.jsp #table");
                }

            })
        }
    }

    function one(pid,page) {
        var pname = $("#pname").val();
        var typeid = $("#typeid").val();
        var lprice = $("#lprice").val();
        var hprice = $("#hprice").val();

        var str = "?pid="+pid+"&page="+page+"&pname="+pname+"&typeid="+typeid+"&lprice="+lprice+"&hprice="+hprice;
        location.href = "${pageContext.request.contextPath}/prod/one.action" + str;
    }
</script>
<!--分页的AJAX实现-->
<script type="text/javascript">
    function ajaxsplit(page) {

        var pname = $("#pname").val();
        var typeid = $("#typeid").val();
        var lprice = $("#lprice").val();
        var hprice = $("#hprice").val();

        //异步ajax分页请求
      $.ajax({
          url:"${pageContext.request.contextPath}/prod/ajaxsplit.action",
          data:{"page":page,"pname":pname,"typeid":typeid,"lprice":lprice,"hprice":hprice},
          type:"post",
          success:function (){
              //重新加载，显示分页数据的容器
              $("#table").load("http://localhost:8080/mimissm/admin/product.jsp #table");
          }
      });
    }

</script>

</html>