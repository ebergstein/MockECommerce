<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Online Store</title>
</head>
<body>
	<table>
		<thead>
			<tr>
				<th>Name</th>
				<th>Description</th>
				<th>Price</th>
				<th>Actions</th>
			</tr>
		</thead>
		<tbody id = "producttable">
		<c:forEach items="${products}" var="product" varStatus="loop">
			<tr>      
    			<td><p>${product.name}</p></td>
    			<td><p>${product.description}</p></td>
    			<td><p>${product.price}</p></td>
    			<td><a href = '/add/${product.id}'>Purchase</a></td>
			</tr>
		</c:forEach>
		</tbody>
	</table>
	<a href = '/checkout'>Checkout</a>
	<!--
	<form method = "POST" action = "/addproduct">
		<label>Name: <input type = "text" name = "name"/></label>
    	<label>Description: <textarea name = "description"></textarea></label>
    	<label>Price: <input type = "text" name = "price"/></label>
    	<input type="submit" value="Create"/>
    </form>
    -->
</body>
</html>