<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Cart</title>
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
	<script type="text/javascript" src="https://js.stripe.com/v1/"></script>
    <script type="text/javascript">
    
    Stripe.setPublishableKey('pk_test_XejBLABqaQJsXSmzUSPpcqEZ');

    function stripeResponseHandler(status, response) {
        if (response.error) {
            // re-enable the submit button
            $('.submit-button').removeAttr("disabled");
            // show the errors on the form
            $(".payment-errors").html(response.error.message);
        } else {
            var form$ = $("#payment-form");
            // token contains id, last4, and card type
            var token = response['id'];
            // insert the token into the form so it gets submitted to the server
            form$.append("<input type='hidden' name='stripeToken' value='" + token + "' />");
            // and submit
            form$.get(0).submit();
            $(".payment-errors").html("<p>Payment Successful with test card.</p>");
        }
    }
    $(document).ready(function() {
        $("#payment-form").submit(function(event) {
            // disable the submit button to prevent repeated clicks
            $('.submit-button').attr("disabled", "disabled");
            var chargeAmount = $('.payment').val(); //amount you want to charge, in cents. 1000 = $10.00, 2000 = $20.00 ...
            // createToken returns immediately - the supplied callback submits the form if there are no errors
            Stripe.createToken({
                number: '4242424242424242',
                cvc: '789',
                exp_month: '02',
                exp_year: '2022'
            }, chargeAmount, stripeResponseHandler);
            return false; // submit from callback
        });
    });
    if (window.location.protocol === 'file:') {
        alert("stripe.js does not work when included in pages served over file:// URLs. Try serving this page over a webserver. Contact support@stripe.com if you need assistance.");
    }
	</script>
</head>
<body>
<body>
	<a href = '/'>Home</a>
	<table>
		<thead>
			<tr>
				<th>Name</th>
				<th>Description</th>
				<th>Price</th>
				<th>Stock</th>
				<th>Actions</th>
			</tr>
		</thead>
		<tbody id = "producttable">
		<c:forEach items="${products}" var="product" varStatus="loop">
			<tr>      
    			<td><p>${product.name}</p></td>
    			<td><p>${product.description}</p></td>
    			<td><p>${product.price}</p></td>
    			<td><p>${cart.get(product.id)}</p></td>
    			<td><a href = '/delete/${product.id}'>Delete</a></td>
			</tr>
		</c:forEach>
		</tbody>
	</table>
	<p>Total Price: ${total}</p>
	<span class="payment-errors"></span>
    <form method="POST" id="payment-form">
    	<input type = "hidden" value = "${total}" class = "payment"/>
        <button type="submit" class="submit-button">Submit Payment</button>
	</form>
	<a href = '/delete'>Clear Cart</a>
</body>
</html>