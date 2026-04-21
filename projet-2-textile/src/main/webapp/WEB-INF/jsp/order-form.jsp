<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Nouvelle commande</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="<%= request.getContextPath() %>/css/style.css">
</head>
<body>
<div class="container py-4">
    <div class="card">
        <div class="card-header">
            <h1 class="h4 mb-0">Nouvelle commande client</h1>
        </div>
        <div class="card-body">
            <form method="post" action="<%= request.getContextPath() %>/orders">
                <div class="row g-3">
                    <div class="col-md-6">
                        <label class="form-label">Nom client</label>
                        <input class="form-control" name="clientName" required>
                    </div>
                    <div class="col-md-6">
                        <label class="form-label">Type article/modele</label>
                        <input class="form-control" name="articleType" required>
                    </div>
                    <div class="col-md-4">
                        <label class="form-label">Quantite</label>
                        <input type="number" min="1" class="form-control" name="quantity" required>
                    </div>
                    <div class="col-md-4">
                        <label class="form-label">Taille/Couleur</label>
                        <input class="form-control" name="sizeColor">
                    </div>
                    <div class="col-md-4">
                        <label class="form-label">Date livraison prevue</label>
                        <input type="date" class="form-control" name="expectedDeliveryDate" required>
                    </div>
                </div>
                <div class="mt-3 d-flex gap-2">
                    <button class="btn btn-primary" type="submit">Enregistrer</button>
                    <a class="btn btn-outline-primary" href="<%= request.getContextPath() %>/">Retour</a>
                </div>
            </form>
        </div>
    </div>
</div>
</body>
</html>