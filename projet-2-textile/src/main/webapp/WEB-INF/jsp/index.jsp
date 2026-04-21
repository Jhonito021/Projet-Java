<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Nouvelle commande textile</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
</head>
<body>
<div class="container py-4">
    <div class="card">
        <div class="card-header">
            <h2 class="h4 mb-0">Nouvelle commande</h2>
        </div>
        <div class="card-body">
            <form action="${pageContext.request.contextPath}/saveOrder" method="post">
                <div class="mb-3">
                    <label for="clientName" class="form-label">Nom du client</label>
                    <input type="text" class="form-control" id="clientName" name="clientName" required>
                </div>
                <div class="mb-3">
                    <label for="articleType" class="form-label">Type d'article</label>
                    <select class="form-select" id="articleType" name="articleType" required>
                        <option value="T-shirt">T-shirt</option>
                        <option value="Pantalon">Pantalon</option>
                        <option value="Robe">Robe</option>
                    </select>
                </div>
                <div class="mb-3">
                    <label for="quantity" class="form-label">Quantité</label>
                    <input type="number" class="form-control" id="quantity" name="quantity" required>
                </div>
                <div class="mb-3">
                    <label for="deliveryDate" class="form-label">Date de livraison prévue</label>
                    <input type="date" class="form-control" id="deliveryDate" name="deliveryDate" required>
                </div>
                <button type="submit" class="btn btn-primary">Enregistrer</button>
                <a href="${pageContext.request.contextPath}/orders" class="btn btn-outline-primary">Annuler</a>
            </form>
        </div>
    </div>
</div>
</body>
</html>